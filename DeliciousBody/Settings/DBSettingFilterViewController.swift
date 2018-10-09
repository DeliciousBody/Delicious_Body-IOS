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
    var filter: [BodyType] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyView.handler = { filter in
            self.filter = filter
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
        if let me = User.me {
            let list = me.interested_part?.split(separator: ";").compactMap{Int($0)} ?? []
            bodyView.setSelected(types: list)
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        if let me = User.me {
            let data = filter.map{"\($0.rawValue)"}.joined(separator: ";")
            DBNetworking.updateUserInfo(params: ["interested_part" : data]) { (result) in
                if result == 200 {
                    me.interested_part = data
                    me.save()
                }
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
