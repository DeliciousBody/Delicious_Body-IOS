//
//  DBDescViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 10. 1..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBDescViewController: DBViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    var option = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        titleLabel.text = option == 0 ? "개인 정보 정책" : "이용 약관"
        textView.text = option == 0 ? kPrivateDesc : kUseDesc
    }
}
