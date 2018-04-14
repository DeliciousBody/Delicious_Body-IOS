//
//  DBGuideVC.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 3. 29..
//  Copyright © 2018년 changmin. All rights reserved.
//


import UIKit

class DBGuideVC: UIViewController {
    @IBOutlet var guideScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupGuideView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupGuideView() {
        
        guideScrollView.contentSize = CGSize(width: SCREEN_WIDTH * 2, height: SCREEN_HEIGHT - 60)
        
        for i in 0...1 {
            let imageV = UIImageView(frame: CGRect(x: SCREEN_WIDTH * CGFloat(i), y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 60))
            imageV.image = UIImage(named: "guide\(i)")
            guideScrollView.addSubview(imageV)
        }
        
    }
    
}
