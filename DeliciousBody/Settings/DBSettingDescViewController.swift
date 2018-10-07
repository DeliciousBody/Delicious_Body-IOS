//
//  DBSettingDescViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 10. 8..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBSettingDescViewController: DBViewController {

    @IBOutlet weak var textView: UITextView!
    var descript: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = descript
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor.themeBlue84102255
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = false
        UIApplication.shared.statusBarStyle = .lightContent
    }
}
