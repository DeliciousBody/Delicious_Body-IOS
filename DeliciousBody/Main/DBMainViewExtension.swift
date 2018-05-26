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
        guard let height = navigationController?.navigationBar.frame.height else { return }
        
        let coeff: CGFloat = {
            let delta = height - NavBarHeightSmallState
            let heightDifferenceBetweenStates = (NavBarHeightLargeState - NavBarHeightSmallState)
            return delta / heightDifferenceBetweenStates
        }()
        
        let factor = ImageSizeForSmallState / ImageSizeForLargeState
        
        let scale: CGFloat = {
            let sizeAddendumFactor = coeff * (1.0 - factor)
            return min(1.0, sizeAddendumFactor + factor)
        }()
        
        let sizeDiff = ImageSizeForLargeState * (1.0 - factor)
        
        let yTranslation: CGFloat = {
            let minY = ImageTopMarginForSmallState - ImageTopMarginForLargeState - ImageSizeForLargeState
            
            return max(minY, min(0,minY + coeff * -minY))
        }()
        
        let xTranslation = min(0, coeff * sizeDiff - sizeDiff)
        imageView.transform = CGAffineTransform.identity
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: xTranslation, y: yTranslation)
        
        titleLabel.transform = CGAffineTransform.identity
            .scaledBy(x: 1, y: 1)
            .translatedBy(x:0, y: yTranslation)
        
        titleLabel.alpha = coeff
    }
    
    func showImage(_ show: Bool) {
        guard let height = navigationController?.navigationBar.frame.height else { return }
        if show {
            navigationController?.navigationBar.layer.zPosition = 0
        }
        
        let coeff: CGFloat = {
            let delta = height - NavBarHeightSmallState
            let diff = (NavBarHeightLargeState - NavBarHeightSmallState)
            return delta / diff
        }()
        
        UIView.animate(withDuration: 0.3) {
            self.imageView.alpha = show ? 1.0 : 0.0
            self.titleLabel.alpha = coeff
        }
    }
}
