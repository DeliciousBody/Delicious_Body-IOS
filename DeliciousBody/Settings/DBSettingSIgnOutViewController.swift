//
//  DBSettingSIgnOutViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 10. 10..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBSettingSIgnOutViewController: DBViewController {

    @IBAction func signOutButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "탈퇴", message: "계정을 탈퇴하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: {action in
            DBNetworking.deleteUserInfo(completion: { (result) in
                User.removeSavedUser()
                self.performSegue(withIdentifier: "Join", sender: nil)
            })
        }))
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor.themeBlue84102255
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = false
        UIApplication.shared.statusBarStyle = .lightContent
    }

}
