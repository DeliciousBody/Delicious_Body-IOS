//
//  DBMainCardCell.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 4. 10..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit
import Kingfisher
class DBMainCardCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet var cardView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    override func awakeFromNib() {
        cardView.layer.cornerRadius = 15
        shadowView.layer.applyMainShadow(withCorner: true)
    }
    
    func configure(item: CardViewModelItem) {
        nameLabel.text = item.list_name
        descLabel.text = "\(item.rowCount)개의 운동 | \(secToString(sec: item.time)) 소요"
        thumbnailImageView.kf.setImage(with: URL(string: item.list_image))
    }
}
