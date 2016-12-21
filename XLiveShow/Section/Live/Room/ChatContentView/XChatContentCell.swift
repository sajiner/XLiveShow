//
//  XChatContentCell.swift
//  XLiveShow
//
//  Created by sajiner on 2016/12/20.
//  Copyright © 2016年 sajiner. All rights reserved.
//

import UIKit

class XChatContentCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.clear
        contentLabel.textColor = UIColor.white
        contentLabel.font = UIFont.systemFont(ofSize: 15)
        selectionStyle = .none
        contentView.backgroundColor = UIColor.clear
    }
}
