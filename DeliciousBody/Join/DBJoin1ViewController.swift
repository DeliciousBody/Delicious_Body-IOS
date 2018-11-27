//
//  DBJoinViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 5. 23..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit
import KakaoOpenSDK
class DBJoin1ViewController: DBViewController, UITextFieldDelegate{
    
    @IBOutlet weak var emailTextField: DBTextField!
    @IBOutlet weak var passwdTextField: DBTextField!
    @IBOutlet weak var nameTextField: DBTextField!
    @IBOutlet weak var checkBox: UIButton!
    var isChecked: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setKeyboardHide()
        self.setTextFields()
        NotificationCenter.default.addObserver(self, selector: #selector(DBJoin1ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(DBJoin1ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let _ = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y = 0
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "desc" {
            let option = sender as! Int
            let vc = segue.destination as! DBDescViewController
            vc.option = option
        }
    }
    
    
    func setTextFields() {
        emailTextField.innerTextField.delegate = self
        emailTextField.changeHandler = { [weak self] text in
            if !DBValidater.isValidEmail(testStr: text) {
                self?.emailTextField.innerTextField.errorMessage = "올바른 이메일 주소를 입력하십시오."
            } else {
                self?.emailTextField.innerTextField.errorMessage = ""
            }
            self?.emailTextField.setCheck(check: DBValidater.isValidEmail(testStr: text))
            
        }
        
        passwdTextField.innerTextField.delegate = self
        passwdTextField.tag = 1
        passwdTextField.innerTextField.isSecureTextEntry = true
        passwdTextField.changeHandler = { [weak self] text in
            if text.count > 7 {
                self?.passwdTextField.innerTextField.errorMessage = ""
            } else {
                self?.passwdTextField.innerTextField.errorMessage = "비밀번호는 8자 이상이어야 합니다."
            }
            self?.passwdTextField.setCheck(check: text.count > 7)
        }
        
        nameTextField.innerTextField.delegate = self
        nameTextField.tag = 2
        nameTextField.changeHandler = { [weak self] text in
            if text.count > 2 {
                self?.nameTextField.innerTextField.errorMessage = ""
            } else {
                self?.nameTextField.innerTextField.errorMessage = "이름은 3자 이상이어야 합니다."
            }
            self?.nameTextField.setCheck(check: text.count > 2)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            passwdTextField.innerTextField.becomeFirstResponder()
        } else if textField.tag == 1 {
            nameTextField.innerTextField.becomeFirstResponder()
        } else {
            view.endEditing(true)
        }
        return true
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func checkBoxPressed(_ sender: Any) {
        isChecked = !isChecked
        checkBox.isSelected = isChecked
    }
    
    @IBAction func descButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "desc", sender: sender.tag)
    }
    
    @IBAction func kakaoJoinPressed(_ sender: Any) {
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
                                user.id = "카카오톡"
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
                                        User.me = user
                                        user.id = "카카오톡"
                                        user.save()
                                        
                                        let storyBoard = UIStoryboard(name: "Join", bundle: nil)
                                        let mainViewController = storyBoard.instantiateViewController(withIdentifier: "DBJoinNavigationController")
                                        self.present(mainViewController, animated: true, completion: nil)
                                    } else {
                                        self.showAlert(title: "오류", content: "카카오 로그인에 실패하였습니다..")
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
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        let textFields: [DBTextField] = [emailTextField, passwdTextField, nameTextField]
        
        for field in textFields {
            if !field.isCheck {
                field.shake()
                return
            }
        }
        
        let user = User()
        user.name = nameTextField.text
        user.is_subscription = self.isChecked
        User.me = user
        
        if let email = emailTextField.text,
            let passwd = passwdTextField.text,
            let name = nameTextField.text {
            DBIndicator.shared.show()
            DBNetworking.register(email, password: passwd, name: name) { (result, data) in
                if result == 201, let token = data{
                    user.token = token
                    user.id = email
                    user.save()

                    self.performSegue(withIdentifier: "next", sender: nil)
                } else if result == 400 {
                    DBIndicator.shared.stop()
                    self.showAlert(title: "오류", content: "이미 가입된 이메일입니다.")
                } else {
                    DBIndicator.shared.stop()
                    self.showAlert(title: "오류", content: "회원가입에 실패하였습니다.")
                }
            }
            
        }
    }
}
