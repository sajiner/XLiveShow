//
//  XGiftChannelView.swift
//  XLiveShow
//
//  Created by sajiner on 2016/12/20.
//  Copyright © 2016年 sajiner. All rights reserved.
//

import UIKit

enum XGiftChannelState {
    case idle, animating, willEnd, endAnimating
}

class XGiftChannelView: UIView, XNibLoadable {

    // MARK: 控件属性
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var giftDescLabel: UILabel!
    @IBOutlet weak var giftImageView: UIImageView!
    @IBOutlet weak var digitLabel: XDigitLabel!
    
    fileprivate var currentNumber: Int = 0
    fileprivate var cacheNumber = 0
    var complection: ((XGiftChannelView)->())?
    var state: XGiftChannelState = .idle
    
    var giftModel: XGiftModel? {
        didSet {
            guard let giftModel = giftModel else {
                return
            }
            iconImageView.image = UIImage(named: giftModel.senderURL)
            senderLabel.text = giftModel.senderName
            giftDescLabel.text = "送出礼物：【\(giftModel.giftName)】"
            giftImageView.setImage(giftModel.giftURL, "room_btn_gift")
            
            state = .animating
            self.performAnimation()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bgView.layer.cornerRadius = frame.height * 0.5
        bgView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = frame.height * 0.5
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.borderWidth = 1
        iconImageView.layer.borderColor = UIColor.green.cgColor
    }
    
}

extension XGiftChannelView {
    func addOnceToCache() {
        if state == .willEnd {
            performDigitAnimation()
            NSObject.cancelPreviousPerformRequests(withTarget: self)
        } else {
            cacheNumber += 1
        }
    }
}

//MARK: - 动画设置
extension XGiftChannelView {
    fileprivate func performAnimation() {
        digitLabel.text = " x1 "
        digitLabel.alpha = 1.0
        
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 1.0
            self.frame.origin.x = 0
        }, completion: { (isFinished) in
           self.performDigitAnimation()
        })
    }
    
    fileprivate func performDigitAnimation() {
        currentNumber += 1
        digitLabel.text = " x\(currentNumber) "
        digitLabel.showDigitLabelAnimation {
            if self.cacheNumber > 0 {
                self.cacheNumber -= 1
                self.performDigitAnimation()
            } else {
                self.state = .willEnd
                self.perform(#selector(self.performEndAnimation), with: nil, afterDelay: 3.0)
            }
        }
    }
    
    @objc fileprivate func performEndAnimation() {
        state = .endAnimating
        
        UIView.animate(withDuration: 0.25, animations: {
            self.frame.origin.x = kScreenWidth
            self.alpha = 0
        }, completion: { (isFinished) in
            self.frame.origin.x = -self.bounds.width
            self.digitLabel.alpha = 0
            self.currentNumber = 0
            self.giftModel = nil
            self.state = .idle
            self.cacheNumber = 0
            
            guard let complection = self.complection else { return }
            complection(self)
        })
    }
}
