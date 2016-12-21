//
//  KWMyrecordDetailViewController.swift
//  KnowWords
//
//  Created by 一折 on 2016/12/20.
//  Copyright © 2016年 yizhe. All rights reserved.
//

import UIKit
import AVFoundation

class KWMyrecordDetailViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet var textView: UITextView!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var timeLabel: UILabel!
    
    var articleId:Int = -1
    var filename:String = ""
    
    var player:AVAudioPlayer!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            self.player = try AVAudioPlayer(contentsOf: inf.documentsFolder(filename: self.filename))
            self.player.delegate = self
            self.player.prepareToPlay()
            self.loadText()
        }catch{
            _ = self.navigationController?.popViewController(animated: true)
        }
        
        let displayLink = CADisplayLink(target: self, selector: #selector(updateMeters))
        displayLink.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
        // Do any additional setup after loading the view.
    }
    
    func updateMeters(){
        if self.player != nil && self.player.isPlaying{
            let playSecond = floor(self.player.currentTime)
            self.timeLabel.text = inf.timeStr(second: Int(playSecond))
        }
    }
    
    func loadText(){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playAction(_ sender: Any) {
        if self.player.isPlaying{
            self.player.pause()
            self.playButton.setImage(UIImage(named:"play_2x"), for: .normal)
        }else{
            self.player.play()
            self.playButton.setImage(UIImage(named:"pause"), for: .normal)
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.playButton.setImage(UIImage(named:"play_2x"), for: .normal)
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
