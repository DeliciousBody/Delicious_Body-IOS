//
//  DBVideoViewModel.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 9. 4..
//  Copyright © 2018년 changmin. All rights reserved.
//

import Foundation
import Kingfisher
import UIKit

class VideoViewModel: NSObject {
    var allItems: [Exercise] = []
    var likeItems:  [Exercise] = []
    var handler: ((Exercise) -> Void)?
    var likeHandler: ((Int) -> ())?
    override init() {
        super.init()
    }
}

extension VideoViewModel: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView.tag == 0 ? allItems.count : likeItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let option = tableView.tag
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerCell", for: indexPath) as! DBExerCell
        let item = option == 0 ? allItems[indexPath.row] : likeItems[indexPath.row]
        cell.configure(exer: item)
        cell.likeHandler = { id in
            self.likeHandler?(id)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = tableView.tag
        let item = option == 0 ? allItems[indexPath.row] : likeItems[indexPath.row]
        self.handler?(item)
    }
}

