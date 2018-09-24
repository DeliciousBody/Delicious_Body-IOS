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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        inputTextField.innerTextField.becomeFirstResponder()
    }
    
    @IBAction func backbuttonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func checkbuttonPressed(_ sender: Any) {
        if let slogan = inputTextField.innerTextField.text{
            if slogan.count > 0 {
                User.me?.slogan = slogan
                User.me?.save()
                navigationController?.popViewController(animated: true)
            }
        }
    }
}
