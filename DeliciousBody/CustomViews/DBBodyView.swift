//
//  DBBodyView.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 6. 4..
//  Copyright © 2018년 changmin. All rights reserved.
//

import Foundation
import UIKit
class DBBodyView: UIView {
    
    @IBOutlet var bodyImageViews: [UIImageView]!
    var filter: [BodyType] = []
    
    var view:UIView!
    let NibName: String = "DBBodyView"
    
    var handler: (([BodyType]) -> Void)?
    
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
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for:type(of: self))
        let nib = UINib(nibName:NibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            self.filter.append(BodyType(rawValue: sender.tag)!)
        } else {
            self.filter.remove(at: self.filter.index(of: BodyType(rawValue: sender.tag)!)!)
        }
        self.handler?(self.filter)
        
        UIView.animate(withDuration: 0.15, animations: {
            self.bodyImageViews[sender.tag].alpha = sender.isSelected ? 1 : 0
        })
    }
}
