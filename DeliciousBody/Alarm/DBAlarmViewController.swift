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
    
    @IBOutlet weak var masterSwitch: UISwitch!
    @IBOutlet weak var weekdaySwitch: UISwitch!
    @IBOutlet weak var weekendSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSlider()
        setData()
    }
    
    func setSlider() {
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
        
        setHandleShadow(slider: slider_Week)
        setHandleShadow(slider: slider_Weekend)
    }
    
    func setData() {
        guard let me = User.me else { return }
        if me.is_push_weekdays == false && me.is_push_weekend == false {
            masterSwitch.isOn = false
            view_Week.isHidden = true
            view_Weekend.isHidden = true
        } else {
            masterSwitch.isOn = true
        }
        
        weekdaySwitch.isOn = me.is_push_weekdays
        weekendSwitch.isOn = me.is_push_weekend
        slider_Week.selectedMinValue = CGFloat(me.weekdays_start)
        slider_Week.selectedMaxValue = CGFloat(me.weekdays_end)
        slider_Weekend.selectedMinValue = CGFloat(me.weekend_start)
        slider_Weekend.selectedMaxValue = CGFloat(me.weekend_end)
    }
    
    func setHandleShadow(slider: RangeSeekSlider) {
        slider.leftHandle.shadowColor = UIColor.black.cgColor
        slider.leftHandle.shadowOpacity = 0.3
        slider.leftHandle.shadowOffset = CGSize(width: 0, height: 2)
        slider.rightHandle.shadowColor = UIColor.black.cgColor
        slider.rightHandle.shadowOpacity = 0.3
        slider.rightHandle.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let me = User.me else { return }
        
        me.weekdays_start = Int(slider_Week.selectedMinValue)
        me.weekdays_end = Int(slider_Week.selectedMaxValue)
        me.weekend_start = Int(slider_Weekend.selectedMinValue)
        me.weekend_end = Int(slider_Weekend.selectedMaxValue)
        
        DBNetworking.updateUserInfo(params:
        ["weekdays_start" : me.weekdays_start,
         "weekdays_end" : me.weekdays_end,
         "weekend_start" : me.weekend_start,
         "weekend_end" : me.weekend_end,
         "is_push_weekdays" : me.is_push_weekdays,
         "is_push_weekend" : me.is_push_weekend,
         ]) { (result) in
            me.save()
        }
    }

    @IBAction func masterAlarmOnOff(_ sender: UISwitch) {
        guard let me = User.me else { return }
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
            weekdaySwitch.isOn = false
            weekendSwitch.isOn = false
            me.is_push_weekdays = false
            me.is_push_weekend = false
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
        guard let me = User.me else { return }
        let slider: RangeSeekSlider = sender.tag == 0 ? slider_Week : slider_Weekend
        slider.colorBetweenHandles = sender.isOn ? UIColor.themeBlue : UIColor.subGray216
        slider.maxLabelColor = sender.isOn ? UIColor.themeBlue : UIColor.subGray216
        slider.minLabelColor = sender.isOn ? UIColor.themeBlue : UIColor.subGray216
        slider.layoutSubviews()
        if sender.tag == 0 {
            me.is_push_weekdays = sender.isOn
        } else {
            me.is_push_weekend = sender.isOn
        }
    }
}
