//
//  KWInputBar.swift
//  KWFillBlankTextView
//
//  Created by 一折 on 16/7/31.
//  Copyright © 2016年 yizhe. All rights reserved.
//

protocol KWInputBarDelegate {
    func doneBlank()
}

import UIKit

class KWInputBar: UIView {
    
    var inputField:UITextField!
    //var doneButton:UIButton!
    var delegate:KWInputBarDelegate!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        let textFrame = CGRect(x: self.frame.origin.x+10, y: self.frame.origin.y+5, width: self.frame.width-20, height: self.frame.height-10)
        self.inputField = UITextField(frame: textFrame)
        self.addSubview(inputField)
//        let buttonFrame = CGRect(x: textFrame.width+textFrame.origin.x+5, y: textFrame.origin.y, width: 60, height: textFrame.height)
//        self.doneButton = UIButton(frame:buttonFrame)
//        self.addSubview(doneButton)
        setInputProperty()
        //setButtonProperty()
    }
    
    func setInputProperty(){
        self.inputField.borderStyle = .roundedRect
        self.inputField.autocapitalizationType = .none
        self.inputField.keyboardType = .asciiCapable
        self.inputField.returnKeyType = .next
        self.inputField.spellCheckingType = .no
        self.inputField.autocorrectionType = .no
    }
    
//    func setButtonProperty(){
//        self.doneButton.backgroundColor = inf.backColor
//        self.doneButton.setBorder(width: 3, color: inf.frontColor, cornerRadius: 10)
//        self.doneButton.setTitleColor(inf.frontColor, for: .normal)
//        self.doneButton.setTitle("Next", for: .normal)
//        self.doneButton.isUserInteractionEnabled = true
//        self.doneButton.addTarget(nil, action: #selector(getter: self.next), for: .touchUpInside)
//    }
    
//    func next(){
//        if self.delegate != nil{
//            self.delegate.doneBlank()
//        }
//    }
}
