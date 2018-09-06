//
//  DBVideoSearchTransition.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 9. 5..
//  Copyright © 2018년 changmin. All rights reserved.
//

import Foundation
import UIKit

class DBVideoSearchTransition : NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting: Bool
    var originFrame: CGRect
    var newFrame: CGRect
    init(isPresenting : Bool, originFrame : CGRect) {
        self.isPresenting = isPresenting
        self.originFrame = originFrame
        self.newFrame = CGRect(x: 0, y: originFrame.origin.y, width: SCREEN_WIDTH, height: originFrame.height)
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to),
            let fromVCSnap = fromVC.view.snapshotView(afterScreenUpdates: true)
            else { return }
        
        let duration = transitionDuration(using: transitionContext)
        
        toVC.view.alpha = isPresenting ? 0 : 1
        isPresenting ? container.addSubview(toVC.view) : container.insertSubview(toVC.view, belowSubview: fromVC.view)
        
        let searchView: UIView = isPresenting ? toVC.view : fromVC.view
        
        guard let lineView = searchView.viewWithTag(99) else { return }
        lineView.alpha = 0
        
        let line = UIView(frame: isPresenting ? originFrame : newFrame) 
        print(line.frame)
        line.backgroundColor = UIColor.themeBlue
        line.layer.cornerRadius = 1
        line.clipsToBounds = true
        container.addSubview(line)
        
        
        
        UIView.animate(withDuration: duration, animations: {
            searchView.alpha = self.isPresenting ? 1 : 0
            line.frame = self.isPresenting ? self.newFrame : self.originFrame
        }, completion: { (finished) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            line.removeFromSuperview()
            lineView.alpha = 1
        })
        
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
}
