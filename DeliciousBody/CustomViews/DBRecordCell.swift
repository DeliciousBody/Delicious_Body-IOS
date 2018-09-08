//
//  DBRecordCell.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 9. 8..
//  Copyright © 2018년 changmin. All rights reserved.
//
import UIKit

class DBRecordCell: UICollectionViewCell {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var gageViewWidth: NSLayoutConstraint!
    @IBOutlet weak var recordLabel: UILabel!
    
    let gageMaxWidth: CGFloat = 180
    
    override func awakeFromNib() {
        super.awakeFromNib()
        typeLabel.layer.cornerRadius = 4
        typeLabel.clipsToBounds = true
    }
    
    func configure(type: BodyType, percent: Float, record: Int) {
        typeLabel.text = "   " + type.description() + "   "
        gageViewWidth.constant = gageMaxWidth * CGFloat(percent)
        
        let recordStr = NSMutableAttributedString(string: "\(record)회", attributes: [
            .font: UIFont(name: "AppleSDGothicNeo-Bold", size: 14.0)!,
            .foregroundColor: UIColor(red: 84.0 / 255.0, green: 102.0 / 255.0, blue: 1.0, alpha: 1.0),
            .kern: 0.0
            ])
        recordStr.addAttribute(.font, value: UIFont(name: "AppleSDGothicNeo-Light", size: 12.0)!, range: NSRange(location: recordStr.length - 1, length: 1))
        
        recordLabel.attributedText = recordStr
    }
}
