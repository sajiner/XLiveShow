
//
//  UIColor+Extension.swift
//  XPageView
//
//  Created by sajiner on 2016/12/5.
//  Copyright © 2016年 sajiner. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
   class func randomColor() -> UIColor {
        return UIColor(CGFloat(arc4random_uniform(256)), CGFloat(arc4random_uniform(256)), CGFloat(arc4random_uniform(256)))
    }
    
   class func getRGBDelta(_ firstColor: UIColor, _ secondColor: UIColor) -> (CGFloat, CGFloat, CGFloat) {
        let firstRGB = firstColor.getRGB()
        let secondRGB = secondColor.getRGB()
        return (firstRGB.0 - secondRGB.0, firstRGB.1 - secondRGB.1, firstRGB.2 - secondRGB.2)
    }
    
    func getRGB() -> (CGFloat, CGFloat, CGFloat) {
        guard let cmps = cgColor.components else {
            fatalError("保证普通颜色时RGB方式传入的")
        }
        return (cmps[0] * 255, cmps[1] * 255, cmps[2] * 255)
    }
}
