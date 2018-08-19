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
        let corners: UIRectCorner = [.topRight, .topLeft, .bottomLeft, .bottomRight]
        let path = UIBezierPath(roundedRect:cardView.bounds,
                                byRoundingCorners:corners,
                                cornerRadii: CGSize(width: 15, height:  15))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        cardView.layer.mask = maskLayer
    }
    func setCorner(selected: Bool) {
        let corners: UIRectCorner = !selected ? [.topRight, .topLeft] : [.topRight, .topLeft, .bottomLeft, .bottomRight]
        let path = UIBezierPath(roundedRect:cardView.bounds,
                                byRoundingCorners:corners,
                                cornerRadii: CGSize(width: 15, height:  15))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        
        self.cardView.layer.mask = maskLayer
    }
}
