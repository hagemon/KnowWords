//
//  UIButtonExtension.swift
//  KnowWords
//
//  Created by 一折 on 2016/12/13.
//  Copyright © 2016年 yizhe. All rights reserved.
//

import UIKit

extension UIButton{
    func setBorder(width:CGFloat = 1, color:UIColor = UIColor.black, cornerRadius:CGFloat = 5){
        self.clipsToBounds = true
        self.layer.borderWidth = width
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = color.cgColor
    }
}
