//
//  DBConstants.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 5. 28..
//  Copyright © 2018년 changmin. All rights reserved.
//

import Foundation

let kJoinTitles = ["join2":"맞춤 운동을 추천받으시려면\n저에게 당신을 알려주세요 :)",
                   "join3":"운동이 필요한 부위를\n저에게 알려주세요 :)",
                   "join4":"당신의 활동 시간을\n저에게 알려주세요 :)",
                   "join5":"이제 마지막입니다! 동기부여가\n될 수 있는 한마디를 적어보세요 :) ",
                   "none":""
]

let kJoinDescStrings = ["이동시간 이외의 활동량이 거의 없으며\n같은 자세로 오래 계시는분", "약간의 신체활동은 있으나 주기적인\n운동은 안하시는 분", "오래 서 계시거나, 반복적인 신체활동을\n해야하는 일을 하시는분"]
let kDidLogoutNotification = "kDidLogoutNotification"
enum BodyType: Int {
    case neck = 1, chest, abdomen, thigh, calf, arm, back, hip
    func description() -> String {
        switch self {
        case .neck:
            return "어깨, 목"
        case .chest:
            return "가슴"
        case .abdomen:
            return "복부, 허리"
        case .thigh:
            return "허벅지, 무릎"
        case .calf:
            return "종아리, 발목"
        case .arm:
            return "손목, 팔"
        case .back:
            return "등"
        case .hip:
            return "엉덩이"
        }
    }
}

enum Gender: Int {
    case male = 0, female
}

enum TextFieldType {
    case email, passwd, etc
}
