//
//  DBUser.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 8. 16..
//  Copyright © 2018년 changmin. All rights reserved.
//

import Foundation
import UIKit

let kSavedUserData = "kSavedUserData"

open class User : NSObject {
    
    open static var me: User? = nil
    
    open var id: String?
    open var name: String?
    open var age: Int?
    open var sex: Bool?
    open var activity_level: Int?
    open var interested_part: String?
    open var favorite_list: String?
    open var slogan: String = kDefaultSlogan
    open var photoUrl: String?
    open var token: String?
    open var is_subscription: Bool?
    
    let appPushID: String?
    
    open var is_push_weekdays: Bool = true
    open var is_push_weekend: Bool = true
    open var weekdays_start: Int = 8
    open var weekdays_end: Int = 22
    open var weekend_start: Int = 8
    open var weekend_end: Int = 22
    
    var favorite_array: [Int] {
        return favorite_list == nil ? [] : favorite_list!.split(separator: ";").compactMap({Int($0)})
    }
    
    public convenience override init() {
        self.init(withDic:  ["token" : "sampleTOKEN" as AnyObject] )
    }
    
    public init (withDic dic: [String : Any]) {
        id = dic["id"] as? String
        name = dic["name"] as? String
        age = dic["age"] as? Int
        sex = dic["is_man"] as? Bool
        activity_level = dic["activity_level"] as? Int
        interested_part = dic["interested_part"] as? String
        weekdays_start = dic["weekdays_start"] as? Int ?? 8
        weekdays_end = dic["weekdays_end"] as? Int ?? 22
        weekend_start = dic["weekend_start"] as? Int ?? 8
        weekend_end = dic["weekend_end"] as? Int ?? 22
        photoUrl = dic["avatar"] as? String
        favorite_list = dic["favorite_list"] as? String
        slogan = dic["comment"] as? String ?? kDefaultSlogan
        appPushID = dic["appPushId"] as? String
        is_push_weekdays = dic["is_push_weekdays"] as? Bool ?? true
        is_push_weekend = dic["is_push_weekend"] as? Bool ?? true
        is_subscription = dic["is_subscription"] as? Bool
        token = dic["token"] as? String
    }
    
    func setFavoriteVideo(id: Int, isLike: Bool) {
        var arr = favorite_array
        if isLike {
            if !arr.contains(id) {
                arr.append(id)
            }
        } else {
            if arr.contains(id), let index = arr.index(of: id){
                arr.remove(at: index)
            }
        }
        favorite_list = arr.map{"\($0)"}.joined(separator: ";")
    }
    
    func isFavoriteVideo(id: Int) -> Bool {
        return favorite_array.contains(id)
    }
    
    func save() {
        User.me = self
        self.saveToken()
        self.saveMyProfile()
    }
    
    fileprivate func saveToken() {
        UserDefaults.standard.set(self.token, forKey: "UserToken")
        UserDefaults.standard.synchronize()
    }
    
    open static func fetchUserFromSavedData() -> User? {
        guard let savedDic = UserDefaults.standard.object(forKey: kSavedUserData) as? [String:AnyObject] else {
            return nil
        }
        
        return User(withDic: savedDic)
    }
    
    open static func removeSavedUser() {
        User.me = nil
        UserDefaults.standard.removeObject(forKey: "UserToken")
        UserDefaults.standard.removeObject(forKey: "DeviceKey")
        UserDefaults.standard.removeObject(forKey: kSavedUserData)
        UserDefaults.standard.synchronize()
        DBHistoryManager.resetHistory()
    }
    
    open static func fetchToken() -> String? {
        if let token = UserDefaults.standard.object(forKey: "UserToken") as? String {
            return token
        } else {
            return nil
        }
    }
    
    open static func fetchDeviceKey() -> String {
        if let deviceKey = UserDefaults.standard.object(forKey: "DeviceKey") as? String {
            return deviceKey
        } else {
            return "InvalidDeviceKey"
        }
    }
    
    open static func saveDeviceKey(_ key:String) {
        UserDefaults.standard.set(key, forKey: "DeviceKey")
        UserDefaults.standard.synchronize()
    }
    
    fileprivate func saveMyProfile() {
        UserDefaults.standard.removeObject(forKey: kSavedUserData)
        var data = [String:AnyObject]()
        
        if let id = self.id { data["id"] = id as AnyObject }
        if let name = self.name { data["name"] = name as AnyObject }
        if let age = self.age { data["age"] = age as AnyObject }
        if let sex = self.sex { data["is_man"] = sex as AnyObject }
        if let lv = self.activity_level { data["activity_level"] = lv as AnyObject }
        if let parts = self.interested_part { data["interested_part"] = parts as AnyObject }
        if let avatar = self.photoUrl { data["avatar"] = avatar as AnyObject }
        if let list = self.favorite_list { data["favorite_list"] = list as AnyObject }
        if let token = self.token { data["token"] = token as AnyObject }
        if let is_subscription = self.is_subscription { data["is_subscription"] = is_subscription as AnyObject }
        data["comment"] = slogan as AnyObject
        data["is_push_weekdays"] = is_push_weekdays as AnyObject
        data["is_push_weekend"] = is_push_weekend as AnyObject
        data["weekdays_start"] = weekdays_start as AnyObject
        data["weekdays_end"] = weekdays_end as AnyObject
        data["weekend_start"] = weekend_start as AnyObject
        data["weekend_end"] = weekend_end as AnyObject
        data["push_id"] = User.fetchDeviceKey() as AnyObject
        UserDefaults.standard.set(data, forKey: kSavedUserData)
        UserDefaults.standard.synchronize()
        
        User.me = self
    }
    
    //MARK: UserProtocol
    open func httpHeaders() -> [String:String] {
        var defaultHeaders = [String:String]()
        
        if let token = User.fetchToken() {
            defaultHeaders["Authorization"] = "JWT " + token
        }
        defaultHeaders["pushtoken"] = User.fetchDeviceKey()
        
        return defaultHeaders
    }
    
    func toJSON() -> [String : Any] {
        var data = [String : Any]()
        
//        if let id = self.id { data["id"] = id as String }
        if let name = self.name { data["name"] = name as String }
        if let age = self.age { data["age"] = age as Int }
        if let sex = self.sex { data["is_man"] = sex as Bool }
        if let lv = self.activity_level { data["activity_level"] = lv as Int }
        if let parts = self.interested_part { data["interested_part"] = parts as String }
        if let avatar = self.photoUrl { data["avatar"] = avatar as String }
        if let list = self.favorite_list { data["favorite_list"] = list as String }
        if let is_subscription = self.is_subscription { data["is_subscription"] = is_subscription as Bool }
        data["comment"] = slogan as String
        data["push_id"] = User.fetchDeviceKey()
        data["is_push_weekdays"] = is_push_weekdays as Bool
        data["is_push_weekend"] = is_push_weekend as Bool
        data["weekdays_start"] = weekdays_start as Int
        data["weekdays_end"] = weekdays_end as Int
        data["weekend_start"] = weekend_start as Int
        data["weekend_end"] = weekend_end as Int
        data["phone_model"] = UIDevice.modelName
        print(data)
        return data
    }
}

