//
//  XRoomViewController.swift
//  XLiveShow
//
//  Created by sajiner on 2016/12/14.
//  Copyright © 2016年 sajiner. All rights reserved.
//

import UIKit
import ProtocolBuffers

private let kGiftlistViewHeight : CGFloat = kScreenHeight * 0.5
private let kChatToolsViewHeight : CGFloat = 44
private let kChatViewHeight: CGFloat = 100

class XRoomViewController: UIViewController {

    // MARK: 控件属性
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var roomNumLabel: UILabel!
    @IBOutlet weak var onlineLabel: UILabel!
    
    fileprivate lazy var giftListView : GiftListView = GiftListView.loadFromNib()
    fileprivate lazy var chatToolsView : ChatToolsView = ChatToolsView.loadFromNib()
    fileprivate lazy var chatContentView : XChatContentView = XChatContentView.loadFromNib()
    fileprivate lazy var giftContainerView: XGiftContainerView = {
        let channelStyle = XChannelViewStyle()
        let giftContainerView = XGiftContainerView(frame: CGRect(x: 0, y: 100, width: 250, height: 90), style: channelStyle)
        return giftContainerView
    }()
    fileprivate lazy var socket: ZXSocket = ZXSocket(addr: "10.165.3.59", port: 8080)
    fileprivate lazy var userModel: XUserModel = {
       let userModel = XUserModel()
        userModel.username = "sajiner_\(arc4random_uniform(10))"
        userModel.userLever = Int(arc4random_uniform(50))
        return userModel
    }()
    
    // MARK: 对外提供控件属性
    var liveModel : XLiveListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupUI()
        /// 进入房间开始读取信息
        if socket.connectServer() {
            let user = socket.user
            user.name = userModel.username
            user.level = Int32(userModel.userLever)
            socket.startReadMsg()
            socket.sendJoinRoom()
            socket.delegate = self
        }
        // 设置内容
        setupAnchorInfo()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        socket.sendLeaveRoom()
    }
}

// MARK:- 设置内容
extension XRoomViewController {
    fileprivate func setupAnchorInfo() {
        bgImageView.setImage(liveModel?.pic74)
        nickNameLabel.text = liveModel?.name
        roomNumLabel.text = "房间号：\(liveModel!.roomid)"
        iconImageView.setImage(liveModel?.pic51)
        onlineLabel.text = "\(liveModel!.focus)"
    }
}

// MARK:- 设置UI界面内容
extension XRoomViewController {
    fileprivate func setupUI() {
        setupBlurView()
        setupBottomView()
        setupGiftContainerView()
    }
    
    fileprivate func setupGiftContainerView() {
        giftContainerView.backgroundColor = UIColor.clear
        bgImageView.addSubview(giftContainerView)
    }
    
    fileprivate func setupBlurView() {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        blurView.frame = bgImageView.bounds
        bgImageView.addSubview(blurView)
    }
    
    fileprivate func setupBottomView() {
       // 设置chatContentVIew
        chatContentView.frame = CGRect(x: 0, y: kScreenHeight - kTabBarHeight - kChatViewHeight, width: kScreenWidth, height: kChatViewHeight)
//        chatContentView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        view.addSubview(chatContentView)
        
        // 设置giftListView
        giftListView.frame = CGRect(x: 0, y: kScreenHeight, width: kScreenWidth, height: kGiftlistViewHeight)
//        giftListView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        giftListView.delegate = self
        view.addSubview(giftListView)
        
        // 设置chatToolsView
        chatToolsView.frame = CGRect(x: 0, y: kScreenHeight, width: kScreenWidth, height: kChatToolsViewHeight)
//        chatToolsView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        chatToolsView.delegate = self
        view.addSubview(chatToolsView)
    }
}

// MARK:- 事件监听函数
extension XRoomViewController {
    @IBAction func closeBtnClick() {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func focusBtnClick(btn : UIButton) {
    }
}

// MARK:- 底部菜单的点击
extension XRoomViewController: XAnimatorManager {
    @IBAction func starItemClick(_ starItem : UIButton) {
        starItem.isSelected = !starItem.isSelected
        let point = CGPoint(x: starItem.center.x, y: view.bounds.height - starItem.bounds.height * 0.5)
        starItem.isSelected ? startEmittering(point, cellCounts: 10) : stopEmittering()
    }
    
    @IBAction func moreItemClick() {
    }
    
    @IBAction func giftItemClick() {
        UIView.animate(withDuration: 0.25, animations: {
            self.giftListView.frame.origin.y = kScreenHeight - kGiftlistViewHeight
        })
    }
    
    @IBAction func shareItemClick() {
    }
    
    @IBAction func chatItemClick() {
        chatToolsView.inputTextField.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        UIView.animate(withDuration: 0.25, animations: {
            self.giftListView.frame.origin.y = kScreenHeight
        })
        
        chatToolsView.inputTextField.resignFirstResponder()
    }
}

// MARK:- 监听键盘的弹出
extension XRoomViewController {
    @objc fileprivate func keyboardWillChangeFrame(_ note : Notification) {
        let duration = note.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let endFrame = (note.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let inputViewY = endFrame.origin.y - kChatToolsViewHeight
        
        UIView.animate(withDuration: duration, animations: {
            UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: 7)!)
            let endY = inputViewY == (kScreenHeight - kChatToolsViewHeight) ? kScreenHeight : inputViewY
            self.chatToolsView.frame.origin.y = endY
            
            let chatContentY = inputViewY == (kScreenHeight - kChatToolsViewHeight) ? kScreenHeight - kTabBarHeight - kChatViewHeight : inputViewY - kChatViewHeight
            self.chatContentView.frame.origin.y = chatContentY
        })
    }
}



// MARK:- 监听用户输入的内容
extension XRoomViewController : ChatToolsViewDelegate, GiftListViewDelegate {
    func chatToolsView(_ toolView: ChatToolsView, message: String) {
        socket.sendTextMsg(message)
    }
    
    func giftListView(_ giftView: GiftListView, giftModel: GiftModel) {
        socket.sendGiftMsg(giftModel.subject, giftUrl: giftModel.img2, giftCount: 1)
    }
    
}

extension XRoomViewController: ZXSocketDelegate {
    func socket(_ socket: ZXSocket, chatMsg: TextMessage) {
        let msg = XAttrStringGenerator.generateTextMessage(userModel.username, chatMsg.text)
        chatContentView.insertMsg(msg)
    }
    
    func socket(_ socket: ZXSocket, giftMsg: GiftMessage) {
        
        let giftModel = XGiftModel(senderName: userModel.username, senderURL: "icon3", giftName: giftMsg.giftName, giftURL: giftMsg.giftUrl)
        giftContainerView.showGiftModel(giftModel)
        let msg = XAttrStringGenerator.generateGiftMessage(userModel.username, giftModel: giftModel)
        chatContentView.insertMsg(msg)
    }
    
    func socket(_ socket: ZXSocket, joinRoom user: UserInfo) {
        let msg = XAttrStringGenerator.generateJoinLeaveRoomMessage(user.name, isJoin: true)
        chatContentView.insertMsg(msg)
    }
    
    func socket(_ socket: ZXSocket, leaveRoom user: UserInfo) {
        let msg = XAttrStringGenerator.generateJoinLeaveRoomMessage(user.name, isJoin: false)
        chatContentView.insertMsg(msg)
    }
}









