//
//  XPageView.swift
//  XLiveShow
//
//  Created by sajiner on 2016/12/13.
//  Copyright © 2016年 sajiner. All rights reserved.
//

import UIKit

class XPageView: UIView {
    
    fileprivate var titleStyle: XTitleStyle
    fileprivate var childVcs: [UIViewController]
    fileprivate var parentVc: UIViewController
    fileprivate var titles: [String]
    
    fileprivate lazy var contentView: XContentView = {
         let contentFrame = CGRect(x: 0, y: self.titleView.frame.maxY, width: kScreenWidth, height: kScreenHeight - self.titleView.frame.maxY)
        let contentView = XContentView(frame: contentFrame, childVcs: self.childVcs, parentVc: self.parentVc)
        return contentView
    }()
    
    fileprivate lazy var titleView: XTitleView = {
        let titleFrame = CGRect(x: 0, y: 0, width: kScreenWidth, height: self.titleStyle.titleHeight + self.titleStyle.bottomLineHeight)
        let titleView = XTitleView(frame: titleFrame, titles: self.titles, titleStyle: self.titleStyle)
        titleView.backgroundColor = UIColor.white
        return titleView
    }()
    
    init(frame: CGRect, titles: [String], titleStyle: XTitleStyle, childVcs: [UIViewController], parentVc: UIViewController) {
        self.titleStyle = titleStyle
        self.childVcs = childVcs
        self.titles = titles
        self.parentVc = parentVc
        
        super.init(frame: frame)
        
        addSubview(titleView)
        addSubview(contentView)
        titleView.delegate = contentView
        contentView.delegate = titleView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
