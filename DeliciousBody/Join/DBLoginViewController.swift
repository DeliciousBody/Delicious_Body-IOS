//
//  DBLoginViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 8. 21..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class DBLoginViewController: DBViewController {

    @IBOutlet weak var emailTextField: DBTextField!
    @IBOutlet weak var pwTextField: DBTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setKeyboardHide()   
    }
}
