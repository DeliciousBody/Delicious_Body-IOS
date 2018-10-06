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
        me.slogan = inputTextField.innerTextField.text
        DBNetworking.updateUserInfo(params: me.toJSON()) { (result) in
            if result == 200 {
                User.me?.save()
                
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let mainViewController = storyBoard.instantiateViewController(withIdentifier: "DBMainTabbarController")
                self.present(mainViewController, animated: true, completion: nil)
            } else {
                print("error")
            }
        }
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
