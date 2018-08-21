//
//  DBPasswdViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 8. 21..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBPasswdViewController: DBViewController {

    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var resetLabel: UILabel!
    @IBOutlet weak var confirmLabel: UILabel!
    @IBOutlet weak var resetButton: DBRoundButton!
    @IBOutlet weak var buttonWidthConst: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setKeyboardHide()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        imageView1.FadeOutWithrotate()
        imageView2.FadeIntWithrotate()
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {
            self.buttonWidthConst.constant = 180
            sender.setTitle("로그인으로 돌아가기", for: .normal)
            self.view.layoutIfNeeded()
        }) { (success) in
        }
        UIView.animate(withDuration: 0.13, delay: 0, options: .curveEaseIn, animations: {
            self.resetLabel.alpha = 0
            self.confirmLabel.alpha = 1
        }) { (success) in
        }
    }
}
