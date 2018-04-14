//
//  DBExerCell.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 4. 14..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBExerCell: UITableViewCell {

    @IBOutlet var exerImageView: UIImageView!
    @IBOutlet var exerCategoryLabel: UILabel!
    @IBOutlet var exerTitleLabel: UILabel!
    @IBOutlet var exerDiscLabel: UILabel!
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        likeHandler?(1)
    }
    
    var likeHandler: ((Int) -> ())?
}
