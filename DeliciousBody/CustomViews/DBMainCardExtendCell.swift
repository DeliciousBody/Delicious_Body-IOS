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
    @IBOutlet weak var closeButton: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.cornerRadius = 15
        shadowView.layer.applyMainShadow(withCorner: true)
        
        closeButton.layer.applyCornerRadius(corners: [.bottomLeft, .bottomRight])
        thumbnailView.layer.applyCornerRadius(corners: [.topLeft, .topRight])
    }
}
