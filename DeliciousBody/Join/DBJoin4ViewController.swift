//
//  DBJoin4ViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 5. 30..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBJoin4ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else {
            return
        }
        
        if id.contains("join") {
            let vc = segue.destination as! DBJoinEmbededViewController
            vc.contentString = kJoinTitles[segue.identifier!]
        }
    }

}
