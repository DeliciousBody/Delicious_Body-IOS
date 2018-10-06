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

class DBLoginViewController: DBViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: DBTextField!
    @IBOutlet weak var pwTextField: DBTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setKeyboardHide()
        self.setTextFields()
    }
    
    func setTextFields() {
        emailTextField.innerTextField.delegate = self
        emailTextField.textFieldType = .email
        emailTextField.changeHandler = { [weak self] text in
            if(!DBValidater.isValidEmail(testStr: text) && text.count > 3) {
                self?.emailTextField.innerTextField.errorMessage = "올바른 이메일 주소를 입력하십시오."
            } else {
                self?.emailTextField.innerTextField.errorMessage = ""
            }
        }
        
        pwTextField.innerTextField.delegate = self
        pwTextField.innerTextField.isSecureTextEntry = true
        pwTextField.changeHandler = { [weak self] text in
            self?.pwTextField.innerTextField.errorMessage = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            pwTextField.innerTextField.becomeFirstResponder()
        } else {
            view.endEditing(true)
        }
        return true
    }
    
    @IBAction func loginButtonPressed(_ sender: DBRoundButton) {
        guard let email = emailTextField.innerTextField.text,
            let password = pwTextField.innerTextField.text else {
                sender.shake()
                return
        }
        
        guard DBValidater.isValidEmail(testStr: email) else {
            sender.shake()
            return
        }
            
        DBNetworking.login(email, password: password) { (result, token) in
            if result == 200 {
                if let JWTtoken = token {
                    DBNetworking.getUserInfo(token: JWTtoken, completion: { (result, user) in
                        if let user = user {
                            User.me = user
                            user.token = JWTtoken
                            user.save()
                            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                            let mainViewController = storyBoard.instantiateViewController(withIdentifier: "DBMainTabbarController")
                            self.present(mainViewController, animated: true, completion: nil)
                        }
                    })
                } else {
                    sender.shake()
                    self.emailTextField.innerTextField.errorMessage = "이메일 또는 비밀번호가 올바르지 않습니다."
                    self.pwTextField.innerTextField.errorMessage = " "
                }
            } else {
                self.emailTextField.innerTextField.errorMessage = "이메일 또는 비밀번호가 올바르지 않습니다."
                self.pwTextField.innerTextField.errorMessage = " "
                sender.shake()
            }
        }
    }
    
    @IBAction func kakaoLoginButtonPressed(_ sender: Any) {
        KOSession.shared().close()
        KOSession.shared().open { (error) in
            if KOSession.shared().isOpen() {
                let token = KOSession.shared().token.accessToken
                DBNetworking.kakaologin(token, completion: { (result, token) in
                    if let jwtToken = token {
                        DBNetworking.getUserInfo(token: jwtToken, completion: { (result, user) in
                            guard result == 200 else { return }
                            if let user = user {
                                User.me = user
                                user.token = jwtToken
                                user.save()
                                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                let mainViewController = storyBoard.instantiateViewController(withIdentifier: "DBMainTabbarController")
                                self.present(mainViewController, animated: true, completion: nil)
                            } else {
                                let user = User()
                                user.token = jwtToken
                                KOSessionTask.talkProfileTask(completionHandler: { (data, error) in
                                    if let profile = data as? KOTalkProfile {
                                        user.photoUrl = profile.profileImageURL
                                        user.name = profile.nickName
                                        DBNetworking.createUserInfo(token: jwtToken, user: user, completion: { (result) in
                                            if result == 201 {
                                                User.me = user
                                                user.save()
                                                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                                let mainViewController = storyBoard.instantiateViewController(withIdentifier: "DBMainTabbarController")
                                                self.present(mainViewController, animated: true, completion: nil)
                                            }
                                        })
                                        
                                    } else {
                                        print(error.debugDescription)
                                    }
                                })
                            }
                        })
                    }
                })
            } else {
                print(error.debugDescription)
            }
        }
    }
}
