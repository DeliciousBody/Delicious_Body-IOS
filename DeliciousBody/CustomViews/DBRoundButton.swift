//
//  DBRoundButton.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 8. 20..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBRoundButton: UIButton {
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = 4
        layer.masksToBounds = true
    }
}
