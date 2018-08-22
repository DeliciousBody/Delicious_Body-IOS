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
    
    let maxScrollViewWidth = SCREEN_WIDTH * 5
    let guideImageHeight: CGFloat = 330
    let guideImageY: CGFloat = 200
    
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
    
    @objc func leftSwipe(gesture: UISwipeGestureRecognizer) {
        guard currentPage < 4 else { return }
        let front = self.imageViews[currentPage]
        let back = self.imageViews[currentPage + 1]
        currentPage += 1
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: .curveEaseIn, animations: {
            front.frame.origin.x = -100
            front.alpha = 0
            back.frame.origin.x = 0
            back.alpha = 1
        }) { (finish) in
        }
    }
    
    @objc func rightSwipe(gesture: UISwipeGestureRecognizer) {
        guard currentPage > 0  else { return }
        let front = self.imageViews[currentPage - 1]
        let back = self.imageViews[currentPage]
        currentPage -= 1
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: .curveEaseIn, animations: {
            front.frame.origin.x = 0
            front.alpha = 1
            back.frame.origin.x = SCREEN_WIDTH
            back.alpha = 0
        }) { (finish) in
        }
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
