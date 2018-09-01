//
//  DBTransition.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 8. 30..
//  Copyright © 2018년 changmin. All rights reserved.
//

import Foundation
import UIKit

class CardTransition: NSObject, UIViewControllerAnimatedTransitioning {
    private let snapShot: UIView
    private let originFrame: CGRect
    private let isPushing:Bool
    
    private var removeViews = [UIView]()
    
    init(snapShot: UIView, originFrame: CGRect, isPushing: Bool) {
        self.snapShot = snapShot
        self.originFrame = originFrame
        self.isPushing = isPushing
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to),
            let toVCSnap = toVC.view.snapshotView(afterScreenUpdates: true)
            else { return }
        
        let detailView = isPushing ? toVC.view : fromVC.view
        
        toVC.view.alpha = 0
        
        let shadowView = UIView(frame: isPushing ? originFrame : fromVC.view.frame)
        shadowView.layer.applyMainShadow()
        shadowView.backgroundColor = UIColor.white
        containerView.addSubview(shadowView)
        containerView.addSubview(toVC.view)
        
        let maskLayer = CAShapeLayer()
        let path = CGPath(rect: CGRect(x: 0, y: SCREEN_WIDTH * 9 / 16, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), transform: nil)
        maskLayer.path = path
        toVCSnap.layer.mask = maskLayer
        toVCSnap.alpha = 0
        containerView.addSubview(toVCSnap)
        
        let maskView = UIView(frame: isPushing ? originFrame : fromVC.view.frame)
        maskView.layer.cornerRadius = 15
        maskView.clipsToBounds = true
        maskView.backgroundColor = UIColor.clear
        containerView.addSubview(maskView)
        
        let imageV = UIImageView(frame: CGRect(x: 0, y: 0, width: originFrame.width, height: 180))
        imageV.backgroundColor = UIColor.debugRed
        maskView.addSubview(imageV)
        
        snapShot.frame = CGRect(x: 0, y: 180, width: originFrame.width, height: snapShot.frame.height)
        maskView.addSubview(snapShot)
        
        removeViews = [shadowView, maskView, imageV, snapShot, toVCSnap]
        
        let duration = transitionDuration(using: transitionContext)
      
        UIView.animateKeyframes(withDuration: 0.6, delay: 0, options: [], animations: {
            UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 10, options: .curveEaseOut, animations: {
                shadowView.frame = self.isPushing ? toVC.view.frame : self.originFrame
                shadowView.layer.cornerRadius = self.isPushing ? 0 : 15
                
                maskView.frame = self.isPushing ? toVC.view.frame : self.originFrame
                maskView.layer.cornerRadius = self.isPushing ? 0 : 15
                self.snapShot.frame.origin = CGPoint(x: 0, y: SCREEN_WIDTH * 9 / 16)
                
                imageV.frame = self.isPushing ? CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH * 9 / 16) : self.originFrame
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.15, animations: {
              self.snapShot.alpha = 0
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.28, animations: {
                toVCSnap.alpha = 1
            })
            
        }) { (finish) in
            toVC.view.alpha = 1
            UIView.animate(withDuration: 0.1, animations: {
                maskView.alpha = 0
            }, completion: { (finish) in
                for view in self.removeViews {
                    view.removeFromSuperview()
                }
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
    }
}
