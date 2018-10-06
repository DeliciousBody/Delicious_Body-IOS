//
//  DBMainViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 4. 10..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit
import Kingfisher
class DBMainViewController: UIViewController {
    var tableViewModel = CardViewModel()
    
    let ImageSizeForLargeState: CGFloat = 60
    let ImageSizeForSmallState: CGFloat = 32
    let ImageTopMarginForLargeState: CGFloat = 40
    let ImageTopMarginForSmallState: CGFloat = 40
    let ImageRightMargin: CGFloat = 20
    
    let subCellHeight: CGFloat = 100
    let cardHeight: CGFloat = 180
    let closeHeight: CGFloat = 24
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var titleLabel = UILabel()
    
    let imageView = DBProfileImageView(image: UIImage(named: "sample"))
    var snapShot = UIView()
    var nameSnapShot = UIView()
    var originFrame = CGRect()
    var selectedImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewModel.handler = { indexPath, exercise in
            guard let tableView = self.tableView else { return }
            let index = IndexPath(row: 0, section: indexPath.section)
            let cell = tableView.cellForRow(at: index) as! DBMainCardExtendCell
            let cellFrame = tableView.rectForRow(at: index)
            self.originFrame = CGRect(x: 20, y: cellFrame.origin.y - tableView.contentOffset.y + 10, width: 335, height: cellFrame.height - 20)
            self.snapShot = cell.tableView.takeSnapshot()
            self.nameSnapShot = cell.nameLabel.takeSnapshot()
            self.selectedImage = cell.thumbnailView.image ?? UIImage()
            self.performSegue(withIdentifier: "pushVideo", sender: exercise)
            
        }
        setupUI()
        if let token = User.me?.token {
            DBNetworking.getRecommendList() { (result, items) in
                self.tableViewModel.items = items
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showImage(false)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
        refreshLabels()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showImage(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if UIDevice.current.orientation.isPortrait {
            moveAndResizeImageForPortrait()
        }
    }
    
    func setupUI() {
        guard let me = User.me else { return }
        let title = "\(me.name ?? "")님,\n\(me.slogan ?? "")"
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 24)
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        
        imageView.layer.cornerRadius =  ImageSizeForLargeState / 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        if let urlStr = me.photoUrl , let url = URL(string: urlStr) {
            imageView.kf.setImage(with: url)
        }
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor,
                                            constant:ImageRightMargin),
            imageView.topAnchor.constraint(equalTo: view.topAnchor,
                                           constant: ImageTopMarginForLargeState),
            imageView.heightAnchor.constraint(equalToConstant: ImageSizeForLargeState),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
            ])
        
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor,
                                             constant:ImageRightMargin),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor,
                                            constant: ImageTopMarginForLargeState),
            titleLabel.heightAnchor.constraint(equalToConstant: ImageSizeForLargeState),
            ])
    }
    
    func refreshLabels() {
        guard let me = User.me else { return }
        let title = "\(me.name ?? "")님,\n\(me.slogan ?? "")"
        titleLabel.text = title
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! DBVideoViewController
        destinationViewController.transitioningDelegate = self
        destinationViewController.exercise = sender as? Exercise
    }
}

extension DBMainViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !tableViewModel.items[indexPath.section].opened {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DBMainCardCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! DBMainCardExtendCell
            cell.tableView.tag = indexPath.section
            cell.tableView.dataSource = tableViewModel
            cell.tableView.delegate = tableViewModel
            cell.tableView.reloadData()
            cell.tableView.register(UINib(nibName: "DBExerCell", bundle: nil) , forCellReuseIdentifier: "exerCell")
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
//
//            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: .curveEaseOut, animations: {
//                    self.tableView.contentOffset.y += 30
//
//            }, completion: nil)
//
//            return
        }
        tableViewModel.items[indexPath.section].opened = !tableViewModel.items[indexPath.section].opened
        
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableViewModel.items[indexPath.section].opened {
            var height = cardHeight
            height += CGFloat(tableViewModel.items[indexPath.section].rowCount) * subCellHeight
            height += closeHeight + 20
            return height
        } else {
            return cardHeight + 20
        }
    }
}

extension DBMainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        moveAndResizeImageForPortrait()
    }
}
