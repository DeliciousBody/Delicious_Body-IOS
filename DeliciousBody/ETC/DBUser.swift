//
//  DBUser.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 8. 16..
//  Copyright © 2018년 changmin. All rights reserved.
//

import Foundation

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
    open var slogan: String?
    open var photoUrl: String?
    open var token: String?
    open var isSubscribe: Bool?
    
    let appPushID: String?
    
    open var weekdays_start: Int?
    open var weekdays_end: Int?
    open var weekend_start: Int?
    open var weekend_end: Int?
    
    public convenience override init() {
        self.init(withDic:  ["token" : "sampleTOKEN" as AnyObject] )
    }
    
    public init (withDic dic: [String : Any]) {
        name = dic["name"] as? String
        age = dic["age"] as? Int
        sex = dic["is_man"] as? Bool
        activity_level = dic["activity_level"] as? Int
        interested_part = dic["interested_part"] as? String
        weekdays_start = dic["weekdays_start"] as? Int
        weekdays_end = dic["weekdays_end"] as? Int
        weekend_start = dic["weekend_start"] as? Int
        weekend_end = dic["weekend_end"] as? Int
        photoUrl = dic["avatar"] as? String
        favorite_list = dic["favorite_list"] as? String
        slogan = dic["comment"] as? String
        appPushID = dic["appPushId"] as? String
        isSubscribe = dic["is_push"] as? Bool
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
        if let wds = self.weekdays_start { data["weekdays_start"] = wds as AnyObject }
        if let wde = self.weekdays_end { data["weekdays_end"] = wde as AnyObject }
        if let wes = self.weekend_start { data["weekend_start"] = wes as AnyObject }
        if let wee = self.weekend_end { data["weekend_end"] = wee as AnyObject }
        if let avatar = self.photoUrl { data["avatar"] = avatar as AnyObject }
        if let slogan = self.slogan { data["comment"] = slogan as AnyObject }
        if let list = self.favorite_list { data["favorite_list"] = list as AnyObject }
        if let ispush = self.isSubscribe { data["ispush"] = ispush as AnyObject }
        
        UserDefaults.standard.set(data, forKey: kSavedUserData)
        UserDefaults.standard.synchronize()
        
        User.me = self
    }
    
    //MARK: UserProtocol
    open func httpHeaders() -> [String:String] {
        var defaultHeaders = [String:String]()
        
        if let token = User.fetchToken() {
            defaultHeaders["Authorization"] = "token " + token
        }
        defaultHeaders["app_push_id"] = User.fetchDeviceKey()
        
        return defaultHeaders
    }
    
    func toJSON() -> [String : Any] {
        var data = [String : Any]()
        
        if let id = self.id { data["id"] = id as String }
        if let name = self.name { data["name"] = name as String }
        if let age = self.age { data["age"] = age as Int }
        if let sex = self.sex { data["is_man"] = sex as Bool }
        if let lv = self.activity_level { data["activity_level"] = lv as Int }
        if let parts = self.interested_part { data["interested_part"] = parts as String }
        if let wds = self.weekdays_start { data["weekdays_start"] = wds as Int }
        if let wde = self.weekdays_end { data["weekdays_end"] = wde as Int }
        if let wes = self.weekend_start { data["weekend_start"] = wes as Int }
        if let wee = self.weekend_end { data["weekend_end"] = wee as Int }
//        if let avatar = self.photoUrl { data["avatar"] = avatar as String }
        if let slogan = self.slogan { data["comment"] = slogan as String }
        if let list = self.favorite_list { data["favorite_list"] = list as String }
        if let ispush = self.isSubscribe { data["ispush"] = ispush as Bool }
        return data
    }
}

