//
//  DBMainFooterCell.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 8. 19..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBMainCardExtendCell: UITableViewCell {
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var thumbnailView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var closeButton: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.cornerRadius = 15
        shadowView.layer.applyMainShadow(withCorner: true)
        
        closeButton.layer.applyCornerRadius(corners: [.bottomLeft, .bottomRight])
        thumbnailView.layer.applyCornerRadius(corners: [.topLeft, .topRight])
    }
    
    func configure(item: CardViewModelItem) {
        nameLabel.text = item.list_name
        descLabel.text = "\(item.rowCount)개의 운동 | \(secToString(sec: item.time)) 소요"
        thumbnailView.kf.setImage(with: URL(string: item.list_image))
    }
}
