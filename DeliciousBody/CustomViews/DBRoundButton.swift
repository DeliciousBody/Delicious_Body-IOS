//
//  DBRoundButton.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 8. 20..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBRoundButton: UIButton {
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = 4
        layer.masksToBounds = true
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
