//
//  DBStartViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 8. 16..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBStartViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    
    var image1 = UIImageView(image: UIImage(named: "splash1"))
    var image2 = UIImageView(image: UIImage(named: "splash2"))
    var image3 = UIImageView(image: UIImage(named: "splash3"))
    var image4 = UIImageView(image: UIImage(named: "splash4"))
    
    let kTopPadding: CGFloat = 3
    let kMidPadding: CGFloat = 19
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(DBStartViewController.appDidBecomeActive), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(DBStartViewController.didLogout), name: NSNotification.Name(rawValue: kDidLogoutNotification), object: nil)
        
        image1.alpha = 0
        image2.alpha = 0
        image3.alpha = 0
        image4.alpha = 0
        
        image1.frame = CGRect(x: 65, y: 0, width: 39, height: 40)
        image2.frame = CGRect(x: 68, y: kTopPadding, width: 103, height: 15)
        image3.frame = CGRect(x: 47, y: kTopPadding, width: 14, height: 14)
        image4.frame = CGRect(x: 81, y: kMidPadding + kTopPadding, width: 42, height: 14)
        
        contentView.addSubview(image1)
        contentView.addSubview(image2)
        contentView.addSubview(image3)
        contentView.addSubview(image4)
    }
    
    @objc func appDidBecomeActive() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        self.show()
    }
    
    @objc func didLogout() {
        self.show()
    }
    
    fileprivate func show() {
        if User.fetchToken() != nil {
            self.animateSegue("Main", sender: nil)
        } else {
            self.animateSegue("Login", sender: nil)
        }
    }
    
    func animateSegue(_ identifier:String,sender:AnyObject?) {
        
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.image1.alpha = 1
            self.image1.frame.origin = CGPoint(x: 0, y: 0)
        })
        UIView.animate(withDuration: 0.7, delay: 0.4, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveLinear, animations: {
            self.image2.alpha = 1
            self.image2.frame.origin = CGPoint(x: 47, y: self.kTopPadding)
        }) { (complete) in
            self.image3.alpha = 1
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveLinear, animations: {
                self.image3.frame.origin = CGPoint(x: 47, y: self.kMidPadding + self.kTopPadding)
            }) { (complete) in
                UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveLinear, animations: {
                    self.image4.alpha = 1
                    self.image4.frame.origin = CGPoint(x: 61, y: self.kMidPadding + self.kTopPadding)
                }) { (complete) in
                    UIView.animate(withDuration: 0.2, animations: {
                        let rotate = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 11))
                        self.image1.transform = rotate
                    }, completion: { (complete) in
                        UIView.animate(withDuration: 0.3, animations: {
                            self.view.backgroundColor = UIColor.white
                        }, completion: { (comlete) in
                            self.performSegue(withIdentifier: identifier, sender: sender)
                        })
                    })
                }
            }
        }
    }
}
