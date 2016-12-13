//
//  XTabBarController.swift
//  XLiveShow
//
//  Created by sajiner on 2016/12/13.
//  Copyright © 2016年 sajiner. All rights reserved.
//

import UIKit

class XTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVc("XLiveViewController")
        addChildVc("XRankViewController")
        addChildVc("XFindViewController")
        addChildVc("XMineViewController")
    }
}

extension XTabBarController {
   fileprivate func addChildVc(_ storyboardName: String) {
        guard let childVc = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController() else { return }
        addChildViewController(childVc)
    }
}
