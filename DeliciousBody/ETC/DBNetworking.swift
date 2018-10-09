//
//  DBNetworking.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 9. 28..
//  Copyright © 2018년 changmin. All rights reserved.
//

//        var params = ["id":id, "password":password, "phone_type":"1", "phone_model":UIDevice.current.model, "app_push_id":User.fetchDeviceKey()]

import Foundation
import UIKit
import Alamofire

class DBNetworking: NSObject {
    
    static func login(_ id:String, password:String, completion:@escaping (_ result:Int,_ token:String?) -> Void) {
        
        let url = "\(kBaseURL)rest-auth/login/"
        let params = ["email" : id, "password" : password]
        //        let params = ["email" : "elfqk@g.com", "password" : "elfqk123"]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response) in
            let status = response.response?.statusCode ?? 999
            switch response.result {
            case .success:
                if let json = response.result.value as? [String : Any],
                    let token = json["token"] as? String
                {
                    
                    print(token)
                    completion(status, token)
                } else {
                    completion(status, nil)
                }
                
            case .failure:
                completion(status, nil)
            }
        }
        
    }
    
    static func kakaologin(_ accessToken: String, completion:@escaping (_ result:Int,_ token: String?) -> Void) {
        
        let url = "\(kBaseURL)rest-auth/kakao/"
        let params = ["access_token" : accessToken]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response) in
            let status = response.response?.statusCode ?? 999
            switch response.result {
            case .success:
                if let json = response.result.value as? [String : Any],
                    let token = json["token"] as? String {
                    completion(status, token)
                } else {
                    completion(status, nil)
                }
            case .failure:
                completion(status, nil)
            }
        }
        
    }
    
    static func register(_ id:String, password:String, completion:@escaping (_ result: Int,_ token: String?) -> Void) {
        
        let url = "\(kBaseURL)rest-auth/registration/"
        let params = ["email" : id, "password1" : password, "password2" : password]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response) in
            let status = response.response?.statusCode ?? 999
            switch response.result {
            case .success:
                if let json = response.result.value as? [String : Any],
                    let token = json["token"] as? String{
                    completion(status, token)
                } else {
                    completion(status, nil)
                }
            case .failure:
                completion(status, nil)
            }
        }
        
    }
    
    static func getUserInfo(token: String? = nil, completion:@escaping (_ result: Int, _ user: User?) -> Void) {
        let url = "\(kBaseURL)userinfo/"
        var headers: HTTPHeaders?
        if let token = token {
            headers = ["Authorization" : "JWT \(token)",
                "PushToken" : User.fetchDeviceKey()]
        } else {
            headers = User.me?.httpHeaders()
        }
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            let status = response.response?.statusCode ?? 999
            switch response.result {
            case .success:
                if let json = response.result.value as? [[String : Any]] {
                    if json.count == 0 {
                        completion(status, nil)
                        print("유저인포 없음")
                    } else {
                        completion(status, User(withDic: json.first!))
                        print("유저인포 있음")
                    }
                    
                } else {
                    completion(status, nil)
                }
                
            case .failure:
                completion(status, nil)
            }
        }
    }
    
    static func createUserInfo(token: String, user: User,  completion:@escaping (_ result: Int) -> Void) {
        let url = "\(kBaseURL)userinfo/"
        let headers: HTTPHeaders? = ["Authorization" : "JWT \(token)"]
        let params = user.toJSON()
        print("//\(token)//")
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            let status = response.response?.statusCode ?? 999
            completion(status)
        }
    }
    
    static func updateUserInfo(params: [String : Any],  completion:@escaping (_ result: Int) -> Void) {
        let url = "\(kBaseURL)userinfo/"
        let headers: HTTPHeaders? = User.me?.httpHeaders()
        Alamofire.request(url, method: .put, parameters: params, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            let status = response.response?.statusCode ?? 999
            completion(status)
        }
    }
    
    static func deleteUserInfo(completion:@escaping (_ result: Int) -> Void) {
        let url = "\(kBaseURL)userinfo/"
        let headers: HTTPHeaders? = User.me?.httpHeaders()
        Alamofire.request(url, method: .delete, parameters: nil, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            let status = response.response?.statusCode ?? 999
            completion(status)
        }
    }
    
    static func getVideoList(completion:@escaping (_ result: Int, _ exercises: [Exercise]) -> Void) {
        let url = "\(kBaseURL)video/"
        let headers: HTTPHeaders? = User.me?.httpHeaders()
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            let status = response.response?.statusCode ?? 999
            switch response.result {
            case .success:
                if let json = response.result.value as? [[String : Any]] {
                    var arr = [Exercise]()
                    for dic in json {
                        arr.append(Exercise(withDic: dic))
                    }
                    completion(status, arr)
                } else {
                    completion(status, [])
                }
            case .failure:
                completion(status, [])
            }
        }
    }
    
    static func getVideoList(byListID id: Int, completion:@escaping (_ result: Int, _ exercises: [Exercise]) -> Void) {
        let url = "\(kBaseURL)videolist/\(id)"
        let headers: HTTPHeaders? = User.me?.httpHeaders()
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            let status = response.response?.statusCode ?? 999
            switch response.result {
            case .success:
                if let json = response.result.value as? [[String : Any]] {
                    var arr = [Exercise]()
                    for dic in json {
                        arr.append(Exercise(withDic: dic))
                    }
                    completion(status, arr)
                } else {
                    completion(status, [])
                }
            case .failure:
                completion(status, [])
            }
        }
    }
    
    static func getRecommendList(completion:@escaping (_ result: Int, _ items: [CardViewModelItem]) -> Void) {
        let url = "\(kBaseURL)recommend/"
        let headers: HTTPHeaders? = User.me?.httpHeaders()
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            let status = response.response?.statusCode ?? 999
            switch response.result {
            case .success:
                if let json = response.result.value as? [[String : Any]] {
                    var arr = [CardViewModelItem]()
                    for dic in json {
                        arr.append(CardViewModelItem(withDic: dic))
                    }
                    completion(status, arr)
                } else {
                    completion(status, [])
                }
            case .failure:
                completion(status, [])
            }
        }
    }
    
    static func logout(completion:@escaping (_ result: Int) -> Void) {
        let url = "\(kBaseURL)rest-auth/logout/"
        let headers: HTTPHeaders? = User.me?.httpHeaders()
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            let status = response.response?.statusCode ?? 999
            completion(status)
        }
    }
}
