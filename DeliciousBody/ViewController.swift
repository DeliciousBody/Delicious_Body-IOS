//
//  ViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 3. 29..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var smallLogo: UIImageView!
    @IBOutlet var deliciousLogo: UIImageView!
    @IBOutlet var bodyLogo: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MainNav")
        self.present(controller, animated: false, completion: nil)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        smallLogo.frame.origin.y += 30
        deliciousLogo.frame.origin.x += 30
        bodyLogo.frame.origin.y += 30
        
//        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseIn, animations: {
//            [weak self] in
//            self?.smallLogo.alpha = 1
//            self?.smallLogo.frame.origin.y -= 30
//            }, completion: { completion in
//
//                UIView.animate(withDuration: 0.3, delay: 0.2, options: .curveEaseIn, animations: {
//                    [weak self] in
//                    self?.deliciousLogo.alpha = 1
//                    self?.deliciousLogo.frame.origin.x -= 30
//                    }, completion: { completion in
//
//                        UIView.animate(withDuration: 0.8, delay: 0.2, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
//                            [weak self] in
//                            self?.bodyLogo.alpha = 1
//                            self?.bodyLogo.frame.origin.y -= 30
//                            }, completion: { completion in
//                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                                let controller = storyboard.instantiateViewController(withIdentifier: "MainNav")
//                                self.present(controller, animated: false, completion: nil)
                                
//                        })
//                })
//        })
        
    }
}

