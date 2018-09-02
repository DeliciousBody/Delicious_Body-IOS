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
    private let tableViewSnap: UIView
    private let nameSnap: UIView
    private let originFrame: CGRect
    
    private var removeViews = [UIView]()
    
    init(snapShots: [UIView], originFrame: CGRect) {
        self.tableViewSnap = snapShots[0]
        self.nameSnap = snapShots[1]
        self.originFrame = originFrame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.45
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to),
            let toVCSnap = toVC.view.snapshotView(afterScreenUpdates: true)
            else { return }
        
        toVC.view.alpha = 0
        
        let shadowView = UIView(frame: originFrame)
        shadowView.layer.applyMainShadow(withCorner: true)
        shadowView.backgroundColor = UIColor.white
        containerView.addSubview(shadowView)
        containerView.addSubview(toVC.view)
        
        let maskLayer = CAShapeLayer()
        let path = CGPath(rect: CGRect(x: 0, y: SCREEN_WIDTH * 9 / 16, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), transform: nil)
        maskLayer.path = path
        toVCSnap.layer.mask = maskLayer
        toVCSnap.alpha = 0
        containerView.addSubview(toVCSnap)
        
        let maskView = UIView(frame: originFrame)
        maskView.layer.cornerRadius = 15
        maskView.clipsToBounds = true
        maskView.backgroundColor = UIColor.clear
        containerView.addSubview(maskView)
        
        let imageV = UIImageView(frame: CGRect(x: 0, y: 0, width: originFrame.width, height: 180))
        imageV.backgroundColor = UIColor.debugRed
        maskView.addSubview(imageV)
        
        tableViewSnap.frame = CGRect(x: 0, y: 180, width: originFrame.width, height: tableViewSnap.frame.height)
        maskView.addSubview(tableViewSnap)
        
        nameSnap.frame.origin = CGPoint(x: 16, y: 116)
        maskView.addSubview(nameSnap)
        
        
        removeViews = [shadowView, maskView, imageV, tableViewSnap, toVCSnap]
      
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: [], animations: {
            UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.82, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                shadowView.frame = toVC.view.frame
                shadowView.layer.cornerRadius = 0
                
                maskView.frame = toVC.view.frame
                maskView.layer.cornerRadius = 0
                self.tableViewSnap.frame.origin = CGPoint(x: 0, y: SCREEN_WIDTH * 9 / 16)
                self.nameSnap.frame.origin.y = 115
                imageV.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH * 9 / 16)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3, animations: {
                self.tableViewSnap.alpha = 0
                self.nameSnap.alpha = 0
            })
            
            UIView.addKeyframe(withRelativeStartTime: 1/2, relativeDuration: 1/2, animations: {
                toVCSnap.alpha = 1
            })
            
        }) { (finish) in
            toVC.view.alpha = 1
            UIView.animate(withDuration: 0.3, animations: {
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

class CardDismissTransition: NSObject, UIViewControllerAnimatedTransitioning {
    private let tableViewSnap: UIView
    private let nameSnap: UIView
    private let originFrame: CGRect
    
    private var removeViews = [UIView]()
    
    init(snapShots: [UIView], originFrame: CGRect) {
        self.tableViewSnap = snapShots[0]
        self.nameSnap = snapShots[1]
        self.originFrame = originFrame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to),
            let fromVCSnap = fromVC.view.snapshotView(afterScreenUpdates: true)
            else { return }
        
        toVC.view.alpha = 1
        containerView.addSubview(toVC.view)
        
        fromVC.view.alpha = 0
        let shadowView = UIView(frame: fromVC.view.frame)
        shadowView.layer.applyMainShadow()
        shadowView.backgroundColor = UIColor.white
        containerView.addSubview(shadowView)
        
        let maskView = UIView(frame: fromVC.view.frame)
        maskView.clipsToBounds = true
        maskView.backgroundColor = UIColor.clear
        containerView.addSubview(maskView)
        
        let imageV = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH * 9 / 16))
        imageV.backgroundColor = UIColor.debugRed
        maskView.addSubview(imageV)
        
        let maskLayer = CAShapeLayer()
        let path = CGPath(rect: CGRect(x: 0, y: SCREEN_WIDTH * 9 / 16, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), transform: nil)
        maskLayer.path = path
        fromVCSnap.layer.mask = maskLayer
        fromVCSnap.alpha = 1
        containerView.addSubview(fromVCSnap)
        
        tableViewSnap.frame.origin = CGPoint(x: 0, y: SCREEN_WIDTH * 9 / 16)
        tableViewSnap.alpha = 0
        maskView.addSubview(tableViewSnap)
        
        nameSnap.frame.origin = CGPoint(x: 16, y: 115)
        nameSnap.alpha = 0
        maskView.addSubview(nameSnap)
        
        removeViews = [shadowView, maskView, fromVCSnap, nameSnap, tableViewSnap]
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1, animations: {
                shadowView.frame = self.originFrame
                shadowView.layer.cornerRadius =  15
                maskView.frame = self.originFrame
                maskView.layer.cornerRadius = 15
                imageV.frame = CGRect(x: 0, y: 0, width: self.originFrame.width, height: 180)
                
                self.tableViewSnap.frame.origin = CGPoint(x: 0, y: 180)
                self.nameSnap.frame.origin = CGPoint(x: 16, y: 116)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 2/3, animations: {
                fromVCSnap.alpha = 0
                self.tableViewSnap.alpha = 1
                self.nameSnap.alpha = 1
            })
            
        }) { (finish) in
            for view in self.removeViews {
                view.removeFromSuperview()
            }
            if transitionContext.transitionWasCancelled {
                toVC.view.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
