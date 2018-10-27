//
//  DBHistoryCell.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 10. 17..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBHistoryCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var likeButton: DBButton!
    var likeHandler: ((Int) -> ())?
    var videoID: Int = 0
    
    @IBAction func likeButtonPressed(_ sender: DBButton) {
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
//        thumbnailImage.kf.setImage(with: URL(string: exer.video_thumbnail))
        
        thumbnailImage.image = DBCache.shared.loadImage(key: "\(exer.video_id)img") ?? #imageLiteral(resourceName: "sample_history")
        titleLabel.text = exer.video_name
        videoID = exer.video_id
        subtitleLabel.text = "\(exer.main_partString) | \(exer.levelString)"
        if let me = User.me {
            likeButton.isSelected = me.isFavoriteVideo(id: exer.video_id)
        }
    }
}
