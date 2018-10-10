//
//  DBSettingPasswdViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 10. 10..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBSettingPasswdViewController: DBViewController {

    @IBOutlet weak var textField1: DBTextField!
    @IBOutlet weak var textField2: DBTextField!
    @IBOutlet weak var textField3: DBTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setKeyboardHide()
        textField1.innerTextField.becomeFirstResponder()
        textField1.innerTextField.isSecureTextEntry = true
        textField2.innerTextField.isSecureTextEntry = true
        textField3.innerTextField.isSecureTextEntry = true
        
        textField1.changeHandler = { [weak self] text in
            self?.textField1.innerTextField.errorMessage = ""
        }
        
        textField2.changeHandler = { [weak self] text in
            if text.count < 8 {
                self?.textField2.innerTextField.errorMessage = "비밀번호는 8자 이상이어야 합니다."
            } else {
                self?.textField2.innerTextField.errorMessage = ""
            }
        }
        
        textField3.changeHandler = { [weak self] text in
            if text.count > 7 && text != self?.textField2.innerTextField.text {
                self?.textField3.innerTextField.errorMessage = "비밀번호가 일치하지 않습니다."
            } else {
                self?.textField3.innerTextField.errorMessage = ""
            }
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor.themeBlue84102255
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = false
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        guard let text1 = textField1.text else {
            textField1.shake()
            return
        }
        
        guard let text2 = textField2.text else {
            textField2.shake()
            return
        }
        
        guard let text3 = textField3.text else {
            textField3.shake()
            return
        }
        
        guard text2 == text3 else {
            textField3.shake()
            return
        }
        
        DBNetworking.editPassword(password1: text1, password2: text2, password3: text3) { (result) in
            if result == 200 {
                self.navigationController?.popViewController(animated: true)
            } else {
                self.showAlert(title: "오류", content: "비밀번호 변경에 실패하였습니다.")
            }
        }
    }
}
