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
        self.changeHandler?(textField.text ?? "")
    }
    
    func applySkyscannerTheme(textField: SkyFloatingLabelTextField) {
        textField.tintColor = UIColor.lightGray
        
        textField.textColor = UIColor.black
        textField.lineColor = UIColor.lightGray
        textField.titleColor = UIColor.clear
        
        textField.selectedTitleColor = UIColor.clear
        textField.selectedLineColor = UIColor.themeBlue
        
        textField.placeholderFont = UIFont.textFieldFont
        textField.font = UIFont.textFieldFont
        
        textField.lineHeight = 2
        textField.selectedLineHeight = 2
    }

    func setCheck(check: Bool) {
        self.isCheck = check
    }
}
