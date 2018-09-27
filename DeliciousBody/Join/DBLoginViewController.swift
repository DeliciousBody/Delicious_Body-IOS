//
//  DBLoginViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 8. 21..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import KakaoOpenSDK

class DBLoginViewController: DBViewController {

    @IBOutlet weak var emailTextField: DBTextField!
    @IBOutlet weak var pwTextField: DBTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setKeyboardHide()   
    }
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        let user = User()
        user.save()
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyBoard.instantiateViewController(withIdentifier: "DBMainTabbarController")
        self.present(mainViewController, animated: true, completion: nil)
    }
    @IBAction func kakaoLoginButtonPressed(_ sender: Any) {
        KOSession.shared().close()
        KOSession.shared().open { (error) in
            if KOSession.shared().isOpen() {
                let token = KOSession.shared().token.accessToken
                print("token : ", token)
                let user = User()
                KOSessionTask.talkProfileTask(completionHandler: { (data, error) in
                    if let profile = data as? KOTalkProfile {
                        user.photoUrl = profile.profileImageURL
                        user.name = profile.nickName
                        user.token = token
                        user.save()
                        
                        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                        let mainViewController = storyBoard.instantiateViewController(withIdentifier: "DBMainTabbarController")
                        self.present(mainViewController, animated: true, completion: nil)
                    } else {
                        print(error.debugDescription)
                    }
                })
                
            } else {
                print(error.debugDescription)
            }
        }
        
    }
}
