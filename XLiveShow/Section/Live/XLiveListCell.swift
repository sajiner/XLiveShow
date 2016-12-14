//
//  XLiveListCell.swift
//  XLiveShow
//
//  Created by sajiner on 2016/12/13.
//  Copyright © 2016年 sajiner. All rights reserved.
//

import UIKit

class XLiveListCell: UICollectionViewCell {
    // MARK: 控件属性
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var liveImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlinePeopleLabel: UIButton!
    
    // MARK: 定义属性
    var liveModel : XLiveListModel? {
        didSet {
            albumImageView.setImage(liveModel!.isEvenIndex ? liveModel?.pic74 : liveModel?.pic51, "home_pic_default")
            liveImageView.isHidden = liveModel?.live == 0
            nickNameLabel.text = liveModel?.name
            onlinePeopleLabel.setTitle("\(liveModel?.focus ?? 0)", for: .normal)
        }
    }
}
