//
//  DBMainViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 4. 10..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

struct CardData {
    var opened = false
    var title = ""
    var subtitles = [String]()
}

class DBMainViewController: UIViewController {
    var tableViewData = [CardData]()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewData = [
            CardData(opened: false, title: "title1", subtitles: ["sub1","sub2"]),
            CardData(opened: false, title: "title2", subtitles: ["sub1","sub2"]),
            CardData(opened: false, title: "title3", subtitles: ["sub1","sub2"])]
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened {
            return tableViewData[section].subtitles.count + 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DBMainCardCell
            return cell
        } else if indexPath.row == tableViewData[indexPath.section].subtitles.count + 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            performSegue(withIdentifier: "pushVideo", sender: nil)
            return
        }
        tableViewData[indexPath.section].opened = !tableViewData[indexPath.section].opened
        
        let cell = tableView.cellForRow(at: indexPath) as! DBMainCardCell
        
        let sections = IndexSet.init(integer: indexPath.section)
        
        tableView.beginUpdates()
        tableView.reloadSections(sections, with: .none)
        
        tableView.endUpdates()
        cell.setCorner(selected: tableViewData[indexPath.section].opened)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        } else if indexPath.row == tableViewData[indexPath.section].subtitles.count {
            return 30
        } else {
            return 50
        }
    }

}

extension DBMainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        moveAndResizeImageForPortrait()
    }
}

