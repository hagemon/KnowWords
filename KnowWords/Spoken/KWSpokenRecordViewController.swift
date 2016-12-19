//
//  KWSpokenRecordViewController.swift
//  KnowWords
//
//  Created by 一折 on 2016/12/18.
//  Copyright © 2016年 yizhe. All rights reserved.
//

import UIKit
import AVFoundation

class KWSpokenRecordViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    @IBOutlet var waveformView: WaveformView!
    @IBOutlet var playTime: UILabel!
    @IBOutlet var recordTime: UILabel!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var finishButton: UIButton!
    
    var articleId = -1
    
    var audioRecorder:AVAudioRecorder!
    var player:AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.audioRecorder = audioRecorder(inf.documentsFolder(filename: "\(articleId)"))
        let displayLink = CADisplayLink(target: self, selector: #selector(updateMeters))
        displayLink.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playAction(_ sender: Any) {
        do{
            self.player = try AVAudioPlayer(contentsOf: inf.documentsFolder(filename: "\(articleId)"))
            self.player.prepareToPlay()
        }catch {
            let alertController = UIAlertController(title: nil, message: "尚未完成录音", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "确定", style: .default, handler: {
                _ in
                alertController.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        if self.player.isPlaying{
            self.player.stop()
        }else{
            self.player.play()
        }
        
    }
    
    func updateMeters(){
        if self.audioRecorder.isRecording{
            let recordSecond = floor(self.audioRecorder.currentTime)
            self.recordTime.text = timeStr(second: Int(recordSecond))
        }
        if self.player != nil && self.player.isPlaying{
            let playSecond = floor(self.player.currentTime)
            self.playTime.text = timeStr(second: Int(playSecond))
        }
        self.audioRecorder.updateMeters()
        let normalizedValue = pow(10,self.audioRecorder.averagePower(forChannel: 0)/20)
        waveformView.updateWithLevel(CGFloat(normalizedValue))
    }
    

    @IBAction func recordAction(_ sender: Any) {
        if self.audioRecorder.isRecording{
            let recordSecond = floor(self.audioRecorder.currentTime)
            self.audioRecorder.stop()
            self.recordTime.text = timeStr(second: Int(recordSecond))
            self.recordButton.setImage(UIImage(named:"record"), for: .normal)
        }else{
            if inf.fileExist(filePath: inf.documentsFolder(filename: "\(articleId)")){
                self.showHud(title: "该文章录音已存在", message: "是否覆盖？"){
                    self.doRecord()
                }
            }else{
                doRecord()
            }

        }
    }
    
    func doRecord(){
        self.audioRecorder.record()
        self.recordButton.setImage(UIImage(named:"record_end"), for: .normal)
        self.playTime.text = "00:00"
    }
    
    func showHud(title:String, message:String, handler:@escaping ()->Void = {}){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "是", style: .default, handler: {
            _ in
            handler()
            alertController.dismiss(animated: true, completion: nil)
        })
        let cancelAction = UIAlertAction(title: "否", style: .cancel, handler: {
            _ in
            alertController.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func finishAction(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: "请选择如下操作", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: {
            _ in
            alertController.dismiss(animated: true, completion: nil)
        })
        let uploadAction = UIAlertAction(title: "上传并保存", style: .default, handler:{
            action in
            self.saveAction(action)
        })
        let saveAction = UIAlertAction(title: "保存", style: .default, handler: self.saveAction(_:))
        alertController.addAction(cancelAction)
        alertController.addAction(uploadAction)
        alertController.addAction(saveAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func saveAction(_ alertAction:UIAlertAction){
        
    }
    
    func audioRecorder(_ filePath: URL) -> AVAudioRecorder {
        let recorderSettings: [String : AnyObject] = [
            AVSampleRateKey: 44100.0 as AnyObject,
            AVFormatIDKey: NSNumber(value: kAudioFormatMPEG4AAC),
            AVNumberOfChannelsKey: 2 as AnyObject,
            AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue as AnyObject
        ]
        
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! AVAudioSession.sharedInstance().setActive(true)
        
        let audioRecorder = try! AVAudioRecorder(url: filePath, settings: recorderSettings)
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        
        return audioRecorder
    }
    
    func timeStr(second:Int)->String{
        let minute = second/60
        var timestr = minute>=10 ? "\(minute):" : "0\(minute):"
        timestr = timestr + (second>=10 ? "\(second)" : "0\(second)")
        return timestr
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
