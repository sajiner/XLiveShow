//
//  EmoticonView.swift
//  XMGTV
//
//  Created by 小码哥 on 2016/12/11.
//  Copyright © 2016年 coderwhy. All rights reserved.
//

import UIKit

private let kEmoticonCellID = "kEmoticonCellID"

class EmoticonView: UIView {
    
    var emoticonClickCallBack: ((Emoticon)->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension EmoticonView {
    fileprivate func setupUI() {
        let style = XTitleStyle()
        style.isShowBottomLine = true
        let layout = XPageCollectionFlowLayout()
        layout.cols = 7
        layout.rows = 3
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let pageCollectionView = XPageCollectionView(frame: bounds, titles: ["普通", "粉丝专属"], titleStyle: style, isTitleInTop: false, layout: layout)
        
        addSubview(pageCollectionView)
        
        pageCollectionView.dataSource = self
        pageCollectionView.delegate = self
        pageCollectionView.register(nib: UINib(nibName: "EmoticonViewCell", bundle: nil), identifier: kEmoticonCellID)
    }
}


extension EmoticonView : XPageCollectionViewDataSource, XPageCollectionViewDelegate {
    func numberOfSections(in pageCollectionView: XPageCollectionView) -> Int {
        return EmoticonViewModel.shareInstance.packages.count
    }
    
    func pageCollectionView(_ pageCollectionView: XPageCollectionView, numberOfItemsInSection section: Int) -> Int {
        return EmoticonViewModel.shareInstance.packages[section].emoticons.count
    }
    
    func pageCollectionView(_ collectionView: UICollectionView, pageCollectionView: XPageCollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kEmoticonCellID, for: indexPath) as! EmoticonViewCell
        cell.emoticon = EmoticonViewModel.shareInstance.packages[indexPath.section].emoticons[indexPath.item]
        return cell
    }
    
    func pageCollectionView(_ pageCollectionView: XPageCollectionView, didSelectItemAt indexPath: IndexPath) {
        let emoticon = EmoticonViewModel.shareInstance.packages[indexPath.section].emoticons[indexPath.item]
        guard let emoticonClickCallBack = emoticonClickCallBack else { return }
        emoticonClickCallBack(emoticon)
    }
}
