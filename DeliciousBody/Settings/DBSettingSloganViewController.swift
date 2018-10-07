//
//  DBSettingSloganViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 9. 10..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBSettingSloganViewController: UIViewController {
    @IBOutlet weak var inputTextField: DBTextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
        
        inputTextField.text = User.me?.slogan
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
