//
//  XTitleView.swift
//  XLiveShow
//
//  Created by sajiner on 2016/12/13.
//  Copyright © 2016年 sajiner. All rights reserved.
//

import UIKit

protocol XTitleViewDelegate: class {
    func titleView(_ titleView: XTitleView, targetIndex: Int)
}

class XTitleView: UIView {
    
    weak var delegate: XTitleViewDelegate?
    
    fileprivate var currentIndex = 0
    fileprivate var titles: [String]
    fileprivate var labels = [UILabel]()
    fileprivate lazy var titleStyle: XTitleStyle = XTitleStyle()
    
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    fileprivate lazy var bottomLine: UIView = {
       let bottomLine = UIView()
        bottomLine.frame.size.height = self.titleStyle.bottomLineHeight
        bottomLine.frame.origin.y = self.titleStyle.titleHeight
        bottomLine.backgroundColor = self.titleStyle.selColor
        return bottomLine
    }()
    
    init(frame: CGRect, titles: [String], titleStyle: XTitleStyle) {
        self.titles = titles
        super.init(frame: frame)
        
        self.titleStyle = titleStyle
        addSubview(scrollView)
        setupLabels()
        setupLabelFrames()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - 布局子控件
extension XTitleView {
    fileprivate func setupLabelFrames() {
        let y: CGFloat = 0
        let h: CGFloat = titleStyle.titleHeight
        var w: CGFloat = 0
        var x: CGFloat = 0
        let count = labels.count
        for (i, label) in labels.enumerated() {
            if titleStyle.isScroll { // 可以滚动
                w = (titles[i] as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 0), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: label.font], context: nil).width
                x = i == 0 ? titleStyle.titleMargin * 0.5 : (labels[i - 1].frame.maxX + titleStyle.titleMargin)
                if titleStyle.isShowBottomLine {
                    if i == 0 {
                        bottomLine.frame.size.width = w
                        bottomLine.frame.origin.x = titleStyle.titleMargin * 0.5
                        scrollView.addSubview(bottomLine)
                    }
                }
                
            } else {
                w = kScreenWidth / CGFloat(count)
                x = CGFloat(i) * w
                if titleStyle.isShowBottomLine, i == 0 {
                    bottomLine.frame.size.width = w
                    bottomLine.frame.origin.x = 0
                    scrollView.addSubview(bottomLine)
                }
            }
            
            label.frame = CGRect(x: x, y: y, width: w, height: h)
        }
        scrollView.contentSize = titleStyle.isScroll ? CGSize(width: labels[labels.count - 1].frame.maxX + titleStyle.titleMargin * 0.5, height: 0) : CGSize.zero
    }
    
    fileprivate func setupLabels() {
        for (i, title) in titles.enumerated() {
            let label = UILabel()
            label.text = title
            label.textColor = i == 0 ? titleStyle.selColor : titleStyle.norColor
            label.font = UIFont.systemFont(ofSize: titleStyle.fontSize)
            label.tag = i
            label.textAlignment = .center
            scrollView.addSubview(label)
            labels.append(label)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_:)))
            label.addGestureRecognizer(tap)
            label.isUserInteractionEnabled = true
        }
    }
}

//MARK: - XContentViewDelegate
extension XTitleView: XContentViewDelegate {
    func contentView(_ contentView: XContentView, targetIndex: Int) {
       addjuestTitleLabels(targetIndex)
    }
    
    func contentView(_ contentView: XContentView, targetIndex: Int, progress: CGFloat) {
        let sourceLabel = labels[currentIndex]
        let targetLabel = labels[targetIndex]
        
        let detalRGB = UIColor.getRGBDelta(titleStyle.selColor, titleStyle.norColor)
        let norRGB = titleStyle.norColor.getRGB()
        let selRGB = titleStyle.selColor.getRGB()
        sourceLabel.textColor = UIColor(selRGB.0 - detalRGB.0 * progress, selRGB.1 - detalRGB.1 * progress, selRGB.2 - detalRGB.2 * progress)
        targetLabel.textColor = UIColor(norRGB.0 + detalRGB.0 * progress, norRGB.1 + detalRGB.1 * progress, norRGB.2 + detalRGB.2 * progress)
        if titleStyle.isShowBottomLine {
            let detalW = targetLabel.bounds.width - sourceLabel.bounds.width
            let detalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
            bottomLine.frame.size.width = sourceLabel.bounds.width + detalW * progress
            bottomLine.frame.origin.x = sourceLabel.frame.origin.x + detalX * progress
        }
    }
}

// MARK: - 对外暴露的方法
extension XTitleView {
    func setTitleWithProgress(_ progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        let sourceLabel = labels[sourceIndex]
        let targetLabel = labels[targetIndex]
        
        let deltaRGB = UIColor.getRGBDelta(titleStyle.selColor, titleStyle.norColor)
        let selRGB = titleStyle.selColor.getRGB()
        let norRGB = titleStyle.norColor.getRGB()
        targetLabel.textColor = UIColor(norRGB.0 + deltaRGB.0 * progress, norRGB.1 + deltaRGB.1 * progress, norRGB.2 + deltaRGB.2 * progress)
        sourceLabel.textColor = UIColor(selRGB.0 - deltaRGB.0 * progress, selRGB.1 - deltaRGB.1 * progress, selRGB.2 - deltaRGB.2 * progress)
        
        // botomLine
        if titleStyle.isShowBottomLine {
            let deltaX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
            let deltaW = targetLabel.frame.width - sourceLabel.frame.width
            bottomLine.frame.origin.x = sourceLabel.frame.origin.x + deltaX * progress
            bottomLine.frame.size.width = sourceLabel.frame.width + deltaW * progress
        }
        currentIndex = targetIndex
    }
}

//MARK: - 一些私有方法
extension XTitleView {
    fileprivate func addjuestTitleLabels(_ targetIndex: Int) {
        let sourceLabel = labels[currentIndex]
        let targetLabel = labels[targetIndex]
        
        sourceLabel.textColor = titleStyle.norColor
        targetLabel.textColor = titleStyle.selColor
        
        var offsetX: CGFloat = 0
        if titleStyle.isScroll {  // 滚动
            offsetX = targetLabel.center.x - kScreenWidth * 0.5
            if offsetX < 0 {
                offsetX = 0
            } else if offsetX > scrollView.contentSize.width - kScreenWidth {
                offsetX = scrollView.contentSize.width - kScreenWidth
            }
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            if self.titleStyle.isShowBottomLine {
                self.bottomLine.frame.size.width = targetLabel.bounds.width
                self.bottomLine.frame.origin.x = targetLabel.frame.origin.x
            }
        })
        
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)

        currentIndex = targetIndex
    }
    
    @objc fileprivate func titleLabelClick(_ tap: UITapGestureRecognizer) {
        let targetLabel = tap.view as! UILabel
        addjuestTitleLabels(targetLabel.tag)
        
        delegate?.titleView(self, targetIndex: targetLabel.tag)
    }
}
