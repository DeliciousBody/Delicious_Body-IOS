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
    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var textFieldWidth: NSLayoutConstraint!
    @IBOutlet weak var textField: DBTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setKeyboardHide()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        guard textField.isValidateEmail else { return }
        imageView1.FadeOutWithrotate()
        imageView2.FadeIntWithrotate()
        
        
        let emailStr = textField.innerTextField.text! as NSString
        let size = emailStr.size(withAttributes: [NSAttributedStringKey.font: UIFont.textFieldFont]).width + 10
        
        UIView.animate(withDuration: 0.08, delay: 0, options: .curveEaseIn, animations: {
            self.buttonWidthConst.constant = 180
            sender.setTitle("로그인으로 돌아가기", for: .normal)
        }) { (success) in }
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.textFieldWidth.constant = size
            self.textField.innerTextField.selectedLineColor = UIColor.clear
            self.view.layoutIfNeeded()
        }) { (finish) in
            self.textField.hideLine()
            self.view.endEditing(true)
        }
        
        UIView.animate(withDuration: 0.13, delay: 0, options: .curveEaseIn, animations: {
            self.loginLabel.alpha = 0
            self.resetLabel.alpha = 0
            self.confirmLabel.alpha = 1
        }) { (success) in }
    }
}