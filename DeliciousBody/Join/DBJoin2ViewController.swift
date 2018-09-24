//
//  DBJoin2ViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 5. 28..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBJoin2ViewController: UIViewController {

    
    var currentAge: Int = 20
    var currentGender: Gender = .male
    var currentLevel: Int = 0
    
    let thumbnailNames = ["join_low", "join_mid", "join_hard"]
    
    @IBOutlet weak var maleButton: DBRoundButton!
    @IBOutlet weak var femaleButton: DBRoundButton!
    
    @IBOutlet var levelButtons: [DBRoundButton]!
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
            self.thumbnailView.image = UIImage(named: self.thumbnailNames[self.currentLevel])
            self.descLabel.text = kJoinDescStrings[self.currentLevel]
            UIView.animate(withDuration: 0.1, animations: {
                self.thumbnailView.alpha = 1
                self.descLabel.alpha = 1
            })
        }
        
        
    }
    
}
