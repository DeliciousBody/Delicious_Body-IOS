//
//  MNFunction.swift
//  LEETJunDamVi
//
//  Created by 이창민 on 2016. 3. 27..
//  Copyright © 2016년 LEETJunDamVi. All rights reserved.
//

import Foundation
import UIKit

let SCREEN_WIDTH  = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height
let NaviBar_Height = 44
let StatusBar_Height = 20

func getHeightOfStatusNNaviBar(_ vc: UIViewController) -> CGFloat {
    let height = vc.navigationController?.navigationBar.frame.size.height ?? 0
    return height + 20
}

func stringToAttrStringInHTML(_ str: String) -> NSAttributedString {
    var attrString = NSMutableAttributedString()
    
    do {
        attrString = try NSMutableAttributedString(data: str.data(using: String.Encoding.unicode)!, options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html
            ], documentAttributes: nil)
    } catch { }
    
    let result = attrString.copy() as! NSAttributedString
    return result
}

func setUserDefault(_ value: AnyObject, forKey key: String) {
    UserDefaults.standard.setValue(value, forKey: key)
}

func setUserDefaultWithInt(_ value: Int, forKey key: String) {
    UserDefaults.standard.set(value, forKey: key)
}

func setUserDefaultWithString(_ value: String, forKey key: String) {
    UserDefaults.standard.set(value, forKey: key)
}

func setUserDefault<T>(value val: T, forKey key: String) {
    UserDefaults.standard.set(val, forKey: key)
}

func setUserDefaultWithBool(_ value: Bool, forKey key: String) {
    UserDefaults.standard.set(value, forKey: key)
}

func getUserDefaultBoolValue(_ key: String) -> Bool {
    let value = UserDefaults.standard.bool(forKey: key)
    return value
}


func deleteUserDefalut(_ key: String) {
    UserDefaults.standard.removeObject(forKey: key)
}

func getUserDefault(_ key: String) -> AnyObject {
    if let value = UserDefaults.standard.object(forKey: key) {
        return value as AnyObject
    } else {
        return NSNull()
    }
}

func getUserDefaultIntValue(_ key: String) -> Int {
    let value = UserDefaults.standard.integer(forKey: key)
    return value
}

func showAlertWithString(_ title: String , message: String, sender:UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "닫기", style: UIAlertActionStyle.cancel, handler: nil))
    sender.present(alert, animated: true, completion: nil)
}

var isBlockUserInteract: Bool = false {
    didSet {
        if isBlockUserInteract != oldValue {
            isBlockUserInteract ? UIApplication.shared.beginIgnoringInteractionEvents() : UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
}

extension UIStoryboard {
    class func viewController(storyBoard sbID: String,withID identifier: String) -> UIViewController {
        return UIStoryboard(name: sbID, bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
}

func secToString(sec: Int) -> String{
    var str = ""
    let min = (sec % 3600) / 60
    let sec = (sec % 3600) % 60
    if min != 0 {
        str.append("\(min)분")
    }
    if sec != 0 {
        str.append(" \(sec)초")
    }
    
    return str
}

extension String {
    func toInt()->Int? {
        return Int(self)
    }
    func toFloat()->Float? {
        return Float(self)
    }
}

@IBDesignable class UITextViewFixed: UITextView {
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    func setup() {
        textContainerInset = UIEdgeInsets.zero
        textContainer.lineFragmentPadding = 0
    }
}

public extension UIDevice {
    
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod Touch 5"
            case "iPod7,1":                                 return "iPod Touch 6"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad6,11", "iPad6,12":                    return "iPad 5"
            case "iPad7,5", "iPad7,6":                      return "iPad 6"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }
        
        return mapToDevice(identifier: identifier)
    }()
    
}

