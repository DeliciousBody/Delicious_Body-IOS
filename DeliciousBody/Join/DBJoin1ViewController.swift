//
//  DBJoinViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 5. 23..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBJoin1ViewController: DBViewController {

    @IBOutlet weak var emailTextField: DBTextField!
    @IBOutlet weak var passwdTextField: DBTextField!
    @IBOutlet weak var nameTextField: DBTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setKeyboardHide()
        self.setTextFields()
        NotificationCenter.default.addObserver(self, selector: #selector(DBJoin1ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(DBJoin1ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.shadowImage = UIImage()
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
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
        nameTextField.changeHandler = { [weak self] text in
            self?.nameTextField.setCheck(check: text.count > 0)
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func confirmButtonPressed(_ sender: Any) {
        guard nameTextField.isCheck else { return }
        let user = User()
        user.name = nameTextField.innerTextField.text
        User.me = user
        performSegue(withIdentifier: "next", sender: nil)
    }
    
}
