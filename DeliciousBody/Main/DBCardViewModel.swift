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
    var video_id: Int
    var video_name: String
    var level: Int?
    var main_part: Int
    var sub_part: Int
    var time: Int
    var description: String
    var video_url: String
    var video_file: String
    var video_thumbnail: String
    var with_list: Int?
    
    init(withDic dic: [String : Any]) {
        video_id = dic["video_id"] as! Int
        video_name = dic["video_name"] as! String
        level = dic["level"] as? Int
        main_part = dic["main_part"] as! Int
        sub_part = dic["sub_part"] as! Int
        time = dic["time"] as! Int
        description = dic["description"] as! String
        video_url = dic["video_url"] as! String
        video_file = dic["video_file"] as! String
        video_thumbnail = dic["video_thumbnail"] as! String
        with_list = dic["with_list"] as? Int
    }
}

class CardViewModelItem {
    var list_name: String
    var time: Int
    var list_image: String
    
    
    var opened = false
    
    var rowCount: Int {
        return exercises.count
    }
    var exercises: [Exercise] = []
    init(withDic dic: [String : Any]) {
        self.list_name = dic["list_name"] as! String
        self.time = dic["time"] as! Int
        self.list_image = dic["list_image"] as! String
        
        let count = dic["list_count"] as! Int
        let list = dic["video_list"] as! [String : Any]
        for i in 1 ... count {
            exercises.append(Exercise(withDic: list["video\(i)"] as! [String : Any]))
        }
    }
}

class CardViewModel: NSObject {
    var items = [CardViewModelItem]()
    var handler: ((IndexPath, Exercise) -> Void)?
   
    override init() {
        super.init()
    }
    
    init(withDic dict: [[String : Any]]) {
        for item in dict {
            items.append(CardViewModelItem(withDic: item))
        }
    }
}

extension CardViewModel: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[tableView.tag].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[tableView.tag]
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerCell", for: indexPath) as! DBExerCell
        cell.configure(exer: item.exercises[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.handler?(IndexPath(row: indexPath.row, section: tableView.tag), items[tableView.tag].exercises[indexPath.row])
    }
}
