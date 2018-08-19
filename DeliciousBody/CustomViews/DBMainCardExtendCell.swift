//
//  DBMainFooterCell.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 8. 19..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit
extension CALayer {
    func applyMainShadow() {
        shadowColor = UIColor.black.cgColor
        shadowOpacity = 0.3
        shadowOffset = CGSize(width: 0, height: 2)
        shadowRadius = 5
        cornerRadius = 15
    }
}

class DBMainCardExtendCell: UITableViewCell {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var closeButton: UIView!
    @IBOutlet weak var tableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.applyMainShadow()
        
        let corners: UIRectCorner = [.bottomLeft, .bottomRight]
        let path = UIBezierPath(roundedRect:closeButton.bounds,
                                byRoundingCorners:corners,
                                cornerRadii: CGSize(width: 15, height: 15))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        closeButton.layer.mask = maskLayer
    }
}
