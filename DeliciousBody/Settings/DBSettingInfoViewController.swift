//
//  DBSettingInfoViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 9. 12..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBSettingInfoViewController: DBViewController {
    var data: [[SettingOption]] = [[.email, .passwd], [.version, .useDesc, .pDesc], [.logout, .signOut]]
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let me = User.me, me.id == "카카오톡" {
            data[0].remove(at: 1)
        }
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
                vc.descript = kUserDesc
            } else {
                vc.title = "개인 정보 보호 방침"
                vc.descript = kPrivateDesc
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
        switch data[section][row] {
        case .passwd:
            self.performSegue(withIdentifier: "password", sender: nil)
        case .version:
            self.performSegue(withIdentifier: "version", sender: nil)
        case .useDesc:
            self.performSegue(withIdentifier: "desc", sender: 0)
        case .pDesc:
            self.performSegue(withIdentifier: "desc", sender: 1)
        case .logout:
            let alert = UIAlertController(title: "로그아웃", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: {action in
                DBNetworking.logout(completion: { (result) in
                    User.removeSavedUser()
                    self.performSegue(withIdentifier: "Join", sender: nil)
                })
            }))
            alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        case .signOut:
            DBHistoryManager.resetHistory()
            self.performSegue(withIdentifier: "signout", sender: nil)
        default:
            return
        }
    }
}
