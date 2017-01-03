//
//  KWShortTestViewController.swift
//  KnowWords
//
//  Created by 一折 on 2016/12/12.
//  Copyright © 2016年 yizhe. All rights reserved.
//

import UIKit
import AVFoundation

class KWShortTestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var audioButton: UIButton!
    @IBOutlet var quitButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var waveButton: UIButton!
    @IBOutlet var waveButtonWidth: NSLayoutConstraint!
    @IBOutlet var waveButtonHeight: NSLayoutConstraint!
    
    var player:AVPlayer!
    
    var audioStatus:AudioStatus = .Stop
    var testStatus:TestStatus = .Doing
    var selectedIndex = 0
    private var dataIndex = 0
    private var answerRight = true
    private var titleData = titleTool.getShortTitles()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 250
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.quitButton.setBorder(width: 1, color: inf.fontColor, cornerRadius: 5)
        self.nextButton.setBorder(width: 0, color: inf.frontColor, cornerRadius: 5)
        self.waveButton.setBorder(width: 1, color: inf.fontColor, cornerRadius: self.waveButton.frame.size.width/2)
        self.waveButton.alpha = 0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func audioAction(_ sender: Any) {
        if self.audioStatus == .Play{
            self.pauseCurrentAudio()
        }else{
            self.playRemoteAudio(urlString: titleTool.exampleURL[self.dataIndex%2])
        }
        self.waveAnimate()
    }
    @IBAction func nextAction(_ sender: Any) {
        
        guard (self.tableView.indexPathForSelectedRow != nil) else {
            let alertController = UIAlertController(title: nil, message: "请选择选项", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "确定", style: .default, handler: {
                _ in
                alertController.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        self.testStatus = TestStatus(rawValue: (self.testStatus.rawValue+1) % 2)!
        if self.testStatus == .Checking{
            
            let ans = self.titleData[dataIndex][6]
            if titleTool.answerIndex[ans] == self.selectedIndex{
                answerRight = true
            }else{
                answerRight = false
            }
            
            self.tableView.beginUpdates()
            let indexPath = IndexPath(row: 5, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
            self.tableView.allowsSelection = false
        }else{
            self.selectedIndex = -1
            self.tableView.allowsSelection = true
            self.dataIndex = (self.dataIndex+1)%self.titleData.count
            self.tableView.reloadData()
            self.player = nil
            self.audioStatus = .Stop
        }

    }
    
    
    @IBAction func quitAction(_ sender: Any) {
        self.player = nil
        let alertController = UIAlertController(title: nil, message: "确定要结束？", preferredStyle: .actionSheet)
        let leaveAction = UIAlertAction(title: "结束", style: .destructive, handler: {
            _ in
            self.dismiss(animated: true, completion: nil)
        })
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: {
            _ in
            alertController.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(leaveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)

        
    }
    
    func playRemoteAudio(urlString:String){
        if self.player != nil{
            self.pauseCurrentAudio()
        }
        switch self.audioStatus {
        case .Play:
            return
        case .Pause:
            guard self.player != nil else {
                return
            }
            self.player.play()
        case .Stop:
            let url = URL(string: urlString)
            self.player = AVPlayer(url: url!)
            self.player.play()
        }
        self.audioStatus = .Play
    }
    
    func pauseCurrentAudio(){
        guard self.player != nil else {
            return
        }
        self.player.pause()
        self.audioStatus = .Pause
    }
    
    // MARK: - Wave animate
    func waveAnimate(){
        guard self.audioStatus == .Play else {
            return
        }
        let transform = CGAffineTransform(scaleX: 2, y: 2)
        self.waveButton.alpha = 1
        UIView.animate(withDuration: 1,
                       delay: 0,
                       options: .curveLinear,
                       animations: {
                        self.waveButton.transform = transform
                        self.waveButton.alpha = 0
        },
                       completion: {
                        _ in
                        self.waveButton.transform = CGAffineTransform(scaleX: 1, y: 1)
                        self.waveAnimate()
        }
        )
    }
    
    // MARK: - Table view datasource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.testStatus == .Doing{
            return 5
        }
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        var cellid = ""
        if index == 0 {
            cellid = "TitleCell"
        }else if index == 5{
            cellid = "AnswerCell"
        }else{
            cellid = "SelectionCell"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid)!
        
        let contentLabel = cell.viewWithTag(1) as! UILabel
        contentLabel.text = self.titleData[dataIndex][index]
        
        if index>0 && index<5 {
            contentLabel.textColor = inf.fontColor
            let checkMark = cell.viewWithTag(2) as!UIImageView
            checkMark.image = UIImage(named: "unRadio")
        }
        if index == 5{
            if answerRight == true{
                contentLabel.textColor = inf.frontColor
            }else{
                contentLabel.textColor = inf.wrongColor
            }
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row>0 && indexPath.row<5 else {
            return
        }
        let cell = tableView.cellForRow(at: indexPath)!
        (cell.viewWithTag(1) as!UILabel).textColor = inf.frontColor
        (cell.viewWithTag(2) as!UIImageView).image = UIImage(named: "radio")
        self.selectedIndex = indexPath.row
    }
    
    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        guard indexPath.row>0 && indexPath.row<5 else {
            return indexPath
        }
        let cell = tableView.cellForRow(at: indexPath)!
        (cell.viewWithTag(1) as!UILabel).textColor = inf.fontColor
        (cell.viewWithTag(2) as!UIImageView).image = UIImage(named: "unRadio")
        return indexPath
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
