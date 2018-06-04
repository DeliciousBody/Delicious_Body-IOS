//
//  DBJoinViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 5. 23..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBJoin1ViewController: UIViewController {

    @IBOutlet weak var mainTextField: DBTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.shadowImage = UIImage()
        
    }
    
    func setTextFields() {
        mainTextField.changeHandler = { [weak self] text in
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
