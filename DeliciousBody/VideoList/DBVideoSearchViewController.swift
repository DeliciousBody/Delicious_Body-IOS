//
//  DBVideoSearchViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 9. 5..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBVideoSearchViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var emptyImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let attributes = [
            kCTForegroundColorAttributeName: UIColor(red: 126 / 255.0, green: 126 / 255.0, blue: 126 / 255.0, alpha: 1),
            kCTFontAttributeName : UIFont(name: "AppleSDGothicNeo-Medium", size: 12.0)!
        ]
        inputTextField.attributedPlaceholder = NSAttributedString(string: "운동 부위 / 이름을 검색하세요.  예) 목, 거북목", attributes:attributes as [NSAttributedStringKey : Any])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emptyImageView.transform = CGAffineTransform(scaleX: 0, y: 0)
        emptyImageView.isHidden = false
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.emptyImageView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}

