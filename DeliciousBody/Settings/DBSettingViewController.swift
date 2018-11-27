//
//  DBSettingViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 9. 8..
//  Copyright © 2018년 changmin. All rights reserved.
//
import UIKit
import Kingfisher

class DBSettingViewController: DBViewController {
    
    var sampleData: [(BodyType, Int)] = []
    var max = 20
    let historyViewModel = HistroyViewModel()
    
    var originFrame = CGRect()
    var selectedImage = UIImage()
    
    let Padding: CGFloat = 20
    let CellWidth: CGFloat = 169
    
    let interactor = Interactor()
    
    @IBOutlet weak var profileImageView: DBProfileImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sloganLabel: UILabel!
    @IBOutlet weak var historyCollectionView: UICollectionView!
    
    @IBOutlet weak var editInfoBtn: UIButton!
    @IBOutlet weak var editTypeBtn : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        sampleData = [(.neck, 20), (.chest, 18), (.abdomen, 14), (.thigh, 3), (.calf, 10), (.arm, 6), (.back, 16), (.hip, 10), (.body, 10)]
        
        historyCollectionView.dataSource = historyViewModel
        historyCollectionView.delegate = historyViewModel
        historyViewModel.handler = { indexPath, exercise in
            guard let collectionView = self.historyCollectionView else { return }
            self.originFrame = CGRect(x: self.Padding + (self.CellWidth * CGFloat(indexPath.row)) - collectionView.contentOffset.x , y: SCREEN_WIDTH * 180 / 375 + 64, width: 152, height: 90)
            self.selectedImage = DBCache.shared.loadImage(key: "\(exercise.video_id)img") ?? #imageLiteral(resourceName: "sample_history")
            self.performSegue(withIdentifier: "video", sender: exercise)
        }
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        setupUI()
        setData()
    }
    
    func setData() {
        historyViewModel.reload()
        historyCollectionView.reloadData()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "video" {
            let vc = segue.destination as! DBVideoViewController
            let exer = sender as! Exercise
            vc.exercise = exer
            vc.thumbnailImage = DBCache.shared.loadImage(key: "\(exer.video_id)img") ?? #imageLiteral(resourceName: "sample_history")
            vc.interactor = interactor
            vc.transitioningDelegate = self
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

extension DBSettingViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HistoryTransition(originFrame: self.originFrame, thumbnailImage: self.selectedImage)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let _ = dismissed as? DBVideoViewController else {
            return nil
        }
        return HistoryDismissTransition(originFrame: originFrame, thumbnailImage: self.selectedImage)
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}
