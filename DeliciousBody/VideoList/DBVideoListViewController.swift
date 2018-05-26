//
//  DBVideoListViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 5. 1..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBVideoListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "DBExerCell", bundle: nil) , forCellReuseIdentifier: "exerCell")
        // Do any additional setup after loading the view.
    }


}


extension DBVideoListViewController: UITableViewDelegate, UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerCell", for: indexPath) as! DBExerCell
        cell.likeHandler = { num in
            print(num)
        }
        return cell
        
    }
}
