//
//  XTitleModel.swift
//  XLiveShow
//
//  Created by sajiner on 2016/12/13.
//  Copyright © 2016年 sajiner. All rights reserved.
//

import UIKit

class XTitleModel: NSObject {

    var title: String = ""
    var type: NSNumber = 0
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
