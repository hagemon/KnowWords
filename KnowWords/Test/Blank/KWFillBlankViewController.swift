//
//  KWFillBlankViewController.swift
//  KWFillBlankTextView
//
//  Created by 一折 on 16/7/31.
//  Copyright © 2016年 yizhe. All rights reserved.
//

public protocol KWFillBlankDelegate {
    func fillBlankView(fillBlankView:UIView, didSelectedBlankRange range:NSRange)->Void
}

import UIKit
import AVFoundation

class KWFillBlankViewController: UIViewController,UITextViewDelegate,UITextFieldDelegate,KWInputBarDelegate {


    @IBOutlet var textView: KWFillBlankTextView!
    @IBOutlet var inputBar: KWInputBar!
    @IBOutlet var quitButton: UIButton!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var waveButton: UIButton!
    
    var player:AVPlayer!
    
    var audioStatus:AudioStatus = .Stop
    var delegate:KWFillBlankDelegate!
    private var selectedRange:NSRange!
    private var currentTitle = 0
    private let titleData = inf.blankTests as [[String]]
    private var testStatus:TestStatus = .Doing
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.inputBar.inputField.delegate = self
        self.inputBar.delegate = self
        self.listenToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(KWFillBlankViewController.keyBoardResign))
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(KWFillBlankViewController.keyBoardResign))
        self.textView.initialConfigure(text: titleData[currentTitle][0])
        swipe.direction = .down
        self.textView.addGestureRecognizer(tap)
        self.textView.addGestureRecognizer(swipe)
        self.quitButton.setBorder(width: 1, color: inf.fontColor, cornerRadius: 5)
        self.nextButton.setBorder(width: 0, color: inf.frontColor, cornerRadius: 5)
        self.waveButton.setBorder(width: 1, color: inf.fontColor, cornerRadius: self.waveButton.frame.size.width/2)
        self.waveButton.alpha = 0
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func quitAction(_ sender: Any) {
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
    @IBAction func playAction(_ sender: Any) {
        if self.audioStatus == .Play{
            self.pauseCurrentAudio()
        }else{
            self.playRemoteAudio(urlString: inf.exampleURL[self.currentTitle%2])
        }
        self.waveAnimate()
    }
    @IBAction func nextAction(_ sender: Any) {
        
        guard !self.textView.contentTexts().contains("") else {
            let alertController = UIAlertController(title: nil, message: "请完成所有题目", preferredStyle: .alert)
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
            
            self.textView.isEditable = false
            self.textView.isSelectable = false
            self.textView.replaceBlankWith(strings: [String](self.titleData[currentTitle].dropFirst(1)))
            
        }else{
            let cnt = self.titleData.count
            self.currentTitle = (self.currentTitle+1)%cnt
            self.textView.initialConfigure(text: titleData[self.currentTitle][0])
            self.player = nil
            self.audioStatus = .Stop
        }
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

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        if URL.absoluteString == "blank" {
            self.inputBar.inputField.becomeFirstResponder()
            self.selectedRange = characterRange
            self.textView.highlightTextInRange(range: characterRange)
            self.textView.updateRange(range: characterRange)
            self.inputBar.inputField.text = self.textView.selectedText()
            if self.delegate != nil {
                self.delegate.fillBlankView(fillBlankView: self.view, didSelectedBlankRange: characterRange)
            }
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.selectedRange == nil {
            let characterRange = self.textView.firstBlank()
            self.selectedRange = characterRange
            self.textView.highlightTextInRange(range: characterRange)
            self.textView.updateRange(range: characterRange)
            self.inputBar.inputField.text = self.textView.selectedText()
            if self.delegate != nil {
                self.delegate.fillBlankView(fillBlankView: self.view, didSelectedBlankRange: characterRange)
            }

        }
    }

    
    func keyBoardResign(){
        self.inputBar.inputField.resignFirstResponder()
    }
    
    func listenToKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeInputBarPosition(notif:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    func changeInputBarPosition(notif:NSNotification){
        let userinfo = notif.userInfo
        var start = (userinfo![UIKeyboardFrameBeginUserInfoKey] as AnyObject).description
        var end = (userinfo![UIKeyboardFrameEndUserInfoKey] as AnyObject).description
        if ((start?.hasPrefix("NSRect")) != nil) {
            start = start?.replacingOccurrences(of: "NSRect", with: "CGRect")
        }
        if ((end?.hasPrefix("NSRect")) != nil) {
            end = end?.replacingOccurrences(of: "NSRect", with: "CGRect")
        }
        let startRect = CGRectFromString(start!)
        let endRect = CGRectFromString(end!)
        let changeY = startRect.origin.y - endRect.origin.y
        let startY = startRect.origin.y
        let endY = endRect.origin.y
        let isUp = startY>endY ? 1 : -1
        
        var frame = self.inputBar.frame
        frame.origin.y = frame.origin.y - changeY + CGFloat(54*isUp)
        UIView.animate(withDuration: 0.25, animations: {
            self.inputBar.frame = frame
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.doneBlank()
        return true
    }
    
    func doneBlank() {
        if selectedRange == nil {
            return
        }
        let text = self.inputBar.inputField.text
        if text == nil {
            return
        }
        if text?.length != 0 {
            self.textView.changeText(text: self.inputBar.inputField.text!, inRange: self.selectedRange)
        }
        else{
            self.textView.updateRange(range: self.selectedRange)
        }
        selectedRange = self.textView.selectedBlankRange()
        self.textView.highlightTextInRange(range: selectedRange)
        self.inputBar.inputField.text = self.textView.nextText()
    }
    
}
