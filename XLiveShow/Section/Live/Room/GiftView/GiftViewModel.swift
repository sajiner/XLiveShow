//
//  GiftViewModel.swift
//  XLiveShow
//
//  Created by sajiner on 2016/12/15.
//  Copyright © 2016年 sajiner. All rights reserved.
//

import UIKit

class GiftViewModel {

    lazy var giftlistData : [GiftPackage] = [GiftPackage]()
}

extension GiftViewModel {
    func loadGiftData(_ finishedCallback : @escaping () -> ()) {
        // http://qf.56.com/pay/v4/giftList.ios?type=0&page=1&rows=150
        
        if giftlistData.count != 0 { finishedCallback() }
        
        XNetworkTools.requestData(.get, URLString: "http://qf.56.com/pay/v4/giftList.ios", parameters: ["type" : 0, "page" : 1, "rows" : 150], finishedCallback: { result in
            guard let resultDict = result as? [String : Any] else { return }
            
            guard let dataDict = resultDict["message"] as? [String : Any] else { return }
            
            for i in 0..<dataDict.count {
                guard let dict = dataDict["type\(i+1)"] as? [String : Any] else { continue }
                self.giftlistData.append(GiftPackage(dict: dict))
            }
            
            self.giftlistData = self.giftlistData.filter({ return $0.t != 0 }).sorted(by: { return $0.t > $1.t })
            
            finishedCallback()
        })
    }
}
