//
//  DBMainCardCell.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 4. 10..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBMainCardCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet var cardView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    override func awakeFromNib() {
        cardView.layer.cornerRadius = 15
        shadowView.layer.applyMainShadow(withCorner: true)
    }
}
