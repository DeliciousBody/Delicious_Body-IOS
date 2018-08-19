//
//  DBCardViewModel.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 8. 19..
//  Copyright © 2018년 changmin. All rights reserved.
//
import UIKit
import Foundation
class Exercise {
    var name: String?
    var pictureUrl: String?
    //    init(json: [String: Any]) {
    //        self.name = json["name"] as? String
    //        self.pictureUrl = json["pictureUrl"] as? String
    //    }
    init() {
        name = "ex"
        pictureUrl = "picture"
    }
}

class CardViewModelItem {
    var title: String {
        return "title"
    }
    var opened = false
    var rowCount: Int {
        return exercises.count
    }
    var exercises: [Exercise]
    init(exercises: [Exercise]) {
        self.exercises = exercises
    }
}

class CardViewModel: NSObject {
    var items = [CardViewModelItem]()
    
    override init() {
        super.init()
        items.append(CardViewModelItem(exercises: [Exercise(),Exercise()]))
        items.append(CardViewModelItem(exercises: [Exercise()]))
        items.append(CardViewModelItem(exercises: [Exercise(),Exercise()]))
    }
}

extension CardViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[tableView.tag].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[tableView.tag]
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerCell", for: indexPath) as! DBExerCell
//        let exercise = item.exercises[indexPath.row]
//        cell.textLabel?.text = exercise.name
        return cell
    }
}
