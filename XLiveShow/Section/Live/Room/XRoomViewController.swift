//
//  XRoomViewController.swift
//  XLiveShow
//
//  Created by sajiner on 2016/12/14.
//  Copyright © 2016年 sajiner. All rights reserved.
//

import UIKit

class XRoomViewController: UIViewController {

    // MARK: 控件属性
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var roomNumLabel: UILabel!
    @IBOutlet weak var onlineLabel: UILabel!
    
    // MARK: 对外提供控件属性
    var liveModel : XLiveListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置内容
        setupAnchorInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK:- 设置内容
extension XRoomViewController {
    fileprivate func setupAnchorInfo() {
        bgImageView.setImage(liveModel?.pic74)
        nickNameLabel.text = liveModel?.name
        roomNumLabel.text = "房间号：\(liveModel!.roomid)"
        iconImageView.setImage(liveModel?.pic51)
        onlineLabel.text = "\(liveModel!.focus)"
    }
}


// MARK:- 事件监听函数
extension XRoomViewController {
    @IBAction func closeBtnClick() {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func focusBtnClick(btn : UIButton) {
    }
}

// MARK:- 底部菜单的点击
extension XRoomViewController: XAnimatorManager {
    @IBAction func starItemClick(starItem : UIButton) {
        starItem.isSelected = !starItem.isSelected
        let point = CGPoint(x: starItem.center.x, y: view.bounds.height - starItem.bounds.height * 0.5)
        starItem.isSelected ? startEmittering(point, cellCounts: 10) : stopEmittering()
    }
    
    @IBAction func moreItemClick() {
    }
    
    @IBAction func giftItemClick() {
    }
    
    @IBAction func shareItemClick() {
    }
    
    @IBAction func chatItemClick() {
        
    }
}











