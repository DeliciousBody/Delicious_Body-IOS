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

    @IBOutlet weak var view_Weekend: UIView!
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }

    @IBAction func masterAlarmOnOff(_ sender: UISwitch) {
        let duration = 0.15
        if sender.isOn {
            view_Weekend.isHidden = false
            UIView.animate(withDuration: duration
                , animations: { [weak self] in
                    self?.view_Weekend.alpha = 1.0
            })
        } else {
            UIView.animate(withDuration: duration, animations: { [weak self] in
                self?.view_Weekend.alpha = 0.0
            }) { [weak self] (_)  in
                self?.view_Weekend.isHidden = true
            }
        }
        
        
    }
    
    
    @IBAction func optionAlarmOnOff(_ sender: UISwitch) {
        
        slider_Weekend.colorBetweenHandles = sender.isOn ? UIColor.themeBlue : UIColor.subGray216

        slider_Weekend.layoutSubviews()
    }
    
}
