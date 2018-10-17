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
    @IBAction func pop(segue: UIStoryboardSegue) {}
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(DBStartViewController.appDidBecomeActive), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    @objc func appDidBecomeActive() {
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        if let AppDelegate = UIApplication.shared.delegate as? AppDelegate, let exer = AppDelegate.exer {
            let vc = UIStoryboard.viewController(storyBoard: "Home", withID: "DBVideoViewController") as! DBVideoViewController
            vc.exercise = exer
            AppDelegate.exer = nil
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func setKeyboardHide() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DBViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    func showAlert(title: String, content: String) {
        let alert = UIAlertController(title: title, message: content, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
