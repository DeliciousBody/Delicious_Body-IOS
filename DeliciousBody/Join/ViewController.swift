//
//  ViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 3. 29..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dotView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(back))
        self.view.addGestureRecognizer(tap)
        
    }
    @objc func back(){
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dotView.frame = view.frame
        
        
        UIView.animate(withDuration: 0.4, delay: 1, usingSpringWithDamping: 0.72, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.dotView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
            self.dotView.center = self.view.center
            self.dotView.layer.cornerRadius = 5
        }, completion: nil)
    }
}

