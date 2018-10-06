//
//  DBIndicator.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 10. 6..
//  Copyright © 2018년 changmin. All rights reserved.
//

import Foundation
import UIKit
import SwiftGifOrigin

class DBIndicator: UIView {
    static let shared = DBIndicator()
    
    var filterColor: UIColor = .black
    var filterAlpha: CGFloat = 0.5
    var gifName: String = "indicator"
    
    lazy var filterView: UIView = {
        let filterView = UIView(frame: UIScreen.main.bounds)
        filterView.backgroundColor = filterColor.withAlphaComponent(filterAlpha)
        filterView.isUserInteractionEnabled = false
        return filterView
    }()
    
    lazy var gifImage: UIImageView = {
        let gifImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        gifImage.contentMode = .scaleAspectFit
        gifImage.center = filterView.center
        gifImage.isUserInteractionEnabled = false
        gifImage.loadGif(name: gifName)
        return gifImage
    }()
    
    func show() {
        self.addSubview(filterView)
        self.filterView.addSubview(gifImage)
        self.filterView.bringSubview(toFront: self.gifImage)
        UIApplication.shared.keyWindow?.addSubview(filterView)
    }
    
    func stop() {
        self.filterView.removeFromSuperview()
    }
    
}
