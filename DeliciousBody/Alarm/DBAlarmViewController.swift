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

    @IBOutlet weak var view_Week: UIView!
    @IBOutlet weak var view_Weekend: UIView!
    
    @IBOutlet weak var slider_Week: RangeSeekSlider!
    @IBOutlet weak var slider_Weekend: RangeSeekSlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slider_Week.numberFormatter = {
            let formatter = NumberFormatter()
            formatter.positiveSuffix = "시"
            return formatter
        }()
        
        slider_Week.minLabelFont = UIFont.sliderLabelFont
        slider_Week.maxLabelFont = UIFont.sliderLabelFont
        
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
            view_Week.isHidden = false
            UIView.animate(withDuration: duration
                , animations: { [weak self] in
                    self?.view_Weekend.alpha = 1.0
                    self?.view_Week.alpha = 1.0
            })
        } else {
            UIView.animate(withDuration: duration, animations: { [weak self] in
                self?.view_Weekend.alpha = 0.0
                self?.view_Week.alpha = 0.0
            }) { [weak self] (_)  in
                self?.view_Weekend.isHidden = true
                self?.view_Week.isHidden = true
            }
        }
    }

    @IBAction func optionAlarmOnOff(_ sender: UISwitch) {
        let slider: RangeSeekSlider = sender.tag == 0 ? slider_Week : slider_Weekend
        slider.colorBetweenHandles = sender.isOn ? UIColor.themeBlue : UIColor.subGray216
        slider.maxLabelColor = sender.isOn ? UIColor.themeBlue : UIColor.subGray216
        slider.minLabelColor = sender.isOn ? UIColor.themeBlue : UIColor.subGray216
        slider.layoutSubviews()
    }
}
