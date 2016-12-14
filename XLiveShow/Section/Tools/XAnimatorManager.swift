//
//  XAnimatorManager.swift
//  XLiveShow
//
//  Created by sajiner on 2016/12/14.
//  Copyright © 2016年 sajiner. All rights reserved.
//

import UIKit

protocol XAnimatorManager {
    
}

extension XAnimatorManager where Self: UIViewController {
    func startEmittering(_ point: CGPoint, cellCounts: Int) {
        var cells: [CAEmitterCell] = [CAEmitterCell]()
        let emmiterLayer = CAEmitterLayer()
        emmiterLayer.emitterPosition = point
        emmiterLayer.preservesDepth = true
        
        for i in 0..<cellCounts {
            let cell = CAEmitterCell()
            /// 粒子速度
            cell.velocity = 100
            cell.velocityRange = 50
            /// 粒子缩放比例
            cell.scale = 0.7
            cell.scaleRange = 0.5
            ///
            cell.emissionLongitude = CGFloat(-M_PI_2)
            cell.emissionRange = CGFloat(M_PI_4)
            ///
            cell.lifetime = 5
            cell.lifetimeRange = 4
            ///
            cell.spin = CGFloat(M_PI)
            cell.spinRange = CGFloat(M_PI / 8)
            ///
            cell.birthRate = 2
            
            cell.contents = UIImage(named: "good\(i)_30x30")?.cgImage
            cells.append(cell)
        }
        
        
        emmiterLayer.emitterCells = cells
        view.layer.addSublayer(emmiterLayer)
    }
    
    func stopEmittering() {
        view.layer.sublayers?.filter({ $0.isKind(of: CAEmitterLayer.self)}).first?.removeFromSuperlayer()
    }
}
