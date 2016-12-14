//
//  XNavigationController.swift
//  XLiveShow
//
//  Created by sajiner on 2016/12/13.
//  Copyright © 2016年 sajiner. All rights reserved.
//

import UIKit

class XNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let gesture = interactivePopGestureRecognizer else { return }
        gesture.isEnabled = false
        let gestureView = gesture.view
        
        //        var count : UInt32 = 0
        //        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
        //        for i in 0..<count {
        //            let ivar = ivars[Int(i)]
        //            let name = ivar_getName(ivar)
        //            print(String(cString: name!))
        //        }
        
        let target = (gesture.value(forKey: "_targets") as? [NSObject])?.first
        guard let transition = target?.value(forKey: "_target") else { return }
        let action = Selector(("handleNavigationTransition:"))
        
        let popGes = UIPanGestureRecognizer()
        popGes.maximumNumberOfTouches = 1
        gestureView?.addGestureRecognizer(popGes)
        popGes.addTarget(transition, action: action)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: true)
        
        
    }
}
