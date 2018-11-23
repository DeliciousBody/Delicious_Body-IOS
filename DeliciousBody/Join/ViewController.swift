//
//  ViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 3. 29..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func test(_ sender: Any) {
        guard let me = User.me else { return }
        
        DBNetworking.updateUserInfo(params: me.toJSON()) { (result) in
            if result == 200 || result == 201 {
                print("success")
            } else {
                print("error")
            }
        }
    }
}

