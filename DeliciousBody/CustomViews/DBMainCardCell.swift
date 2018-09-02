//
//  DBMainCardCell.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 4. 10..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBMainCardCell: UITableViewCell {

    @IBOutlet var cardView: UIView!
    override func awakeFromNib() {
        cardView.layer.applyMainShadow(withCorner: true)
    }
}
