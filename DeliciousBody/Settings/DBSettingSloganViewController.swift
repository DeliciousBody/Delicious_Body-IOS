//
//  DBSettingSloganViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 9. 10..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBSettingSloganViewController: DBViewController {
    @IBOutlet weak var inputTextField: DBTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setKeyboardHide()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
        
        inputTextField.text = User.me?.slogan
        
        NotificationCenter.default.addObserver(self, selector: #selector(DBJoin1ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(DBJoin1ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                let y = inputTextField.frame.origin.y + 24 + inputTextField.frame.size.height + keyboardSize.height - SCREEN_HEIGHT
                self.view.frame.origin.y -= (y > 0 ? y : 0)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let _ = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y = 0
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        inputTextField.innerTextField.becomeFirstResponder()
    }
    
    @IBAction func backbuttonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func checkbuttonPressed(_ sender: Any) {
        guard let me = User.me else { return }
        if let slogan = inputTextField.text{
            if slogan.count > 0 {
                User.me?.slogan = slogan
            } else {
                User.me?.slogan = kDefaultSlogan
            }
        } else {
            User.me?.slogan = kDefaultSlogan
        }
        DBIndicator.shared.show()
        DBNetworking.updateUserInfo(params: ["comment" : me.slogan]) { (result) in
            if result == 200 {
                me.save()
            }
            DBIndicator.shared.stop()
            self.navigationController?.popViewController(animated: true)
        }
    }
}
