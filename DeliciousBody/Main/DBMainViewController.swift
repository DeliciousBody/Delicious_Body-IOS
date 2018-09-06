//
//  DBMainViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 4. 10..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBMainViewController: UIViewController {
    var tableViewModel = CardViewModel()
    
    let ImageSizeForLargeState: CGFloat = 60
    let ImageSizeForSmallState: CGFloat = 32
    let ImageTopMarginForLargeState: CGFloat = 40
    let ImageTopMarginForSmallState: CGFloat = 8
    let ImageRightMargin: CGFloat = 20
    let NavBarHeightSmallState: CGFloat = 44
    let NavBarHeightLargeState: CGFloat = 96.5
    
    let subCellHeight: CGFloat = 100
    let cardHeight: CGFloat = 180
    let closeHeight: CGFloat = 24
    
    @IBOutlet var tableView: UITableView!
    var titleLabel = UILabel()
    
    let imageView = UIImageView(image: UIImage(named: "image_name"))
    var snapShot = UIView()
    var nameSnapShot = UIView()
    var originFrame = CGRect()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewModel.handler = { indexPath, exercise in
            guard let tableView = self.tableView else { return }
//            self.navigationController?.delegate = self
            let index = IndexPath(row: 0, section: indexPath.section)
            let cell = tableView.cellForRow(at: index) as! DBMainCardExtendCell
            let cellFrame = tableView.rectForRow(at: index)
            self.originFrame = CGRect(x: 20, y: cellFrame.origin.y - tableView.contentOffset.y + 10, width: 335, height: cellFrame.height - 20)
            self.snapShot = cell.tableView.takeSnapshot()
            self.nameSnapShot = cell.nameLabel.takeSnapshot()
            self.performSegue(withIdentifier: "pushVideo", sender: nil)
            
        }
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        showImage(false)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        showImage(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if UIDevice.current.orientation.isPortrait {
            moveAndResizeImageForPortrait()
        }
    }
    
    func setupUI() {
        titleLabel.text = "창민님,\n초콜릿복근 가즈아🔥"
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 24)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.shadowImage = UIImage()
        navigationBar.addSubview(imageView)
        navigationBar.addSubview(titleLabel)
        
        imageView.layer.cornerRadius =  ImageSizeForLargeState / 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: navigationBar.leftAnchor,
                                            constant:ImageRightMargin),
            imageView.topAnchor.constraint(equalTo: navigationBar.topAnchor,
                                           constant: ImageTopMarginForLargeState),
            imageView.heightAnchor.constraint(equalToConstant: ImageSizeForLargeState),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
            ])
        
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor,
                                             constant:ImageRightMargin),
            titleLabel.topAnchor.constraint(equalTo: navigationBar.topAnchor,
                                            constant: ImageTopMarginForLargeState),
            titleLabel.heightAnchor.constraint(equalToConstant: ImageSizeForLargeState),
            ])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! DBVideoViewController
            destinationViewController.transitioningDelegate = self
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
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: .curveEaseOut, animations: {
                    self.tableView.contentOffset.y += 30
                
            }, completion: nil)
            
            return
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
