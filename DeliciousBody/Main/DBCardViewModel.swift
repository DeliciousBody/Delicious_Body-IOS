//
//  DBCardViewModel.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 8. 19..
//  Copyright © 2018년 changmin. All rights reserved.
//
import UIKit
import Foundation
import RealmSwift

class Exercise: Object {
    @objc dynamic var video_id: Int = 0
    @objc dynamic var video_name: String = ""
    @objc dynamic var level: Int = 1
    @objc dynamic var main_part: Int = 1
    @objc dynamic var sub_part: Int = 1
    @objc dynamic var time: Int = 1
    @objc dynamic var descript: String = ""
    @objc dynamic var video_url: String = ""
    @objc dynamic var video_file: String = ""
    @objc dynamic var video_thumbnail: String = ""
    @objc dynamic var with_list: Int = 1
    @objc dynamic var updatedat: Date = Date()

    override static func primaryKey() -> String? {
        return "video_id"
    }
    
    var main_partString: String {
        return BodyType(rawValue: main_part)?.description() ?? ""
    }
    
    var levelString: String {
        switch self.level {
        case 1:
            return "초급"
        case 2:
            return "중급"
        case 3:
            return "고급"
        default:
            return ""
        }
    }
    
    convenience init(withDic dic: [String : Any]) {
        self.init()
        video_id = dic["video_id"] as! Int
        video_name = dic["video_name"] as! String
        level = dic["level"] as! Int
        main_part = dic["main_part"] as! Int
        sub_part = dic["sub_part"] as! Int
        time = dic["time"] as! Int
        descript = dic["description"] as! String
        video_url = dic["video_url"] as! String
        video_file = dic["video_file"] as! String
        video_thumbnail = dic["video_thumbnail"] as! String
        with_list = dic["with_list"] as! Int
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
        let list = dic["video_list"] as! [[String : Any]]
        for dict in list{
            exercises.append(Exercise(withDic: dict))
        }
    }
    
    init() {
        list_name = "default"
        time = 0
        list_image = ""
    }
}

class CardViewModel: NSObject {
    var items = [CardViewModelItem]()
    var handler: ((IndexPath, Exercise) -> Void)?
   
    override init() {
        super.init()
        items = [CardViewModelItem(),CardViewModelItem(),CardViewModelItem()]
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
