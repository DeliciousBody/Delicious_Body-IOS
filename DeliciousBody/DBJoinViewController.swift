//
//  DBJoinViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 5. 23..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBJoinViewController: UIViewController {

    @IBOutlet weak var mainTextField: DBTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFields()

    }
    
    func setTextFields() {
        mainTextField.changeHandler = { [weak self] text in
            if text.contains("@"){
                self?.mainTextField.setCheck(check: true)
            } else {
                self?.mainTextField.setCheck(check: false)
            }
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
