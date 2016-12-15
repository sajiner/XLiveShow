//
//  XContentView.swift
//  XLiveShow
//
//  Created by sajiner on 2016/12/13.
//  Copyright © 2016年 sajiner. All rights reserved.
//

import UIKit

protocol XContentViewDelegate: class {
    func contentView(contentView: XContentView, targetIndex: Int)
    func contentView(contentView: XContentView, targetIndex: Int, progress: CGFloat)
}

private let kPageCellId = "kPageCellId"
class XContentView: UIView {
    
    weak var delegate: XContentViewDelegate?
    fileprivate var startOffsetX : CGFloat = 0
    fileprivate var isForbidScroll = false
    fileprivate var childVcs: [UIViewController]
    fileprivate var parentVc: UIViewController
    
    fileprivate lazy var collectionView: UICollectionView = {
       let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: XPageFlowLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollsToTop = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kPageCellId)
        return collectionView
    }()

    init(frame: CGRect, childVcs: [UIViewController], parentVc: UIViewController) {
        self.childVcs = childVcs
        self.parentVc = parentVc
        
        super.init(frame: frame)
        
        addSubview(collectionView)
        for vc in childVcs {
            parentVc.addChildViewController(vc)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: - UICollectionViewDataSource
extension XContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPageCellId, for: indexPath)
        
        for childView in cell.contentView.subviews {
            childView.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension XContentView: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        contentEndScroll()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            contentEndScroll()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScroll = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !isForbidScroll else {
            return
        }
        let currentIndex = Int(startOffsetX / CGFloat(kScreenWidth))
        var targetIndex = 0
        
        var detalX = (scrollView.contentOffset.x - startOffsetX) / CGFloat(kScreenWidth)
        if detalX < 0 {
            detalX = -detalX
            targetIndex = currentIndex - 1
            if targetIndex < 0 {
                targetIndex = 0
            }
            
        } else {
            targetIndex = currentIndex + 1
            if targetIndex > childVcs.count - 1 {
                targetIndex = childVcs.count - 1
            }
        }
        delegate?.contentView(contentView: self, targetIndex: targetIndex, progress: detalX)
    }
}

//MARK: - XTitleViewDelegate
extension XContentView: XTitleViewDelegate {
    func titleView(_ titleView: XTitleView, targetIndex: Int) {
        isForbidScroll = true
        collectionView.setContentOffset(CGPoint(x: CGFloat(targetIndex) * kScreenWidth, y: 0), animated: false)
    }
}

//MARK: - 私有方法
extension XContentView {
    fileprivate func contentEndScroll() {
        if isForbidScroll || startOffsetX == collectionView.contentOffset.x  {
            return
        }
        let page = collectionView.contentOffset.x / CGFloat(kScreenWidth)
        delegate?.contentView(contentView: self, targetIndex: Int(page))
    }
}
