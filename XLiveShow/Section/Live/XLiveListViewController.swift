//
//  XLiveListViewController.swift
//  XLiveShow
//
//  Created by sajiner on 2016/12/13.
//  Copyright © 2016年 sajiner. All rights reserved.
//

import UIKit

fileprivate let kWaterfallCellID = "kWaterfallCellID"
class XLiveListViewController: UIViewController {

    var titleModel: XTitleModel!
    
    fileprivate lazy var liveViewModel: XLiveViewModel = XLiveViewModel()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = XWaterfallFlowLayout()
        layout.dataSource = self
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "XLiveListCell", bundle: nil), forCellWithReuseIdentifier: kWaterfallCellID)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        loadData(index: 0)
    }

}

extension XLiveListViewController {
    fileprivate func loadData(index : Int) {
        liveViewModel.loadLiveData(type: titleModel, index: index, finishedCallback: {
            self.collectionView.reloadData()
        })
    }
}

extension XLiveListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return liveViewModel.liveModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kWaterfallCellID, for: indexPath) as! XLiveListCell
        
        cell.liveModel = liveViewModel.liveModels[indexPath.item]
        
        if indexPath.item == liveViewModel.liveModels.count - 1 {
            loadData(index: liveViewModel.liveModels.count)
        }
        
        return cell
    }
}

extension XLiveListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let liveVc = XRoomViewController()
        liveVc.liveModel = liveViewModel.liveModels[indexPath.item]
        navigationController?.pushViewController(liveVc, animated: true)
    }
}

extension XLiveListViewController: XWaterfallFlowLayoutDataSource {
    func numberOfCols(_ waterfall: XWaterfallFlowLayout) -> Int {
        return 2
    }
    
    func waterfall(_ waterfall: XWaterfallFlowLayout, item: Int) -> CGFloat {
        return item % 2 == 0 ? kScreenWidth * 2 / 3 : kScreenWidth * 0.5
    }
}
