//
//  DBJoinEmbededViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 5. 28..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBJoinEmbededViewController: UIViewController {

    @IBOutlet weak var contentLabel: UILabel!
    var contentString: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        contentLabel.text = contentString
        // Do any additional setup after loading the view.
    }
}
