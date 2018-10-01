//
//  DBNetworking.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 9. 28..
//  Copyright © 2018년 changmin. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
let kBaseURL = "http://localhost:8000/"
class DBNetworking: NSObject {
    
    static func login(_ id:String, password:String, completion:@escaping (_ result:Int,_ user:User?) -> Void) {
        
        let url = "/login"
//        var params = ["id":id, "password":password, "phone_type":"1", "phone_model":UIDevice.current.model, "app_push_id":User.fetchDeviceKey()]
        let params = ["id":id, "password":password]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success:
                let data = response.result.value as? String
                completion(200, User())
            case .failure:
                completion(400, nil)
            }
        }
        
    }
    
    static func register(_ id:String, password:String, completion:@escaping (_ result: Int,_ token: String?) -> Void) {
        
        let url = "\(kBaseURL)/rest-auth/registeration/"
        let params = ["id" : id, "password1" : password, "password2" : password]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success:
                completion(200, response.result.value as? String)
            case .failure:
                completion(400, nil)
            }
        }
        
    }
    
    static func updateUserInfo(user: User,  completion:@escaping (_ result: Int) -> Void) {
        let url = "\(kBaseURL)/userInfo/"
        let params = user.toJSON()
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success:
                print(response.result)
                completion(200)
            case .failure:
                completion(400)
            }
        }
    }
}
