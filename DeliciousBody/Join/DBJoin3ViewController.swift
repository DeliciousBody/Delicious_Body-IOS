//
//  DBJoin3ViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 5. 28..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBJoin3ViewController: UIViewController {

    @IBOutlet weak var bodyView: DBBodyView!
    var filter: [BodyType] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyView.handler = { filter in
            self.filter = filter
        }
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else {
            return
        }
        
        if id.contains("join") {
            let vc = segue.destination as! DBJoinEmbededViewController
            vc.contentString = kJoinTitles[segue.identifier!]
        }
    }
    @IBAction func confirmButtonPressed(_ sender: Any) {
        if let me = User.me {
            let data = filter.map{"\($0.rawValue)"}.joined(separator: ";")
            me.interested_part = data
        }
        performSegue(withIdentifier: "next", sender: nil)
        
    }
    
}
