//
//  DBRoundButton.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 8. 20..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBRoundButton: UIButton {
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? UIColor.themeBlue84102255 : UIColor.subGray190
        }
    }
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = 4
        layer.masksToBounds = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: {
            self.transform = CGAffineTransform.identity
        })
    }
    
//    func shake() {
//        let midX = center.x
//        let midY = center.y
//        
//        let animation = CABasicAnimation(keyPath: "position")
//        animation.duration = 0.04
//        animation.repeatCount = 2
//        animation.autoreverses = true
//        animation.fromValue = CGPoint(x: midX - 5, y: midY)
//        animation.toValue = CGPoint(x: midX + 5, y: midY)
//        layer.add(animation, forKey: "position")
//    }
}

extension UIButton {
    func makeRound() {
        layer.cornerRadius = 15
        clipsToBounds = true
        
//        layer.shadowPath =
//            UIBezierPath(roundedRect: bounds,
//                         cornerRadius: layer.cornerRadius).cgPath
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.15
//        layer.shadowOffset = CGSize(width: 0, height: 1)
//        layer.shadowRadius = 8
//        layer.masksToBounds = false
    }
}


class DBButton: UIButton {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.isSelected = !self.isSelected
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: {
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { (complete) in
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: {
                self.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
            }) { (complete) in
                UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseIn, animations: {
                    self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                }) { (complete) in
                    UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseIn, animations: {
                        self.transform = CGAffineTransform.identity
                    }) { (complete) in
                        
                    }
                }
            }
        }
    }
}
