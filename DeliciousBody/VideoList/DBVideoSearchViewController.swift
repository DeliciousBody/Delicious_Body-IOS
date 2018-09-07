//
//  DBVideoSearchViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 9. 5..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBVideoSearchViewController: UIViewController {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var emptyImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    var result: [Exercise] = [] {
        didSet {
            countLabel.text = "\(result.count)"
            resultView.alpha = result.count == 0 ? 0 : 1
            tableView.reloadData()
        }
    }
    @IBOutlet weak var resultView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        let attributes = [
            kCTForegroundColorAttributeName: UIColor(red: 126 / 255.0, green: 126 / 255.0, blue: 126 / 255.0, alpha: 1),
            kCTFontAttributeName : UIFont(name: "AppleSDGothicNeo-Medium", size: 12.0)!
        ]
        inputTextField.attributedPlaceholder = NSAttributedString(string: "운동 부위 / 이름을 검색하세요.  예) 목, 거북목", attributes:attributes as [NSAttributedStringKey : Any])
        inputTextField.addTarget(self, action: #selector(textfieldDidChanging(sender:)), for: .editingChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)
//        self.result = [Exercise(),Exercise(),Exercise(),Exercise(),Exercise(),Exercise()]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emptyImageView.transform = CGAffineTransform(scaleX: 0, y: 0)
        emptyImageView.isHidden = false
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.emptyImageView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func setupTableView(){
        tableView.register(UINib(nibName: "DBExerCell", bundle: nil) , forCellReuseIdentifier: "exerCell")
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        inputTextField.resignFirstResponder()
    }
}

extension DBVideoSearchViewController: UITextFieldDelegate {
    @objc func textfieldDidChanging(sender: UITextField) {
        keywordLabel.text = sender.text
        if (sender.text?.count)! > 5 {
            result = [Exercise(),Exercise(),Exercise(),Exercise(),Exercise(),Exercise(),Exercise(),Exercise(),Exercise(),Exercise(),Exercise()]
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        iconImage.isHighlighted = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        iconImage.isHighlighted = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

extension DBVideoSearchViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerCell", for: indexPath) as! DBExerCell
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        inputTextField.resignFirstResponder()
    }
}
