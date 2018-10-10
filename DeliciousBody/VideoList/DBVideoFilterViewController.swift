//
//  DBVideoFilterViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 9. 7..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBVideoFilterViewController: UIViewController {

    @IBOutlet weak var bodyView: DBBodyView!
    var filterHandler: (([BodyType]) -> Void)?
    var filter: [BodyType] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyView.handler = { filter in
            print(filter)
            self.filterHandler?(filter)
        } 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bodyView.setSelected(types: filter.map{ $0.rawValue })
    }
    @IBAction func refreshButtonPressed(_ sender: Any) {
        bodyView.reset()
    }
}
