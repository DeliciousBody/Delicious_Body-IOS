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
    
    open var id: String
    open var seq: Int
    open var countryCode: String?
    open var name: String?
    open var age: Int?
    open var sex: Bool?
    open var slogan: String?
    open var isAuth: Bool?
    open var phoneType: Int?
    open var photoUrl: String?
    open var token: String
    open var isSubscribe: Bool?
    
    let appPushID: String?
    
    
    public convenience override init() {
        self.init(withDic:  ["id" : "sampleID" as AnyObject,
                             "seq" : 1 as AnyObject,
                             "name" : "창맨" as AnyObject,
                             "token" : "sampleTOKEN" as AnyObject,
                             "slogan" : "" as AnyObject])
        
    }
    
    public init (withDic dic: [String : AnyObject]) {
        id = dic["id"] as! String
        seq  = dic["seq"] as! Int
        
        countryCode = dic["countryCode"] as? String
        name = dic["name"] as? String
        if let isAuthBool = dic["isAuth"] as? Bool {
            isAuth = isAuthBool
        }
        else {
            if let isAuthStr = dic["isAuth"] as? String {
                isAuth = isAuthStr == "Y" ? true : false
            }
            else {
                isAuth = true
            }
        }
        phoneType = dic["phoneType"] as? Int
        photoUrl = dic["photoUrl"] as? String
        
        if let token = dic["token"] as? String {
            self.token = token
        }
        else {
            self.token = "InvalidToken"
        }
        
        appPushID = dic["appPushId"] as? String
        
        
        slogan = dic["slogan"] as? String
        isSubscribe = dic["isSubscribe"] as? Bool
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
    
    static func isMe(_ seq:Int) -> Bool {
        if let user = User.me {
            return user.seq == seq
        }
        return false
    }
    
    open func getID() -> String {
        return self.id
    }
    
    fileprivate func saveMyProfile() {
        
        UserDefaults.standard.removeObject(forKey: kSavedUserData)
        
        var data = [String:AnyObject]()
        
        data["id"] = self.id as AnyObject
        data["seq"] = self.seq as AnyObject
        
        data["name"] = self.name as AnyObject
//        data["isAuth"] = { ()->AnyObject in
//            if self.isAuth != nil && self.isAuth!{
//                return "Y" as AnyObject
//            }else{
//                return "N" as AnyObject
//            }
//        }()
//        data["phoneType"] = self.phoneType as AnyObject
        
        
        data["token"] = self.token as AnyObject
//        data["joinPath"] = self.joinPath as AnyObject
//
//        data["appPushId"] = self.appPushID as AnyObject
//
//        data["adAccept"] = self.adAccept as AnyObject
//        data["email"] = self.adEmail as AnyObject
//        data["adAcceptDate"] = self.adAcceptDate as AnyObject
        data["slogan"] = self.slogan as AnyObject
        
        if let url = self.photoUrl {
            data["photoUrl"] = url as AnyObject
        }
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
        var jsonDict = [String : Any]()
        
        jsonDict["name"] = name ?? ""
        jsonDict["age"] = age ?? 0
        jsonDict["is_man"] = sex
        jsonDict["interested_part"] = ""
        jsonDict["activity_level"] = 1
        jsonDict["weekdays_start"] = 2
        jsonDict["weekdays_end"] = 2
        jsonDict["weekdays_start"] = 2
        jsonDict["weekend_start"] = 2
        jsonDict["weekend_end"] = 2
        jsonDict["comment"] = slogan ?? ""
//        jsonDict["avatar"] = slogan ?? ""
        jsonDict["favorite_list"] = slogan ?? ""
        jsonDict["is_push"] = true
        jsonDict["is_subscription"] = true
        
        return jsonDict
    }
}

