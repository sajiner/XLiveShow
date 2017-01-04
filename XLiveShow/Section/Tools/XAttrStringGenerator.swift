//
//  XAttrStringGenerator.swift
//  XLiveShow
//
//  Created by sajiner on 2017/1/4.
//  Copyright © 2017年 sajiner. All rights reserved.
//

import UIKit
import Kingfisher

class XAttrStringGenerator {

}

extension XAttrStringGenerator {
    class func generateTextMessage(_ username: String, _ message: String) -> NSAttributedString {
        // 获取整个字符串
        let chatMsg = "\(username): \(message)"
        let msg = NSMutableAttributedString(string: chatMsg)
        // 将名称改为红色
        msg.addAttributes([NSForegroundColorAttributeName: UIColor.red], range: NSRange(location: 0, length: username.characters.count))
        // 将所有表情匹配出来
        let pattern = "\\[.*?\\]"
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return msg
        }
        let results = regex.matches(in: chatMsg, options: [], range: NSMakeRange(0, chatMsg.characters.count))
        
        for i in (0..<results.count).reversed() {
            let result = results[i]
            let emoticonName = (chatMsg as NSString).substring(with: result.range)
            print(emoticonName)
            guard let image = UIImage(named:emoticonName) else {
                continue
            }
            let attachment = NSTextAttachment()
            attachment.image = image
            let font = UIFont.systemFont(ofSize: 15)
            attachment.bounds = CGRect(x: 0, y: -3, width: font.lineHeight, height: font.lineHeight)
            let imageAttrStr = NSAttributedString(attachment: attachment)
            msg.replaceCharacters(in: result.range, with: imageAttrStr)
        }
        return msg
    }
    
   class func generateGiftMessage(_ username: String, giftModel: XGiftModel) -> NSAttributedString {
        let giftMsg = "\(username) 赠送 \(giftModel.giftName)"
        let giftAttrMsg = NSMutableAttributedString(string: giftMsg)
        // 将名称改为红色
        giftAttrMsg.addAttributes([NSForegroundColorAttributeName: UIColor.red], range: NSRange(location: 0, length: username.characters.count))
        let range = (giftMsg as NSString).range(of: giftModel.giftName)
        giftAttrMsg.addAttributes([NSForegroundColorAttributeName: UIColor.orange], range: range)
        /// 从内存中获取图片url，没有的话就不显示
        guard let image = KingfisherManager.shared.cache.retrieveImageInMemoryCache(forKey: giftModel.giftURL) else {
            return giftAttrMsg
        }
        /// 将图片拼接上去
        let attachment = NSTextAttachment()
        attachment.image = image
        let font = UIFont.systemFont(ofSize: 15)
        attachment.bounds = CGRect(x: 0, y: -3, width: font.lineHeight, height: font.lineHeight)
        let imageAttrStr = NSAttributedString(attachment: attachment)
        giftAttrMsg.append(imageAttrStr)
        
        return giftAttrMsg
    }
    
    class func generateJoinLeaveRoomMessage(_ username: String, isJoin: Bool) -> NSAttributedString {
        let msg = isJoin == true ? "\(username) 进入了房间" : "\(username) 离开了房间"
        let msgAttr = NSMutableAttributedString(string: msg)
        msgAttr.addAttributes([NSForegroundColorAttributeName: UIColor.red], range: NSRange(location: 0, length: username.characters.count))
        return msgAttr
    }
}
