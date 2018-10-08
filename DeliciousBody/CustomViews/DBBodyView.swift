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
    @IBOutlet var bodyLabelButtons: [UIButton]!
    @IBOutlet weak var frontContainerView: UIView!
    @IBOutlet weak var backContainerView: UIView!
    var filter: [BodyType] = []
    
    var view:UIView!
    let NibName: String = "DBBodyView"
    
    var handler: (([BodyType]) -> Void)?
    
    var isFront: Bool = true
    
    
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
        self.backContainerView.layer.transform = CATransform3DMakeRotation(CGFloat(Float.pi / 2 * 3), 0.0, 1.0, 0.0)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for:type(of: self))
        let nib = UINib(nibName:NibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    func reset() {
        for btn in bodyLabelButtons.filter({ (button) -> Bool in
            return button.isSelected
        }) {
            buttonPressed(btn)
        }
    }
    
    func setSelected(types: [Int]) {
        for type in types {
            let labelButton = bodyLabelButtons[type - 1]
            labelButton.isSelected = !labelButton.isSelected
            if labelButton.isSelected {
                self.filter.append(BodyType(rawValue: type)!)
            } else {
                self.filter.remove(at: self.filter.index(of: BodyType(rawValue: type)!)!)
            }
            UIView.animate(withDuration: 0.15, animations: {
                self.bodyImageViews[type].alpha = labelButton.isSelected ? 1 : 0
            })
        }
        self.handler?(self.filter)
    }
    
    @IBAction func reverseButtonPressed(_ sender: Any) {
        let front: UIView = isFront ? frontContainerView : backContainerView
        let back: UIView = isFront ? backContainerView : frontContainerView
        
        UIView.animate(withDuration: 0.15, animations: {
            front.layer.transform = CATransform3DMakeRotation(CGFloat(Float.pi / 2), 0.0, 1.0, 0.0)
        }) { (complete) in
            front.isHidden = true
            back.isHidden = false
            UIView.animate(withDuration: 0.2, animations: {
                back.layer.transform = CATransform3DMakeRotation(CGFloat(0), 0.0, 1.0, 0.0)
            }) { (complete) in
                self.isFront = !self.isFront
            }
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let tag = sender.tag
        guard tag < bodyImageViews.count else { return }
        let labelButton = bodyLabelButtons[tag - 1]
        labelButton.isSelected = !labelButton.isSelected
        if labelButton.isSelected {
            self.filter.append(BodyType(rawValue: tag)!)
        } else {
            self.filter.remove(at: self.filter.index(of: BodyType(rawValue: tag)!)!)
        }
        self.handler?(self.filter)
        
        UIView.animate(withDuration: 0.15, animations: {
            self.bodyImageViews[tag].alpha = labelButton.isSelected ? 1 : 0
        })
    }
}
