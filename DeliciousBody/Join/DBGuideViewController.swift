//
//  DBGuideViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 3. 29..
//  Copyright © 2018년 changmin. All rights reserved.
//
import UIKit
import CHIPageControl
import Foundation
class DBGuideViewController: DBViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet var guideViews: [UIView]!
    
    let guideImageHeight: CGFloat = SCREEN_WIDTH * 0.88
    let guideImageY: CGFloat = SCREEN_WIDTH * 188 / 375 + 15
    
    var imageViews = [UIImageView]()
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(DBGuideViewController.leftSwipe(gesture:)))
        leftSwipeGesture.direction = .left
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(DBGuideViewController.rightSwipe(gesture:)))
        rightSwipeGesture.direction = .right
        view.addGestureRecognizer(leftSwipeGesture)
        view.addGestureRecognizer(rightSwipeGesture)
        setupGuideView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    @objc func leftSwipe(gesture: UISwipeGestureRecognizer) {
        guard currentPage < 4 else { return }
        let front = self.imageViews[currentPage]
        let back = self.imageViews[currentPage + 1]
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: .curveEaseIn, animations: {
            front.frame.origin.x = -100
            front.alpha = 0
            back.frame.origin.x = 0
            back.alpha = 1
        }) { (finish) in }
        
        if currentPage == 0 {
            UIView.animate(withDuration: 0.3, delay: 0.25, options: .curveLinear, animations: {
                self.backgroundImageView.alpha = 1
            }, completion: nil)
            
            UIView.animate(withDuration: 0.4) {
                self.guideViews[self.currentPage].alpha = 0
            }
            UIView.animate(withDuration: 0.4, delay: 0.25, options: .curveLinear, animations: {
                self.guideViews[self.currentPage + 1].alpha = 1
            }, completion: nil)
        } else {
            
            UIView.animate(withDuration: 0.4) {
                self.guideViews[self.currentPage].alpha = 0
                self.guideViews[self.currentPage + 1].alpha = 1
            }
        }
        
        
        currentPage += 1
    }
    
    @objc func rightSwipe(gesture: UISwipeGestureRecognizer) {
        guard currentPage > 0  else { return }
        let front = self.imageViews[currentPage - 1]
        let back = self.imageViews[currentPage]
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: .curveEaseIn, animations: {
            front.frame.origin.x = 0
            front.alpha = 1
            back.frame.origin.x = SCREEN_WIDTH
            back.alpha = 0
        }) { (finish) in }
        
        if currentPage == 1 {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
                self.backgroundImageView.alpha = 0
            }, completion: nil)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.guideViews[self.currentPage - 1].alpha = 1
            self.guideViews[self.currentPage].alpha = 0
        }
        currentPage -= 1
    }
    
    func setupGuideView() {
        
        let imageArr: [UIImage] = [#imageLiteral(resourceName: "guide1"),#imageLiteral(resourceName: "guide2"),#imageLiteral(resourceName: "guide3"),#imageLiteral(resourceName: "guide4"),#imageLiteral(resourceName: "guide5")]
        for i in 0...4 {
            let imageView = UIImageView(frame: CGRect(x: i == 0 ? 0 : SCREEN_WIDTH, y: guideImageY, width: SCREEN_WIDTH, height: guideImageHeight))
            imageView.alpha = i == 0 ? 1 : 0
            imageView.image = imageArr[i]
            imageView.contentMode = .center
            imageViews.append(imageView)
            self.view.addSubview(imageView)
        }
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
