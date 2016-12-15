//
//  XNibLoadable.swift
//  XLiveShow
//
//  Created by sajiner on 2016/12/15.
//  Copyright © 2016年 sajiner. All rights reserved.
//

import UIKit

protocol XNibLoadable {
    
}

extension XNibLoadable where Self: UIView {
    static func loadFromNib(_ nibName: String? = nil) -> Self {
        let loadName = nibName == nil ? "\(self)" : nibName!
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)?.first as! Self
    }
}
