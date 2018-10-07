//
//  DBJoin2ViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 5. 28..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBJoin2ViewController: DBViewController {

    
    var currentGender: Gender = .male
    var currentLevel: Int = 1
    
    let thumbnailNames = ["join_low", "join_mid", "join_hard"]
    
    @IBOutlet weak var maleButton: DBRoundButton!
    @IBOutlet weak var femaleButton: DBRoundButton!
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet var levelButtons: [DBRoundButton]!
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setKeyboardHide()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
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
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func genderButtonPressed(_ sender: UIButton) {
        guard sender.tag != currentGender.rawValue else { return }
        currentGender = Gender(rawValue: sender.tag)!
        maleButton.isSelected = Gender.male.rawValue == sender.tag
        femaleButton.isSelected = Gender.female.rawValue == sender.tag
    }
    
    @IBAction func levelButttonPressed(_ sender: UIButton) {
        guard sender.tag != currentLevel else { return }
        currentLevel = sender.tag
        for btn in levelButtons {
            btn.isSelected = currentLevel == btn.tag
        }
        UIView.animate(withDuration: 0.1, animations: {
            self.thumbnailView.alpha = 0.3
            self.descLabel.alpha = 0.3
        }) { (complete) in
            self.thumbnailView.image = UIImage(named: self.thumbnailNames[self.currentLevel - 1])
            self.descLabel.text = kJoinDescStrings[self.currentLevel - 1]
            UIView.animate(withDuration: 0.1, animations: {
                self.thumbnailView.alpha = 1
                self.descLabel.alpha = 1
            })
        }
        
        
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        guard let me = User.me ,
            let ageStr = ageTextField.text else { return }
        if let age = Int(ageStr) {
            me.age = age
        } else {
            return
        }
        
        me.sex = currentGender == .male
        me.activity_level = currentLevel
        
        performSegue(withIdentifier: "next", sender: nil)
    }
}
