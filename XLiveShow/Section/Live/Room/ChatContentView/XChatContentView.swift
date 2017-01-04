
//
//  XChatContentView.swift
//  XLiveShow
//
//  Created by sajiner on 2016/12/20.
//  Copyright © 2016年 sajiner. All rights reserved.
//

import UIKit

private let kChatContentCell = "kChatContentCell"


class XChatContentView: UIView, XNibLoadable {

    @IBOutlet weak var tableView: UITableView!
    
    var messages: [NSAttributedString] = [NSAttributedString]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.register(UINib.init(nibName: "XChatContentCell", bundle: nil), forCellReuseIdentifier: kChatContentCell)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

//MARK: - 对外开放的方法
extension XChatContentView {
    func insertMsg(_ message: NSAttributedString) {
        messages.append(message)
        tableView.reloadData()
        let indexPath = IndexPath(item: messages.count - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}

extension XChatContentView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kChatContentCell) as! XChatContentCell
        cell.contentLabel.attributedText = messages[indexPath.row]
        cell.contentLabel.numberOfLines = 0
        return cell
    }
}

extension XChatContentView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
