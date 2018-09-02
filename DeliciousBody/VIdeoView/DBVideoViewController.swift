//
//  DBVideoViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 4. 14..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit
import AVFoundation

class DBVideoViewController: UIViewController {

    @IBOutlet var togetherButton: UIButton!
    @IBOutlet var playButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet var videoView: UIView!
    @IBOutlet var touchView: UIView!
    
    @IBOutlet var tableView: UITableView!
    var isPlaying: Bool = false {
        didSet {
            if isPlaying {
                player.play()
            } else {
                player.pause()
            }
        }
    }
  
    var isShowing: Bool = true
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setVideoUI()
        setUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer.frame = videoView.bounds
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setNaviBar(isShow: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNaviBar(isShow: true)
    }
    
    func setNaviBar(isShow: Bool) {
        guard let bar = self.navigationController?.navigationBar else { return }
        bar.prefersLargeTitles = !isShow
        bar.layer.zPosition = -1
    }
    
    func setVideoUI() {
        togetherButton.layer.cornerRadius = 5
        
        let path = Bundle.main.path(forResource: "sample3", ofType: "mp4")!
        let url = URL(fileURLWithPath: path)
        
        player = AVPlayer(url: url)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspect
        
//        videoView.layer.addSublayer(playerLayer)
        videoView.bringSubview(toFront: playButton)
        videoView.bringSubview(toFront: togetherButton)
        videoView.bringSubview(toFront: backButton)
        let touchReco = UITapGestureRecognizer(target: self, action: #selector(self.playerTouched))
        touchView.addGestureRecognizer(touchReco)
    }
    
    func setUI() {
        tableView.register(UINib(nibName: "DBExerCell", bundle: nil) , forCellReuseIdentifier: "exerCell")
    }
    
    func showPlayButton(isShow: Bool) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.playButton.isEnabled = isShow
            self?.playButton.alpha = isShow ? 1.0 : 0.0
            self?.backButton.isEnabled = isShow
            self?.backButton.alpha = isShow ? 1.0 : 0.0
        }) { [weak self] _ in
            self?.isShowing = isShow
        }
    }
    
    
}

extension DBVideoViewController {
    @IBAction func playButtonPressed(_ sender: UIButton) {
        isPlaying = !sender.isSelected
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func togetherButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
     
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func playerTouched() {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "descCell", for: indexPath)
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
