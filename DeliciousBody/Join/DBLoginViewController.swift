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
        DBNetworking.login("", password: "") { (result, data) in
            if true {//result == 200 {
                if true {//let user = data {
                User().save()
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let mainViewController = storyBoard.instantiateViewController(withIdentifier: "DBMainTabbarController")
                    self.present(mainViewController, animated: true, completion: nil)
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
