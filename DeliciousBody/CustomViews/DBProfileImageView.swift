//
//  DBProfileImageView.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 9. 9..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBProfileImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.subGray190.cgColor
        self.layer.borderWidth = 1
    }
}
