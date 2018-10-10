//
//  DBVideoListViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 5. 1..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBVideoListViewController: UIViewController {
    var tableViewModel = VideoViewModel()
    
    @IBOutlet weak var filterBarButton: UIBarButtonItem!
    @IBOutlet var tableViewAll: UITableView!
    @IBOutlet var tableViewLike: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var tabbarView: UIView!
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    var tabbarLine = UIView()
    
    let kTabbarPadding: CGFloat = 23
    let kTabbarLineHeight: CGFloat = 2
    
    var option: Int = 0 {
        didSet {
            allButton.isSelected = option == 0
            likeButton.isSelected = option == 1
            animate()
        }
    }
    
    var exercises: [Exercise] = []
    var filter: [BodyType] = [] {
        didSet {
            if filter.count == 0 {
                filterBarButton.image = UIImage(named: "barbutton_filter")
            } else {
                filterBarButton.image = UIImage(named: "barbutton_filter_selected")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        setupTableView()
        setupUI()
        
        DBNetworking.getVideoList() { (result, exercises) in
            self.exercises = exercises
            self.tableViewModel.allItems = exercises
            self.reloadTableViewData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        self.reloadTableViewData()
    }
    
    func reloadTableViewData() {
        if let me = User.me {
            self.tableViewModel.likeItems = exercises.filter({ (exer) -> Bool in
                return me.isFavoriteVideo(id: exer.video_id)
            })
            self.tableViewLike.reloadData()
            self.tableViewAll.reloadData()
        }
    }
    
    func setupTableView(){
        tableViewAll.register(UINib(nibName: "DBExerCell", bundle: nil) , forCellReuseIdentifier: "exerCell")
        tableViewLike.register(UINib(nibName: "DBExerCell", bundle: nil) , forCellReuseIdentifier: "exerCell")
        tableViewAll.delegate = tableViewModel
        tableViewAll.dataSource = tableViewModel
        tableViewLike.delegate = tableViewModel
        tableViewLike.dataSource = tableViewModel
        
        tableViewModel.handler = { exercise in
            let storyBoard = UIStoryboard(name: "Home", bundle: nil)
            let mainViewController = storyBoard.instantiateViewController(withIdentifier: "DBVideoViewController") as! DBVideoViewController
            mainViewController.exercise = exercise
            self.present(mainViewController, animated: true, completion: nil)
        }
        if let me = User.me{
            tableViewModel.likeHandler = { id in
                self.reloadTableViewData()
            }
        }
    }
    
    func setupUI() {
        tabbarLine.frame = CGRect(x: kTabbarPadding, y: 50 - kTabbarLineHeight, width: SCREEN_WIDTH / 2 - kTabbarPadding, height: kTabbarLineHeight)
        tabbarLine.backgroundColor = UIColor.themeBlue
        tabbarLine.layer.cornerRadius = 1
        tabbarLine.clipsToBounds = true
        
        tabbarView.addSubview(tabbarLine)
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "search", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "search" {
            let vc = segue.destination as! DBVideoSearchViewController
            vc.allList = tableViewModel.allItems
        } else if segue.identifier == "filter" {
            let vc = segue.destination as! DBVideoFilterViewController
            vc.filter = filter
            vc.filterHandler = { filter in
                self.filter = filter
                let filterInt = filter.map{ $0.rawValue }
                if filterInt.count == 0 {
                    self.tableViewModel.allItems = self.exercises
                } else {
                    self.tableViewModel.allItems = self.exercises.filter({ return filterInt.contains($0.main_part) || filterInt.contains($0.sub_part)})
                }
                self.tableViewAll.reloadData()
            }
        }
    }
    @IBAction func acitoin(_ sender: UIButton) {
        guard sender.tag != option else {
            return
        }
        option = sender.tag
    }
    
    func animate() {
        let sender: UIButton = option == 0 ? allButton : likeButton
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveLinear, animations: {
            self.scrollView.contentOffset.x = SCREEN_WIDTH * CGFloat(self.option)
            self.tabbarLine.center.x = self.option == 0 ? self.allButton.center.x : self.likeButton.center.x
            
        })
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { (complete) in
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: {
                sender.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
            }) { (complete) in
                UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseIn, animations: {
                    sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                }) { (complete) in
                    UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseIn, animations: {
                        sender.transform = CGAffineTransform.identity
                    }) { (complete) in
                        
                    }
                }
            }
        }
    }
}

extension DBVideoListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
        let ratio = scrollView.contentOffset.x / SCREEN_WIDTH
        tabbarLine.center.x = allButton.center.x  + (likeButton.center.x - allButton.center.x) * ratio
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        option = Int(round(scrollView.contentOffset.x / SCREEN_WIDTH))
    }
}

extension DBVideoListViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard toVC is DBVideoSearchViewController || fromVC is DBVideoSearchViewController else {
            return nil
        }
        var originFrame = tabbarLine.frame
        originFrame.origin.y += 64
        switch operation {
        case .push:
            return DBVideoSearchTransition(isPresenting: true, originFrame: originFrame)
        default:
            return DBVideoSearchTransition(isPresenting: false, originFrame: originFrame)
        }
    }
}
