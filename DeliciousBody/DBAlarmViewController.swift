//
//  DBAlarmViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 5. 2..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit
import RangeSeekSlider

class DBAlarmViewController: UIViewController {

    @IBOutlet weak var slider_Weekend: RangeSeekSlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        slider_Weekend.numberFormatter = {
           let formatter = NumberFormatter()
            formatter.positiveSuffix = "시"
            return formatter
        }()
        
        slider_Weekend.minLabelFont = UIFont.sliderLabelFont
        slider_Weekend.maxLabelFont = UIFont.sliderLabelFont
        
    }

}
