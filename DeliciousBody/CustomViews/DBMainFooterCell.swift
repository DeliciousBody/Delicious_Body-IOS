//
//  DBMainFooterCell.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 8. 19..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit
extension CALayer {
    func applyMainShadow()
    {
        shadowColor = UIColor.black.cgColor
        shadowOpacity = 0.3
        shadowOffset = CGSize(width: 0, height: 2)
        shadowRadius = 5
        cornerRadius = 15
    }
}

class DBMainFooterCell: UITableViewCell {

    @IBOutlet weak var closeButton: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        closeButton.layer.applyMainShadow()
//        closeButton.layer.shadowColor = UIColor.black.cgColor
//        closeButton.layer.shadowOpacity = 0.3
//        closeButton.layer.shadowOffset = CGSize(width: 0, height: 2)
//        closeButton.layer.shadowRadius = 5
//        closeButton.layer.cornerRadius = 15
//        let rect = closeButton.layer.bounds.insetBy(dx: -3, dy: -3)
//        closeButton.layer.shadowPath = UIBezierPath(rect: rect).cgPath
        
//        let corners: UIRectCorner = [.bottomLeft, .bottomRight]
//        let path = UIBezierPath(roundedRect:closeButton.bounds,
//                                byRoundingCorners:corners,
//                                cornerRadii: CGSize(width: 15, height:  15))
//        let maskLayer = CAShapeLayer()
//        maskLayer.path = path.cgPath
//        closeButton.layer.mask = maskLayer
        
    }
}
