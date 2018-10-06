//
//  DBJoinViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 5. 23..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "desc" {
            let option = sender as! Int
            let vc = segue.destination as! DBDescViewController
            vc.option = option
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y = 0
            }
        }
    }
    
    func setTextFields() {
        emailTextField.innerTextField.delegate = self
        emailTextField.changeHandler = { [weak self] text in
            self?.emailTextField.setCheck(check: DBValidater.isValidEmail(testStr: text))
        }
        
        passwdTextField.innerTextField.delegate = self
        passwdTextField.innerTextField.isSecureTextEntry = true
        passwdTextField.changeHandler = { [weak self] text in
            self?.passwdTextField.setCheck(check: text.count > 7)
        }
        
        nameTextField.innerTextField.delegate = self
        nameTextField.changeHandler = { [weak self] text in
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
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        guard nameTextField.isCheck && emailTextField.isCheck && passwdTextField.isCheck else { return }
        let user = User()
        user.name = nameTextField.innerTextField.text
        User.me = user
        
        if let email = emailTextField.innerTextField.text,
            let passwd = passwdTextField.innerTextField.text {
            
            DBNetworking.register(email, password: passwd) { (result, data) in
                if result == 201, let token = data{
                    user.token = token
                   
                    DBNetworking.updateUserInfo(params: ["name" : user.name!], completion: { (result) in
                        if result == 200 {
                            self.performSegue(withIdentifier: "next", sender: nil)
                        }
                    })
                }
            }
            
        }
    }
    
}
