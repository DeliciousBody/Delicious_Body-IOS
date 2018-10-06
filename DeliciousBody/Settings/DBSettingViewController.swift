//
//  DBSettingViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 9. 8..
//  Copyright © 2018년 changmin. All rights reserved.
//
import UIKit
import Kingfisher

class DBSettingViewController: UIViewController {
    
    var sampleData: [(BodyType, Int)] = []
    var max = 20
    let historyViewModel = HistroyViewModel()
    
    @IBOutlet weak var profileImageView: DBProfileImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sloganLabel: UILabel!
    @IBOutlet weak var historyCollectionView: UICollectionView!
    
    @IBOutlet weak var editInfoBtn: UIButton!
    @IBOutlet weak var editTypeBtn : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        sampleData = [(.neck, 20), (.chest, 18), (.abdomen, 14), (.thigh, 3), (.calf, 10), (.arm, 6), (.back, 16), (.hip, 10)]
        
        historyCollectionView.dataSource = historyViewModel
        historyCollectionView.delegate = historyViewModel
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        setupUI()
    }
    
    func setupUI() {
        guard let me = User.me else { return }
        if let urlStr = me.photoUrl , let url = URL(string: urlStr) {
            profileImageView.kf.setImage(with: url)
        }
        nameLabel.text = me.name
        sloganLabel.text = me.slogan
        
        editInfoBtn.makeRound()
        editTypeBtn.makeRound()
    }
    
    @IBAction func editInfoButtonPressed(_ sender: Any) {
        guard let token = User.me?.token, let me = User.me else { return }
        let sampleImage = #imageLiteral(resourceName: "image_name")
        let str = UIImagePNGRepresentation(sampleImage)?.base64EncodedString()
//        DBNetworking.updateUserInfo(token: token, params: ["avatar" : str!], completion: { (result) in
//            if result == 200 {
//                print("image changed")
//            } else {
//                print("error")
//            }
//        })
        DBNetworking.updateUserInfo(params: me.toJSON()) { (result) in
            if result == 200 || result == 201 {
//                me.save()
                    print("success")
//                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//                let mainViewController = storyBoard.instantiateViewController(withIdentifier: "DBMainTabbarController")
//                self.present(mainViewController, animated: true, completion: nil)
            } else {
                print("error")
            }
        }
    }
}

extension DBSettingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DBRecordCell
        let row = indexPath.row
        let data = sampleData[row]
        cell.configure(type: data.0, percent: Float(data.1) / Float(max), record: data.1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleData.count
    }
}
