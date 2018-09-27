//
//  DBStartViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 8. 16..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBStartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(DBStartViewController.appDidBecomeActive), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(DBStartViewController.didLogout), name: NSNotification.Name(rawValue: kDidLogoutNotification), object: nil)
    }
    
    @objc func appDidBecomeActive() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        self.show()
    }
    
    @objc func didLogout() {
        self.show()
    }
    
    fileprivate func show() {
        //Network Check
        /*
         if !Reachability.isConnectedToNetwork() {
         self.animateSegue()
         return
         }*/
        
        if User.fetchToken() != nil {
            self.animateSegue("Main", sender: nil)
        } else {
            self.animateSegue("Login", sender: nil)
        }
    }
    
    func animateSegue(_ identifier:String,sender:AnyObject?) {
        self.performSegue(withIdentifier: identifier, sender: sender)
    }
}
