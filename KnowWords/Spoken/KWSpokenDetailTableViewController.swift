//
//  KWSpokenDetailTableViewController.swift
//  KnowWords
//
//  Created by 一折 on 2016/12/16.
//  Copyright © 2016年 yizhe. All rights reserved.
//

import UIKit
import AVFoundation

class KWSpokenDetailTableViewController: UITableViewController {
    
    var player:AVPlayer!
    var audioStatus:AudioStatus = .Stop
    var currentIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor=UIColor.clear
        self.tableView.estimatedRowHeight = 350
        self.tableView.rowHeight = UITableViewAutomaticDimension
        let nib = UINib(nibName:"SpokenDetailTableViewCell", bundle:nil)
        tableView.register(nib, forCellReuseIdentifier:"SpokenDetailTableViewCell")
        self.tableView.backgroundColor = inf.backColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 9+1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellid = ""
        var cell:UITableViewCell
        if indexPath.row == 0{
            cellid = "DetailCell"
            cell = tableView.dequeueReusableCell(withIdentifier: cellid)!
            cell.backgroundColor = inf.backColor
        }else{
            cellid = "SpokenDetailTableViewCell"
            cell = tableView.dequeueReusableCell(withIdentifier: cellid) as! SpokenDetailTableViewCell
        }
        
        if cellid == "SpokenDetailTableViewCell"{
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapBubble(_:)))
            (cell as! SpokenDetailTableViewCell).bubble.addGestureRecognizer(tap)
            let good = UITapGestureRecognizer(target: self, action: #selector(self.goodAction(_:)))
            (cell as! SpokenDetailTableViewCell).goodButton.addGestureRecognizer(good)
            
        }
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return UITableViewAutomaticDimension
        }
        return 100
    }
    
    func tapBubble(_ sender: UITapGestureRecognizer){
        let tapLocatiion = sender.location(in: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: tapLocatiion)!
        guard (self.tableView.cellForRow(at: indexPath) != nil) else {
            return
        }
        let cell = self.tableView.cellForRow(at: indexPath) as! SpokenDetailTableViewCell
        
        if self.currentIndex == indexPath.row{
            self.audioStatus = self.audioStatus == .Play ? .Pause : .Play
        }else if self.currentIndex<0{
            self.audioStatus = .Stop
        }else{
            self.audioStatus = .Stop
            let i = IndexPath(row: self.currentIndex, section: 0)
            let currentBubble = (self.tableView.cellForRow(at: i) as! SpokenDetailTableViewCell).bubble!
            currentBubble.stopAnimating()
        }
        self.currentIndex = indexPath.row
        
        if self.audioStatus == .Stop{
            self.player = nil
            cell.bubble.startAnimating()
            let url = URL(string: inf.exampleURL[0])!
            self.player = AVPlayer(url: url)
            self.player.play()
            self.audioStatus = .Play
        }else{
            self.audioStatus == .Play ? self.player.play() : self.player.pause()
            self.audioStatus == .Play ? cell.bubble.startAnimating() : cell.bubble.stopAnimating()
        }
    }
    
    func goodAction(_ sender: UITapGestureRecognizer){
        let tapLocatiion = sender.location(in: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: tapLocatiion)!
        guard (self.tableView.cellForRow(at: indexPath) != nil) else {
            return
        }
        let cell = self.tableView.cellForRow(at: indexPath) as! SpokenDetailTableViewCell
        cell.isGood = cell.isGood ? false : true
        if cell.isGood{
            cell.goodAction()
        }else{
            cell.ungoodAction()
        }
    }
   
    @IBAction func record(_ sender: Any) {
        let recordVC = self.storyboard?.instantiateViewController(withIdentifier: "KWSpokenRecordViewController") as! KWSpokenRecordViewController
        recordVC.articleId = -1
        self.navigationController?.pushViewController(recordVC, animated: true)
    }
}
