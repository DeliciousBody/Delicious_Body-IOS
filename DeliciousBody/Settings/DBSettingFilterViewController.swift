//
//  DBSettingFilterViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 9. 24..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBSettingFilterViewController: DBViewController {

    @IBOutlet weak var bodyView: DBBodyView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
