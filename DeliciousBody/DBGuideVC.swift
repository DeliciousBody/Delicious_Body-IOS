//
//  DBGuideVC.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 3. 29..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit
import CHIPageControl

class DBGuideVC: UIViewController {
    @IBOutlet var guideScrollView: UIScrollView!
    @IBOutlet weak var pageControl: CHIPageControlJaloro!
    let maxScrollViewWidth = SCREEN_WIDTH * 5
    let v = UIView(frame: CGRect(x: SCREEN_WIDTH, y: 100, width: SCREEN_WIDTH, height: 60))
    let vv = UIView(frame: CGRect(x: SCREEN_WIDTH * 2, y: 100, width: SCREEN_WIDTH, height: 60))
    override func viewDidLoad() {
        super.viewDidLoad()

        setupGuideView()
        
    }
    
    func setupGuideView() {
        
        guideScrollView.contentSize = CGSize(width: maxScrollViewWidth, height: SCREEN_HEIGHT - 60)
        
        let colorArr: [UIColor] = [.red, .blue, .black, .orange, .green]
        for i in 0...4 {
            let v = UIView(frame: CGRect(x: SCREEN_WIDTH * CGFloat(i), y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 60))
            v.backgroundColor = colorArr[i]
            guideScrollView.addSubview(v)
        }
        
        v.backgroundColor = UIColor.white
        guideScrollView.addSubview(v)
        vv.backgroundColor = UIColor.gray
        guideScrollView.addSubview(vv)
        
    }
    
}

extension DBGuideVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let page = x / maxScrollViewWidth * 5
        pageControl.progress = Double(page)
        v.frame = CGRect(x: SCREEN_WIDTH + SCREEN_WIDTH - x, y: 100, width: SCREEN_WIDTH, height: 60)
        vv.frame = CGRect(x: SCREEN_WIDTH*2 + SCREEN_WIDTH*2 - x, y: 100, width: SCREEN_WIDTH, height: 60)
    }
}
