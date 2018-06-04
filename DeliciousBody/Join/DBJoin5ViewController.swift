//
//  DBJoin5ViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 5. 30..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBJoin5ViewController: UIViewController {

    @IBOutlet weak var inputTextField: DBTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextField.changeHandler = { [weak self] text in
            self?.inputTextField.setCheck(check: text.count > 0)
        }
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
