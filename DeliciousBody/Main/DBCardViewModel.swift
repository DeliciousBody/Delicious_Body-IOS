//
//  DBCardViewModel.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 8. 19..
//  Copyright © 2018년 changmin. All rights reserved.
//
import UIKit
import Foundation
struct Exercise {
    var video_id: Int?
    var video_name: String?
    var level: Int?
    var part1: Bool?
    var part2: Bool?
    var part3: Bool?
    var part4: Bool?
    var part5: Bool?
    var part6: Bool?
    var part7: Bool?
    var part8: Bool?
    var time: Int?
    var description: String?
    var video_url: String?
    var video_file: String?
    var video_thumbnail: String?
    var created_at: String?
    var updated_at: String?
    var with_list: String?
    
    init() {
        video_name = "ex"
    }
    
    init(withDic dic: [String : Any]) {
        video_id = dic["video_id"] as? Int
        video_name = dic["video_name"] as? String
        level = dic["level"] as? Int
        part1 = dic["part1"] as? Bool
        part2 = dic["part2"] as? Bool
        part3 = dic["part3"] as? Bool
        part4 = dic["part4"] as? Bool
        part5 = dic["part5"] as? Bool
        part6 = dic["part6"] as? Bool
        part7 = dic["part7"] as? Bool
        part8 = dic["part8"] as? Bool
        time = dic["time"] as? Int
        description = dic["description"] as? String
        video_url = dic["video_url"] as? String
        video_file = dic["video_file"] as? String
        video_thumbnail = dic["video_thumbnail"] as? String
        created_at = dic["created_at"] as? String
        updated_at = dic["updated_at"] as? String
        with_list = dic["with_list"] as? String
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
    var handler: ((IndexPath, Exercise) -> Void)?
   
    override init() {
        super.init()
        items.append(CardViewModelItem(exercises: [Exercise(),Exercise()]))
        items.append(CardViewModelItem(exercises: [Exercise()]))
        items.append(CardViewModelItem(exercises: [Exercise(),Exercise()]))
        items.append(CardViewModelItem(exercises: [Exercise()]))
        items.append(CardViewModelItem(exercises: [Exercise(),Exercise()]))
        items.append(CardViewModelItem(exercises: [Exercise()]))
    }
}

extension CardViewModel: UITableViewDataSource, UITableViewDelegate {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.handler?(IndexPath(row: indexPath.row, section: tableView.tag), items[tableView.tag].exercises[indexPath.row])
    }
}
