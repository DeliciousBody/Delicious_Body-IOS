//
//  DBJoin5ViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 5. 30..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBJoin5ViewController: DBViewController {

    @IBOutlet weak var inputTextField: DBTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setKeyboardHide()
        inputTextField.changeHandler = { [weak self] text in
            self?.inputTextField.setCheck(check: text.count > 0)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.inputTextField.becomeFirstResponder()
    }

    @IBAction func confirmButtonPressed(_ sender: Any) {
        guard let me = User.me else { return }
        me.slogan = inputTextField.text ?? "Workout hard Play hard!"
        DBIndicator.shared.show()
        
        DBNetworking.createUserInfo(user: me, completion: { (result) in
            DBIndicator.shared.stop()
            if result == 201 {
                User.me?.save()
                
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let mainViewController = storyBoard.instantiateViewController(withIdentifier: "DBMainTabbarController")
                self.present(mainViewController, animated: true, completion: nil)
            } else {
                self.showAlert(title: "오류", content: "회원가입 중 오류가 발생하였습니다.")
            }
        })
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
