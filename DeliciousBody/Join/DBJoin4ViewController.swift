//
//  DBJoin4ViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 5. 30..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit
import RangeSeekSlider

class DBJoin4ViewController: UIViewController {

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
        setHandleShadow(slider: slider_Week)
        setHandleShadow(slider: slider_Weekend)
    }
    
    func setHandleShadow(slider: RangeSeekSlider) {
        slider.leftHandle.shadowColor = UIColor.black.cgColor
        slider.leftHandle.shadowOpacity = 0.3
        slider.leftHandle.shadowOffset = CGSize(width: 0, height: 2)
        slider.rightHandle.shadowColor = UIColor.black.cgColor
        slider.rightHandle.shadowOpacity = 0.3
        slider.rightHandle.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        if let me = User.me {
            me.weekdays_start = Int(slider_Week.selectedMinValue)
            me.weekdays_end = Int(slider_Week.selectedMaxValue)
            me.weekend_start = Int(slider_Weekend.selectedMinValue)
            me.weekend_end = Int(slider_Weekend.selectedMaxValue)
            performSegue(withIdentifier: "next", sender: nil)
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else {
            return
        }
        
        if id.contains("join") {
            let vc = segue.destination as! DBJoinEmbededViewController
            vc.contentString = kJoinTitles[segue.identifier!]
        }
    }

}
