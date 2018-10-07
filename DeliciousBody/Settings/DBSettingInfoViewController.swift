//
//  DBSettingInfoViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 9. 12..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBSettingInfoViewController: DBViewController {
    let data: [[SettingOption]] = [[.email, .passwd], [.version, .useDesc, .pSetting, .pDesc], [.logout, .signOut]]
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor.themeBlue84102255
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = false
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "desc" {
            let vc = segue.destination as! DBSettingDescViewController
            if sender as! Int == 0 {
                vc.title = "이용약관"
                vc.descript = kUseDesc
            }
        }
    }
}

extension DBSettingInfoViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DBSettingCell
        let option = data[indexPath.section][indexPath.row]
        if option == .email {
            cell.configure(option: option, email: User.me?.id)
        } else {
            cell.configure(option: option)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 45))
        footer.backgroundColor = UIColor(red: 239.0 / 255.0, green: 239.0 / 255.0, blue: 244.0 / 255.0, alpha: 1)
        return footer
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            
        } else if section == 1 {
            if row == 1 {
                self.performSegue(withIdentifier: "desc", sender: 0)
            }
        } else {
            if row == 0 {
                User.removeSavedUser()
                self.performSegue(withIdentifier: "Join", sender: nil)
//                self.dismiss(animated: true) {
//                    NotificationCenter.default.post(name: Foundation.Notification.Name(rawValue: kDidLogoutNotification), object: nil)
//                }
            }
        }
    }
}
