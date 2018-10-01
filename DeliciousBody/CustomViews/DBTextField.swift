//
//  DBTextField.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 5. 23..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

@IBDesignable class DBTextField: UIView {
    
    @IBOutlet weak var innerTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var checkImage: UIImageView!
    
    @IBInspectable var placeholder: String? {
        didSet {
            innerTextField.placeholder = placeholder
        }
    }
    
    var textFieldType: TextFieldType = TextFieldType.etc
    
    var changeHandler: ((String)->Void)?
    var view:UIView!
    let NibName: String = "DBTextField"
    var isCheck: Bool = false {
        didSet{
            if isCheck != oldValue {
                if isCheck {
                    checkImage.alpha = 0
                    checkImage.isHidden = false
                    UIView.animate(withDuration: 0.2, animations: {
                        self.checkImage.alpha = 1.0
                    })
                } else {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.checkImage.alpha = 0
                    }, completion: { (success) in
                        self.checkImage.isHidden = true
                    })
                }
            }
        }
    }
    
    
    var isValidateEmail: Bool {
        get{
            if let text = innerTextField.text {
                return DBValidater.isValidEmail(testStr: text)  
            } else {
                return false
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    func setup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
        
        applySkyscannerTheme(textField: innerTextField)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for:type(of: self))
        let nib = UINib(nibName:NibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    @IBAction func textFieldDidChanged(_ textField: UITextField) {
        if textField.text != nil && textField.text != "" {
            innerTextField.lineColor = UIColor.themeBlue
        } else {
            innerTextField.lineColor = UIColor.lightGray
        }
        self.changeHandler?(textField.text ?? "")
    }
    
    @IBAction func textFieldDidEndEditing(_ textField: UITextField) {
//        if let text = textField.text {
//            if let floatingLabelTextField = textField as? SkyFloatingLabelTextField {
//                if textFieldType == .email{
//                    if(!DBValidater.isValidEmail(testStr: text)) {
//                        floatingLabelTextField.errorMessage = "올바른 이메일 주소를 입력하십시오."
//                    }
//                    else {
//                        floatingLabelTextField.errorMessage = ""
//                    }
//                }
//            }
//        }
    }
    
    func applySkyscannerTheme(textField: SkyFloatingLabelTextField) {
        textField.tintColor = UIColor.lightGray
        
        textField.textColor = UIColor.black
        textField.lineColor = UIColor.lightGray
        textField.titleColor = UIColor.clear
        
        textField.selectedTitleColor = UIColor.clear
        textField.selectedLineColor = UIColor.themeBlue
        textField.errorColor = UIColor.red
        textField.placeholderFont = UIFont.textFieldFont
        textField.font = UIFont.textFieldFont
        
        textField.lineHeight = 1
        textField.selectedLineHeight = 1
    }
    
    func setCheck(check: Bool) {
        self.isCheck = check
    }
    
    func animate() {
        UIView.animate(withDuration: 0.3) {
            self.innerTextField.textAlignment = .center
        }
    }
    func hideLine() {
        innerTextField.lineColor = UIColor.clear
        innerTextField.selectedLineColor = UIColor.clear
        innerTextField.isUserInteractionEnabled = false
    }
}
