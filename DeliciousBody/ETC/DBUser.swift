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
    open var password: String
    open var seq: Int
    open var countryCode: String?
    open var name: String?
    open var isAuth: Bool?
    open var phoneType: Int?
    open var photoUrl: String?
    open var token: String
    
    let appPushID: String?
    
    //KAKAOTALK, APP
    open let joinPath: String?
    
    open let adAccept: String?
    open let adEmail: String?
    open let adAcceptDate: String?
    
    public init (withDic dic: [String : AnyObject]) {
        id = dic["id"] as! String
        
        let pwStr = dic["password"] as? String
        password = pwStr != nil ? pwStr! : ""
        seq  = dic["seq"] as! Int
        
        countryCode = dic["countryCode"] as? String
        name = dic["firstName"] as? String
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
        
        joinPath = dic["joinPath"] as? String
        
        appPushID = dic["appPushId"] as? String
        
        adAccept = dic["adAccept"] as? String
        adEmail = dic["email"] as? String
        adAcceptDate = dic["adAcceptDate"] as? String
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
        if let joinPath = self.joinPath {
            if joinPath == "KAKAOTALK" {
                return "via Kakaotalk"
            }
            if joinPath == "APP" {
                return "via APP"
            }
        }
        return self.id
    }
    
    fileprivate func saveMyProfile() {
        
        UserDefaults.standard.removeObject(forKey: kSavedUserData)
        
        var data = [String:AnyObject]()
        
        data["id"] = self.id as AnyObject
        data["password"] = self.password as AnyObject
        data["seq"] = self.seq as AnyObject
        
        data["countryCode"] = self.countryCode as AnyObject
        data["firstName"] = self.name as AnyObject
        data["isAuth"] = { ()->AnyObject in
            if self.isAuth != nil && self.isAuth!{
                return "Y" as AnyObject
            }else{
                return "N" as AnyObject
            }
        }()
        data["phoneType"] = self.phoneType as AnyObject
        data["photoUrl"] = self.photoUrl as AnyObject
        
        data["token"] = self.token as AnyObject
        data["joinPath"] = self.joinPath as AnyObject
        
        data["appPushId"] = self.appPushID as AnyObject
        
        data["adAccept"] = self.adAccept as AnyObject
        data["email"] = self.adEmail as AnyObject
        data["adAcceptDate"] = self.adAcceptDate as AnyObject
        
        UserDefaults.standard.set(data, forKey: kSavedUserData)
        UserDefaults.standard.synchronize()
        
        User.me = self
    }
    
    //MARK: UserProtocol
    open func httpHeaders() -> [String:String] {
        var defaultHeaders = [String:String]()
        
        if let token = User.fetchToken() {
            defaultHeaders["x-token"] = token
        }
        defaultHeaders["app_push_id"] = User.fetchDeviceKey()
        
        return defaultHeaders
    }
}

