//
//  XLiveViewController.swift
//  XLiveShow
//
//  Created by sajiner on 2016/12/13.
//  Copyright © 2016年 sajiner. All rights reserved.
//

import UIKit

class XLiveViewController: UIViewController {
    
    fileprivate var pageView: XPageView!

    fileprivate lazy var titleModels: [XTitleModel] = {
        var titleModels = [XTitleModel]()
        let path = Bundle.main.path(forResource: "types.plist", ofType: nil)
        let dicts = NSArray(contentsOfFile: path!) as! [[String: Any]]
        for dict in dicts {
            titleModels.append(XTitleModel(dict: dict))
        }
        return titleModels
    }()
    
    fileprivate lazy var titleStyle: XTitleStyle = {
        $0.isScroll = true
        $0.isShowBottomLine = true
        return $0
    }(XTitleStyle())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        /// 导航栏设置
        setupNavBar()
        /// 内容设置
        setupContentView()
    }
}

//MARK: - 内容设置
extension XLiveViewController {
   fileprivate func setupContentView() {
        let pageFrame = CGRect(x: 0, y: kNavHeight, width: kScreenWidth, height: kScreenHeight - kNavHeight)
        let childVcs = loadChildVcs()
        let titles = titleModels.map{ $0.title }
        pageView = XPageView(frame: pageFrame, titles: titles, titleStyle: titleStyle, childVcs: childVcs, parentVc: self)
        view.addSubview(pageView)
    }
    
    /// 加载所有的子控制器
    fileprivate func loadChildVcs() -> [UIViewController] {
        var childVcs = [XLiveListViewController]()
        for titleModel in titleModels {
            let childVc = XLiveListViewController()
            childVc.titleModel = titleModel
            childVc.view.backgroundColor = UIColor.randomColor()
            childVcs.append(childVc)
        }
        return childVcs
    }
}

//MARK: - 导航栏设置
extension XLiveViewController {
   fileprivate func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"search_btn_follow"), style: .plain, target: self, action: #selector(XLiveViewController.gotoMyAttension))
    
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"search_btn_follow"), style: .plain, target: self, action: #selector(XLiveViewController.gotoMyAttension))
    
        let searchFrame = CGRect(x: 0, y: 0, width: 200, height: 30)
        let searchBar = UISearchBar(frame: searchFrame)
        searchBar.placeholder = "主播昵称/房间号/链接"
        searchBar.searchBarStyle = .minimal
        navigationItem.titleView = searchBar
        let searchFeild = searchBar.value(forKey: "_searchField") as? UITextField
        searchFeild?.textColor = UIColor.white
    }
        
   @objc fileprivate func gotoMyAttension() {
        let attensionVc = XMyAttensionViewController()
        attensionVc.navigationItem.title = "我的关注"
        navigationController?.pushViewController(attensionVc, animated: true)
    }
}
