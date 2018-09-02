//
//  DBViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 5. 27..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBViewController: UIViewController {
    @IBAction func back(segue: UIStoryboardSegue) {}
    func setKeyboardHide() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DBViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
