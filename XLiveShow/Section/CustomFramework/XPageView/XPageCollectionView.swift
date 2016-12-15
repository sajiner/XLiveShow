//
//  XPageCollectionView.swift
//  XPageView
//
//  Created by sajiner on 2016/12/14.
//  Copyright © 2016年 sajiner. All rights reserved.
//

import UIKit

protocol XPageCollectionViewDataSource: class {
    func numberOfSections(in pageCollectionView: XPageCollectionView) -> Int
    func pageCollectionView(_ pageCollectionView: XPageCollectionView, numberOfItemsInSection section: Int) -> Int
    func pageCollectionView(_ collectionView: UICollectionView, pageCollectionView: XPageCollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

protocol XPageCollectionViewDelegate: class {
     func pageCollectionView(_ pageCollectionView: XPageCollectionView, didSelectItemAt indexPath: IndexPath)
}

class XPageCollectionView: UIView {
    
    weak var dataSource: XPageCollectionViewDataSource?
    weak var delegate: XPageCollectionViewDelegate?
    
    fileprivate var currentIndexPath = IndexPath(item: 0, section: 0)
    fileprivate var isTitleInTop = false
    fileprivate var titles: [String]
    fileprivate var layout: XPageCollectionFlowLayout
    fileprivate var titleStyle: XTitleStyle
    fileprivate var pageControl: UIPageControl!
    fileprivate var collectionView: UICollectionView!
    fileprivate var titleView: XTitleView!
    
    init(frame: CGRect, titles: [String], titleStyle: XTitleStyle, isTitleInTop: Bool, layout: XPageCollectionFlowLayout) {
        self.titles = titles
        self.isTitleInTop = isTitleInTop
        self.titleStyle = titleStyle
        self.layout = layout
        
        super.init(frame: frame)
        
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - 对外暴露的方法
extension XPageCollectionView {
    func register(cellClass: AnyClass?, identifier: String) {
        collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    func register(nib: UINib?, identifier: String) {
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}

extension XPageCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource?.numberOfSections(in: self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let items = dataSource?.pageCollectionView(self, numberOfItemsInSection: section) ?? 0
        if section == 0 {
            pageControl.numberOfPages = (items - 1) / (layout.cols * layout.rows) + 1
        }
        return items
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dataSource!.pageCollectionView(collectionView, pageCollectionView: self, cellForItemAt: indexPath)
        return cell
    }
}

extension XPageCollectionView: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewEndScroll()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewEndScroll()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.pageCollectionView(self, didSelectItemAt: indexPath)
    }
    
}

extension XPageCollectionView: XTitleViewDelegate {

    func titleView(_ titleView: XTitleView, targetIndex: Int) {
        let indexPath = IndexPath(item: 0, section: targetIndex)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        collectionView.contentOffset.x -= layout.sectionInset.left

        scrollViewEndScroll()
    }
}

extension XPageCollectionView {
    fileprivate func scrollViewEndScroll() {
        let point = CGPoint(x: layout.sectionInset.left + collectionView.contentOffset.x + 1, y: layout.sectionInset.top + 1)
        guard let indexPath = collectionView.indexPathForItem(at: point) else { return }
        if currentIndexPath.section != indexPath.section {
            let countItems = dataSource?.pageCollectionView(self, numberOfItemsInSection: indexPath.section) ?? 0
            pageControl.numberOfPages = (countItems - 1) / (layout.cols * layout.rows) + 1
            titleView.setTitleWithProgress(1.0, sourceIndex: currentIndexPath.section, targetIndex: indexPath.section)
            currentIndexPath = indexPath
        }
        pageControl.currentPage = indexPath.item / (layout.cols * layout.rows)
    }
}

extension XPageCollectionView {
    fileprivate func setupSubViews() {
        /// titleView
        let titleH = titleStyle.isShowBottomLine ? titleStyle.titleHeight + titleStyle.bottomLineHeight : titleStyle.titleHeight
        let titleY = isTitleInTop ? 0 : (bounds.height - titleH)
        let titleFrame = CGRect(x: 0, y: titleY, width: kScreenWidth, height: titleH)
        titleView = XTitleView(frame: titleFrame, titles: titles, titleStyle: titleStyle)
        titleView.delegate = self
        addSubview(titleView)
        
        /// pageControl
        let pageControlH: CGFloat = 20
        let pageControlY = isTitleInTop ? (bounds.height - pageControlH) : (bounds.height - pageControlH - titleH)
        pageControl = UIPageControl(frame: CGRect(x: 0, y: pageControlY, width: kScreenWidth, height: pageControlH))
        addSubview(pageControl)
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = UIColor.white
        
        /// collectionView
        let collectionViewY = isTitleInTop ? titleView.frame.maxY : 0
        let collectionViewFrame = CGRect(x: 0, y: collectionViewY, width: kScreenWidth, height: (bounds.height - titleH - pageControlH))
        collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: layout)
        addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
    }
}
