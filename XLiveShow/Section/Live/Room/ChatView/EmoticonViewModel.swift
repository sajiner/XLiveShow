//
//  EmoticonViewModel.swift
//  XLiveShow
//
//  Created by sajiner on 2016/12/15.
//  Copyright © 2016年 sajiner. All rights reserved.
//

import UIKit

class EmoticonViewModel {
    static let shareInstance : EmoticonViewModel = EmoticonViewModel()
    lazy var packages : [EmoticonPackage] = [EmoticonPackage]()
    
    init() {
        packages.append(EmoticonPackage(plistName: "QHNormalEmotionSort.plist"))
        packages.append(EmoticonPackage(plistName: "QHSohuGifSort.plist"))
    }
}
