//
//  GiftListView.swift
//  XMGTV
//
//  Created by apple on 16/11/13.
//  Copyright © 2016年 coderwhy. All rights reserved.
//

import UIKit

private let kGiftCellID = "kGiftCellID"

protocol GiftListViewDelegate : class {
    func giftListView(_ giftView : GiftListView, giftModel : GiftModel)
}

class GiftListView: UIView, XNibLoadable {
    // MARK: 控件属性
    @IBOutlet weak var giftView: UIView!
    @IBOutlet weak var sendGiftBtn: UIButton!
    
    weak var delegate : GiftListViewDelegate?
    
    fileprivate var pageCollectionView : XPageCollectionView!
    fileprivate var giftVM : GiftViewModel = GiftViewModel()
    fileprivate var currentIndexPath : IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 1.初始化礼物的View
        setupGiftView()
        
        loadGiftData()
    }
}

extension GiftListView {
    fileprivate func setupUI() {
        setupGiftView()
    }
    
    fileprivate func setupGiftView() {
        let style = XTitleStyle()
        style.isScroll = false
        style.isShowBottomLine = true
        style.norColor = UIColor(255, 255, 255)
        
        let layout = XPageCollectionFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.cols = 4
        layout.rows = 2
        
        var pageViewFrame = giftView.bounds
        pageViewFrame.size.width = kScreenWidth
        pageCollectionView = XPageCollectionView(frame: pageViewFrame, titles: ["热门", "高级", "豪华", "专属"], titleStyle: style, isTitleInTop: true, layout: layout)
        giftView.addSubview(pageCollectionView)
        
        pageCollectionView.dataSource = self
        pageCollectionView.delegate = self
        
        pageCollectionView.register(nib: UINib(nibName: "GiftViewCell", bundle: nil), identifier: kGiftCellID)
    }
}

// MARK:- 送礼物
extension GiftListView {
    @IBAction func sendGiftBtnClick() {
        let package = giftVM.giftlistData[currentIndexPath!.section]
        let giftModel = package.list[currentIndexPath!.item]
        delegate?.giftListView(self, giftModel: giftModel)
    }
}

// MARK:- 加载数据
extension GiftListView {
    fileprivate func loadGiftData() {
        giftVM.loadGiftData {
            self.pageCollectionView.reloadData()
        }
    }
}

extension GiftListView: XPageCollectionViewDataSource, XPageCollectionViewDelegate {
    func numberOfSections(in pageCollectionView: XPageCollectionView) -> Int {
        return giftVM.giftlistData.count
    }
    
    func pageCollectionView(_ pageCollectionView: XPageCollectionView, numberOfItemsInSection section: Int) -> Int {
        let package = giftVM.giftlistData[section]
        return package.list.count
    }
    
    func pageCollectionView(_ collectionView: UICollectionView, pageCollectionView: XPageCollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGiftCellID, for: indexPath) as! GiftViewCell
        let package = giftVM.giftlistData[indexPath.section]
        cell.giftModel = package.list[indexPath.item]
        return cell
    }
    
    func pageCollectionView(_ pageCollectionView: XPageCollectionView, didSelectItemAt indexPath: IndexPath) {
        sendGiftBtn.isEnabled = true
        currentIndexPath = indexPath
    }
}



