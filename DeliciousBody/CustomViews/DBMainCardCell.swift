//
//  DBMainCardCell.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 4. 10..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit
import Kingfisher
import Windless

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
        if item.list_name == "default" {
            thumbnailImageView.windless.start()
        } else {
            nameLabel.text = item.list_name
            descLabel.text = "\(item.rowCount)개의 운동 | \(secToString(sec: item.time)) 소요"
            thumbnailImageView.kf.setImage(with: URL(string: item.list_image))
        }
    }
}

class DBMainDefaultCardCell: UITableViewCell {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet var cardView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    override func awakeFromNib() {
        cardView.layer.cornerRadius = 15
        shadowView.layer.applyMainShadow(withCorner: true)
    }
    
    func configure() {
        thumbnailImageView.windless.start()
    }
}
