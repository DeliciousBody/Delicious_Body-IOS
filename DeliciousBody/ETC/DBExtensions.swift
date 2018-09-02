//
//  DBExtensions.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 8. 21..
//  Copyright © 2018년 changmin. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func FadeOutWithrotate(duration: Double = 0.20) {
        let rotate = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: {
            self.transform = rotate;
            self.alpha = 0
        }, completion: nil)
    }
    func FadeIntWithrotate(duration: Double = 0.5) {
        UIView.animate(withDuration: 0.125, delay: 0, options: .curveLinear, animations: {
            self.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            self.alpha = 0.5
        }) { (s) in
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                self.transform = CGAffineTransform(rotationAngle: 0)
                self.alpha = 1
            }, completion: nil)
        }
  
    }
    
    func takeSnapshot() -> UIImageView {
        let imageView = UIImageView(frame: self.frame)
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        // old style: layer.renderInContext(UIGraphicsGetCurrentContext())
        
        imageView.image =  UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageView
    }
}

extension CALayer {
    func applyMainShadow(withCorner: Bool = false) {
        shadowColor = UIColor.black.cgColor
        shadowOpacity = 0.25
        shadowOffset = CGSize(width: 0, height: 2)
        shadowRadius = 5
        cornerRadius = withCorner ? 15 : 0
    }
    
    func applyCornerRadius(corners: UIRectCorner) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners:corners,
                                cornerRadii: CGSize(width: 15, height: 15))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        mask = maskLayer
    }
    
    func resetCornerRadius(corners: UIRectCorner) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners:corners,
                                cornerRadii: CGSize(width: 0, height: 0))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        mask = maskLayer
    }
}
