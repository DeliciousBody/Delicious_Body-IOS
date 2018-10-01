//
//  DBValidator.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 10. 1..
//  Copyright © 2018년 changmin. All rights reserved.
//

import Foundation

class DBValidater: NSObject {
    
    static func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}
