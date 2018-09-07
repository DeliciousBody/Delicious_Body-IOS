//
//  DBVideoFilterViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 9. 7..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBVideoFilterViewController: UIViewController {

    @IBOutlet weak var bodyView: DBBodyView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyView.handler = { filter in
            print(filter)
        } 
    }
}
