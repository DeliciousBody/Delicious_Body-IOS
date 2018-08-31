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
        return 3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to),
            let fromVCSnap = fromVC.view.snapshotView(afterScreenUpdates: true)
            else { return }
        
        self.isPushing ? containerView.insertSubview(toVC.view, at: 0) : containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        let detailView = isPushing ? toVC.view : fromVC.view
        
        let shadowView = UIView(frame: isPushing ? originFrame : fromVC.view.frame)
        shadowView.layer.applyMainShadow()
        shadowView.backgroundColor = UIColor.white
        containerView.addSubview(shadowView)
        
        let maskView = UIView(frame: isPushing ? originFrame : fromVC.view.frame)
        maskView.layer.cornerRadius = 15
        maskView.clipsToBounds = true
        maskView.backgroundColor = UIColor.white
        containerView.addSubview(maskView)
        
        
        let imageV = UIImageView(frame: CGRect(x: 0, y: 0, width: originFrame.width, height: 180))
        imageV.backgroundColor = UIColor.themeBlue
        
        maskView.addSubview(imageV)
       
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .curveEaseIn, animations: {

            shadowView.frame = self.isPushing ? toVC.view.frame : self.originFrame
            shadowView.layer.cornerRadius = self.isPushing ? 0 : 15
            
            maskView.frame = self.isPushing ? toVC.view.frame : self.originFrame
            maskView.layer.cornerRadius = self.isPushing ? 0 : 15
            
            
            imageV.frame = self.isPushing ? CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH * 9 / 16) : self.originFrame
            
            
        }) { (finish) in
            UIView.animate(withDuration: duration/2, animations: {
                
            }) { (finish) in
                fromVC.view.isHidden = false
                toVC.view.alpha = 1
                shadowView.removeFromSuperview()
                maskView.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
}
