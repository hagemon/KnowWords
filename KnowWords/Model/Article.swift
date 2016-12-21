//
//  Article.swift
//  KnowWords
//
//  Created by 一折 on 2016/12/20.
//  Copyright © 2016年 yizhe. All rights reserved.
//

import UIKit

class Article: NSObject {
    var id:Int
    var title:String
    var content:String
    init(id:Int, title:String, content:String) {
        self.id = id
        self.title = title
        self.content = content
    }
}
