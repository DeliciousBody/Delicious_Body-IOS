//
//  DBSettingCell.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 9. 12..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

enum SettingOption: String {
    case email = "이메일",
    passwd = "비밀번호 변경",
    version = "버전 정보",
    useDesc = "이용 약관",
    pSetting = "개인 정보 보호 설정",
    pDesc = "개인 정보 취급 방침",
    logout = "로그아웃",
    signOut = "회원 탈퇴"
}

class DBSettingCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var nextButton: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(option: SettingOption, email: String? = nil) {
        titleLabel.font = option == .signOut ? UIFont.signOutFont : UIFont.settingFont
        titleLabel.textColor = option == .signOut ? UIColor.settingRed : UIColor.settingGray
        
        switch option {
        case .email:
            titleLabel.text = option.rawValue
            contentLabel.text = email
            nextButton.isHidden = true
        case .passwd, .version, .useDesc, .pSetting, .pDesc, .logout:
            titleLabel.text = option.rawValue
            nextButton.isHidden = false
        case .signOut:
            titleLabel.text = option.rawValue
            nextButton.isHidden = false
        }
    }
}
