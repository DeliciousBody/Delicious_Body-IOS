//
//  DBSmallTransition.swift
//  DeliciousBody
//
//  Created by changmin lee on 28/10/2018.
//  Copyright © 2018 changmin. All rights reserved.
//

import Foundation
import UIKit

class HistoryTransition: NSObject, UIViewControllerAnimatedTransitioning {
    private let originFrame: CGRect
    private let thumbnailImage: UIImage
    
    private var removeViews = [UIView]()
    
    init(originFrame: CGRect, thumbnailImage: UIImage) {
        self.originFrame = originFrame
        self.thumbnailImage = thumbnailImage
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.45
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toVC = transitionContext.viewController(forKey: .to),
            let toVCSnap = toVC.view.snapshotView(afterScreenUpdates: true)
            else { return }
        
        toVC.view.alpha = 0
        containerView.addSubview(toVC.view)
        
        let back = UIView(frame: containerView.frame)
        back.alpha = 0
        back.backgroundColor = UIColor.white
        containerView.addSubview(back)
        
        toVCSnap.alpha = 0
        containerView.addSubview(toVCSnap)
        
        let imageV = UIImageView(frame: originFrame)
        imageV.image = thumbnailImage
        containerView.addSubview(imageV)
        
        removeViews = [imageV, toVCSnap, back]
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: [], animations: {
            UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.82, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                imageV.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH * 9 / 16)
            })
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/2, animations: {
                back.alpha = 1
            })
            UIView.addKeyframe(withRelativeStartTime: 1/2, relativeDuration: 1/2, animations: {
                toVCSnap.alpha = 1
            })
            
        }) { (finish) in
            toVC.view.alpha = 1
            for view in self.removeViews {
                view.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
