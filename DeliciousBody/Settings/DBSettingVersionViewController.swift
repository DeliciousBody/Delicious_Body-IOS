//
//  DBSettingVersionViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 10. 10..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBSettingVersionViewController: UIViewController {
    
    var currentVersion: String? = "" {
        didSet {
            currentVersionLabel.text = currentVersion
        }
    }
    var recentVersion: String? = "" {
        didSet {
            recentVersionLabel.text = recentVersion
        }
    }
    @IBOutlet weak var currentVersionLabel: UILabel!
    @IBOutlet weak var recentVersionLabel: UILabel!
    
    @IBOutlet weak var updateButton: DBRoundButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        
        DBNetworking.getVersion { (result, version) in
            if result == 200 {
                self.recentVersion = version
                if self.currentVersion != self.recentVersion {
                    self.updateButton.backgroundColor = UIColor.themeBlue84102255
                    self.updateButton.isEnabled = true
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor.themeBlue84102255
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = false
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    @IBAction func updateButtonPressed(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://itunes.apple.com/app/id1438196177?action=write-review")!, options: [:], completionHandler: nil)
    }
}
