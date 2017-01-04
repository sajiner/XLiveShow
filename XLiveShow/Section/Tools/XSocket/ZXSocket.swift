//
//  ZXSocket.swift
//  Client
//
//  Created by sajiner on 2017/1/3.
//  Copyright © 2017年 sajiner. All rights reserved.
//

import UIKit
import ProtocolBuffers

protocol ZXSocketDelegate: class {
    func socket(_ socket: ZXSocket, joinRoom user : UserInfo)
    func socket(_ socket: ZXSocket, leaveRoom user : UserInfo)
    func socket(_ socket: ZXSocket, giftMsg : GiftMessage)
    func socket(_ socket: ZXSocket, chatMsg : TextMessage)
}

class ZXSocket {
    
    weak var delegate: ZXSocketDelegate?
    fileprivate var tcpClient : TCPClient
    
    var user: UserInfo.Builder = UserInfo.Builder()
    
    init(addr: String, port: Int) {
        tcpClient = TCPClient(addr: addr, port: port)
    }
}

extension ZXSocket {
    func connectServer() -> Bool {
        return tcpClient.connect(timeout: 5).0
    }

   fileprivate func sendMessage(_ data: Data, type: Int) {
        // 获取头部的data
        var length = data.count
        let headerData = Data(bytes: &length, count: 4)
        // 获取类型的data
        var type = type
        let typeData = Data(bytes: &type, count: 2)
        // 获取总的data
        let totalData = headerData + typeData + data
        tcpClient.send(data: totalData)
    }
}

extension ZXSocket {
    func startReadMsg() {
        DispatchQueue.global().async {
            while true {
                guard let lmsg = self.tcpClient.read(4) else { continue }
                let headerData = Data(bytes: lmsg, count: 4)
                
                var length: Int = 0
                (headerData as NSData).getBytes(&length, length: 4)
                
                guard let typeMsg = self.tcpClient.read(2) else { return }
                let typeData = Data(bytes: typeMsg, count: 2)
                var type: Int = 0
                (typeData as NSData).getBytes(&type, length: 2)
                
                guard let msg = self.tcpClient.read(length) else { return }
                let msgData = Data(bytes: msg, count: length)
                
                DispatchQueue.main.async {
                    self.handleMsg(type: type, data: msgData)
                }
            }
        }
    }
    
    func handleMsg(type: Int, data: Data) {
        switch type {
        case 1, 4:
            let user = try! UserInfo.parseFrom(data: data)
            type == 1 ? delegate?.socket(self, joinRoom: user) : delegate?.socket(self, leaveRoom: user)
            print(user.name)
        case 2:
            let giftMsg = try! GiftMessage.parseFrom(data: data)
            delegate?.socket(self, giftMsg: giftMsg)
            print(giftMsg.giftName)
        case 3:
            let chatMsg = try! TextMessage.parseFrom(data: data)
            delegate?.socket(self, chatMsg: chatMsg)
            print(chatMsg.text)
        default:
            print("未知类型")
        }
    }
}

extension ZXSocket {
    func sendJoinRoom() {
        let msgData = (try! user.build()).data()
        sendMessage(msgData, type: 1)
    }
    
    func sendGiftMsg(_ giftName: String, giftUrl: String, giftCount: Int) {
        let giftMsg = GiftMessage.Builder()
        giftMsg.giftUrl = giftUrl
        giftMsg.giftName = giftName
        giftMsg.giftCount = Int32(giftCount)
        
        let giftData = (try! giftMsg.build()).data()
        
        sendMessage(giftData, type: 2)
    }
    
    func sendTextMsg(_ message: String) {
        let chatMsg = TextMessage.Builder()
        chatMsg.text = message
        let chatData = (try! chatMsg.build()).data()
        sendMessage(chatData, type: 3)
    }
    
    func sendLeaveRoom() {
        let leaveData = (try! user.build()).data()
        sendMessage(leaveData, type: 4)
    }
}
