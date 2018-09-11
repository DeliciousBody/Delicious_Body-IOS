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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func backbuttonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func checkbuttonPressed(_ sender: Any) {
        if let slogan = inputTextField.innerTextField.text {
            User.me?.slogan = slogan
            User.me?.save()
            navigationController?.popViewController(animated: true)
        } else {
            
        }
    }
}
