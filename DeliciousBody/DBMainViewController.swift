//
//  DBMainViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 4. 10..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBMainViewController: UIViewController {
    
    let ImageSizeForLargeState: CGFloat = 60
    let ImageSizeForSmallState: CGFloat = 32
    let ImageTopMarginForLargeState: CGFloat = 40
    let ImageTopMarginForSmallState: CGFloat = 8
    let ImageRightMargin: CGFloat = 20
    let NavBarHeightSmallState: CGFloat = 44
    let NavBarHeightLargeState: CGFloat = 96.5
    
    @IBOutlet var tableView: UITableView!
    var titleLabel = UILabel()
    
    let imageView = UIImageView(image: UIImage(named: "image_name"))
    
    var selectedRow = -1
    var selectedRows = Set<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        titleLabel.text = "길동님,\n초콜릿복근 가즈아🔥"
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
}

extension DBMainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DBMainCardCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            performSegue(withIdentifier: "pushVideo", sender: nil)
            return
        }
        if selectedRows.contains(indexPath.row){
            selectedRows.remove(indexPath.row)
        } else {
            selectedRows.insert(indexPath.row)
//            let numberOfWide = selectedRows.filter({return $0 <= indexPath.row}).count
//            let needY = CGFloat(numberOfWide * 400 + (indexPath.row + 1 - numberOfWide) * 200) - tableView.frame.height
//            let current = tableView.contentOffset.y
//
//            print(current, needY)
//            if  current < CGFloat(needY) {
//              tableView.contentOffset = CGPoint(x: 0, y: needY)
//            }
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedRows.contains(indexPath.row){
            return 400
        } else {
            return 200
        }
    }
}

extension DBMainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        moveAndResizeImageForPortrait()
        print(scrollView.contentOffset.y)
    }
}

