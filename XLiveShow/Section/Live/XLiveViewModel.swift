//
//  XLiveViewModel.swift
//  XLiveShow
//
//  Created by sajiner on 2016/12/14.
//  Copyright © 2016年 sajiner. All rights reserved.
//

import UIKit

class XLiveViewModel {

    lazy var liveModels = [XLiveListModel]()
}

extension XLiveViewModel {
    func loadLiveData(type: XTitleModel, index: Int, finishedCallback:@escaping ()->()) {
        XNetworkTools.requestData(.get, URLString: "http://qf.56.com/home/v4/moreAnchor.ios", parameters: ["type" : type.type, "index" : index, "size" : 48], finishedCallback: { (result) -> Void in
            guard let resultDict = result as? [String : Any] else { return }
            guard let messageDict = resultDict["message"] as? [String : Any] else { return }
            guard let dataArray = messageDict["anchors"] as? [[String : Any]] else { return }
            
            for (index, dict) in dataArray.enumerated() {
                let liveModel = XLiveListModel(dict: dict)
                liveModel.isEvenIndex = index % 2 == 0
                self.liveModels.append(liveModel)
            }
            finishedCallback()
        })
    }
}
