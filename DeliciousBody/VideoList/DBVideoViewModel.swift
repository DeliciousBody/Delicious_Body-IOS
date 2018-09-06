//
//  DBVideoViewModel.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 9. 4..
//  Copyright © 2018년 changmin. All rights reserved.
//

import Foundation
import UIKit


class VideoViewModelItem {
    var count: Int {
        return exercises.count
    }
    var exercises: [Exercise]
    init(exercises: [Exercise]) {
        self.exercises = exercises
    }
}

class VideoViewModel: NSObject {
    var allItems = VideoViewModelItem(exercises: [Exercise(),Exercise(),Exercise(),Exercise(),Exercise(),Exercise(),Exercise(),Exercise(),Exercise(),Exercise(),Exercise(),Exercise()])
    var likeItems = VideoViewModelItem(exercises: [Exercise(),Exercise()])
    var handler: ((Exercise) -> Void)?
    
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
//        let item = option == 0 ? allItems[indexPath.row] : likeItems[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = tableView.tag
        let item = option == 0 ? allItems.exercises[indexPath.row] : likeItems.exercises[indexPath.row]
        self.handler?(item)
    }
}

