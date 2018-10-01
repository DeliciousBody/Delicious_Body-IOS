//
//  DBMainViewExtension.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 4. 14..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

extension DBMainViewController {
    func moveAndResizeImageForPortrait() {
        let offset = self.tableView.contentOffset.y
        let minOffset: CGFloat = 10
        let maxOffset: CGFloat = 50
        
        let coeff: CGFloat = {
            if offset < minOffset { return 1 }
            let coef = 1 - (offset - minOffset) / (maxOffset - minOffset)
            
            return max(0, coef)
        }()
        print(coeff)
        let yTrans: CGFloat = {
            if offset < minOffset { return 0 }
            return -(offset - minOffset)
        }()
        titleLabel.transform = CGAffineTransform.identity
            .scaledBy(x: 1, y: 1)
            .translatedBy(x:0, y: yTrans)
        titleLabel.alpha = coeff
        
        let factor = ImageSizeForSmallState / ImageSizeForLargeState
        let scale: CGFloat = {
            let sizeAddendumFactor = coeff * (1.0 - factor)
            return min(1.0, sizeAddendumFactor + factor)
        }()
        
        let sizeDiff = ImageSizeForLargeState * (1.0 - factor)
        let xTranslation = min(0, coeff * sizeDiff - sizeDiff)
        let yTranslation: CGFloat = {
            let minY = ImageTopMarginForSmallState - ImageTopMarginForLargeState - ImageSizeForLargeState
            
            return max(minY, min(0,minY + coeff * -minY))
        }()
        
        imageView.transform = CGAffineTransform.identity
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: xTranslation, y: yTranslation)
    }
    
    func showImage(_ show: Bool) {
//        guard let height = navigationController?.navigationBar.frame.height else { return }
//        if show {
//            navigationController?.navigationBar.layer.zPosition = 0
//        }
//
//        let coeff: CGFloat = {
//            let delta = height - NavBarHeightSmallState
//            let diff = (NavBarHeightLargeState - NavBarHeightSmallState)
//            return delta / diff
//        }()
//
//        UIView.animate(withDuration: 0.3) {
//            self.imageView.alpha = show ? 1.0 : 0.0
//            self.titleLabel.alpha = coeff
//        }
    }
}

extension DBMainViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CardTransition(snapShots: [self.snapShot, self.nameSnapShot], originFrame: self.originFrame, thumbnailImage: self.selectedImage)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let _ = dismissed as? DBVideoViewController else {
            return nil
        }
        if tableView.contentOffset.y == -116.0 {
            return CardDismissTransition(snapShots: [self.snapShot, self.nameSnapShot], originFrame: originFrame, thumbnailImage: self.selectedImage, isScrolled: false)
        } else {
            return CardDismissTransition(snapShots: [self.snapShot, self.nameSnapShot], originFrame: originFrame, thumbnailImage: self.selectedImage)
        }
    }
}
