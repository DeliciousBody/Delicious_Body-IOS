//
//  DBExerCell.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 4. 14..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit
import Kingfisher
class DBExerCell: UITableViewCell {

    @IBOutlet var exerImageView: UIImageView!
    @IBOutlet var exerCategoryLabel: UILabel!
    @IBOutlet var exerTitleLabel: UILabel!
    @IBOutlet var exerDiscLabel: UILabel!
    @IBOutlet weak var exerTimeLabel: UILabel!
    @IBOutlet weak var likeButton: DBButton!
    var likeHandler: ((Int) -> ())?
    var videoID: Int = 0
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        if let me = User.me {
            me.setFavoriteVideo(id: videoID, isLike: !sender.isSelected)
            DBNetworking.updateUserInfo(params: ["favorite_list" : me.favorite_list ?? []]) { (result) in
                if result == 200 {
                    me.save()
                }
            }
        }
        likeHandler?(videoID)
    }
    
    func configure(exer: Exercise) {
        if let url = URL(string: exer.video_thumbnail) {
            let image = ImageResource(downloadURL: url, cacheKey: exer.video_thumbnail)
            exerImageView.kf.setImage(with: image)
        }
        exerTitleLabel.text = exer.video_name
        exerTimeLabel.text = secToString(sec: exer.time)
        videoID = exer.video_id
        exerDiscLabel.text = "\(exer.main_partString) | \(exer.levelString)"
        if let me = User.me {
            likeButton.isSelected = me.isFavoriteVideo(id: exer.video_id)
        }
    }
}

class DBDescCell: UITableViewCell {
    @IBOutlet weak var descTextView: UITextViewFixed!
}
