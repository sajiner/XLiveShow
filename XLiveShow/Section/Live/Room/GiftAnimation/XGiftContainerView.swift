//
//  XGiftContainerView.swift
//  XLiveShow
//
//  Created by sajiner on 2016/12/20.
//  Copyright © 2016年 sajiner. All rights reserved.
//

import UIKit

class XGiftContainerView: UIView {
    
    fileprivate var style: XChannelViewStyle
    fileprivate lazy var cacheGiftModels: [XGiftModel] = [XGiftModel]()
    fileprivate lazy var channelViews: [XGiftChannelView] = [XGiftChannelView]()
    
    
    init(frame: CGRect, style: XChannelViewStyle) {
        self.style = style
        super.init(frame: frame)
    
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - 对外开放的方法
extension XGiftContainerView {
    func showGiftModel(_ giftModel: XGiftModel) {
        // 判断是否是正在显示的channelViw
        if let channelView = checkUsingChannelView(giftModel) {
            channelView.addOnceToCache()
            return
        }
        // 判断是否有闲置的channelViw
        if let channelView = checkIdleChannelView(giftModel) {
            channelView.giftModel = giftModel
            return
        }
        cacheGiftModels.append(giftModel)
    }
    
    private func checkUsingChannelView(_ giftModel: XGiftModel) -> XGiftChannelView? {
        
        for channelView in channelViews {
            if giftModel.isEqual(channelView.giftModel) && channelView.state != .endAnimating {
                return channelView
            }
        }
        return nil
    }
    
    private func checkIdleChannelView(_ giftModel: XGiftModel) -> XGiftChannelView? {
        for channelView in channelViews {
            if channelView.state == .idle {
                return channelView
            }
        }
        return nil
    }
}

extension XGiftContainerView {
    fileprivate func setupUI() {
        let x: CGFloat = -frame.width
        let w: CGFloat = frame.width
        let h: CGFloat = style.channelHeight
        
        for i in 0..<style.channelCount {
            let channelView = XGiftChannelView.loadFromNib()
            let y: CGFloat = (style.channelHeight + style.channelMargin) * CGFloat(i)
            channelView.frame = CGRect(x: x, y: y, width: w, height: h)
            addSubview(channelView)
            channelViews.append(channelView)
            
            channelView.complection = { channelView in
                guard self.cacheGiftModels.count != 0 else { return }
                let firstGiftModel = self.cacheGiftModels.first!
                self.cacheGiftModels.removeFirst()
                channelView.giftModel = firstGiftModel
                
                for i in (0..<self.cacheGiftModels.count).reversed() {
                    let giftModel = self.cacheGiftModels[i]
                    if giftModel.isEqual(firstGiftModel) {
                        channelView.addOnceToCache()
                        self.cacheGiftModels.remove(at: i)
                    }
                }
            }
        }
    }
}
