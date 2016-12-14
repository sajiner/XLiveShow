//
//  XWaterfallFlowLayout.swift
//  XLiveShow
//
//  Created by sajiner on 2016/12/13.
//  Copyright © 2016年 sajiner. All rights reserved.
//

import UIKit

protocol XWaterfallFlowLayoutDataSource: class {
    /// 一共有多少列
    func numberOfCols(_ waterfallLayout: XWaterfallFlowLayout) -> Int
    /// 每个cell的高度
    func waterfall(_ waterfallLayout: XWaterfallFlowLayout, item: Int) -> CGFloat
}

class XWaterfallFlowLayout: UICollectionViewFlowLayout {
    
    weak var dataSource: XWaterfallFlowLayoutDataSource?
    
    fileprivate lazy var cols: Int = {
        return self.dataSource?.numberOfCols(self) ?? 2
    }()
    
    fileprivate var cellAttrs = [UICollectionViewLayoutAttributes]()
    fileprivate lazy var totalHeights: [CGFloat] = Array(repeating: self.sectionInset.top, count: self.cols)
}

extension XWaterfallFlowLayout {
    override func prepare() {
        guard let collectionView = collectionView else {
            return
        }
        /// 获取cell的个数
        let cellCounts = collectionView.numberOfItems(inSection: 0)
        let cellW = (collectionView.bounds.width - sectionInset.left - sectionInset.right - CGFloat(cols - 1) * minimumInteritemSpacing) / CGFloat(cols)
        
        for i in cellAttrs.count..<cellCounts {
            let indexPath = IndexPath(item: i, section: 0)
            let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            guard let cellH = dataSource?.waterfall(self, item: i) else {
                fatalError("请实现cell的数据源方法")
            }
            let minH = totalHeights.min()!
            let minIndex = totalHeights.index(of: minH)!
            let cellX = sectionInset.left + (cellW + minimumInteritemSpacing) * CGFloat(minIndex)
            let cellY = minH + minimumLineSpacing
            attr.frame = CGRect(x: cellX, y: cellY, width: cellW, height: cellH)
            cellAttrs.append(attr)
            
            totalHeights[minIndex] = minH + minimumLineSpacing + cellH
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cellAttrs
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: totalHeights.max()! + sectionInset.bottom)
    }
}
