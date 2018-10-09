//
//  DBVideoViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 4. 14..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit
import AVFoundation
import Player

class DBVideoViewController: UIViewController {

    @IBOutlet var togetherButton: UIButton!
    @IBOutlet var playButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet var videoView: UIView!
    @IBOutlet var touchView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var likeButton: DBButton!
    
    @IBOutlet weak var descLabel: UITextViewFixed!
    @IBOutlet var tableView: UITableView!
    var isPlaying: Bool = false {
        didSet {
            if isPlaying {
                player.playFromCurrentTime()
                self.playButton.isSelected = self.isPlaying
                showPlayButton(isShow: false)
            } else {
                player.pause()
                playButton.isSelected = isPlaying
            }
            
        }
    }
  
    var isShowing: Bool = true
    var player: Player!
    
    var exercise: Exercise?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setVideoUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setNaviBar(isShow: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNaviBar(isShow: true)
        setUI()
    }
    
    func setNaviBar(isShow: Bool) {
        guard let bar = self.navigationController?.navigationBar else { return }
        bar.layer.zPosition = -1
    }
    
    func setVideoUI() {
        togetherButton.layer.cornerRadius = 5
        guard let exer = exercise else { return }
        player = Player()
        player.playerDelegate = self
        player.playbackDelegate = self
        
        if let url = URL(string: exer.video_file) {
            player.url = url
        }
        
        player.view.frame = videoView.bounds
        self.addChildViewController(player)
        
        videoView.addSubview(player.view)
        
        videoView.bringSubview(toFront: playButton)
        videoView.bringSubview(toFront: togetherButton)
        videoView.bringSubview(toFront: backButton)
        let touchReco = UITapGestureRecognizer(target: self, action: #selector(self.playerTouched))
        player.view.addGestureRecognizer(touchReco)
    }
    
    func setUI() {
        tableView.register(UINib(nibName: "DBExerCell", bundle: nil) , forCellReuseIdentifier: "exerCell")
        guard let exer = exercise, let me = User.me else { return }
        titleLabel.text = exer.video_name
        likeButton.isSelected = me.isFavoriteVideo(id: exer.video_id)
    }
    
    func showPlayButton(isShow: Bool, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.playButton.isEnabled = isShow
            self?.playButton.alpha = isShow ? 1.0 : 0.0
            self?.backButton.isEnabled = isShow
            self?.backButton.alpha = isShow ? 1.0 : 0.0
        }) { [weak self] _ in
            self?.isShowing = isShow
            completion?()
        }
    }
}

extension DBVideoViewController: PlayerDelegate, PlayerPlaybackDelegate {
    
    func playerReady(_ player: Player) {}
    func playerPlaybackStateDidChange(_ player: Player) {}
    func playerBufferingStateDidChange(_ player: Player) {}
    func playerBufferTimeDidChange(_ bufferTime: Double) {}
    
    public func playerPlaybackWillStartFromBeginning(_ player: Player) {
        print(#function)
    }
    
    public func playerPlaybackDidEnd(_ player: Player) {
        print(#function)
        isPlaying = false
        showPlayButton(isShow: true)
    }
    
    public func playerCurrentTimeDidChange(_ player: Player) {}
    
    public func playerPlaybackWillLoop(_ player: Player) {}
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        isPlaying = !sender.isSelected
    }
    
    @IBAction func togetherButtonPressed(_ sender: UIButton) {
        if let url = exercise?.video_url {
            UIApplication.shared.open(URL(string: "\(url)")!, options: [:], completionHandler: nil)
        }
    }
     
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        if let me = User.me, let exer = exercise {
            me.setFavoriteVideo(id: exer.video_id, isLike: !sender.isSelected)
            DBNetworking.updateUserInfo(params: ["favorite_list" : me.favorite_list ?? []]) { (result) in
                if result == 200 {
                    me.save()
                }
            }
        }
    }
    
    @objc func playerTouched() {
        print(#function)
        showPlayButton(isShow: !isShowing)
    }
}

extension DBVideoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            return UINib(nibName: "DBVideoSectionHeader", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? UIView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 30
        } else {
            return 0
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableViewAutomaticDimension
        default:
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "descCell", for: indexPath) as! DBDescCell
            cell.descTextView.text = exercise?.description
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "exerCell", for: indexPath) as! DBExerCell
            cell.likeHandler = { num in
                print(num)
            }
            return cell
        }
    }
}
