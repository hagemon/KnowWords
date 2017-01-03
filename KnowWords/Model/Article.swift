//
//  Article.swift
//  KnowWords
//
//  Created by 一折 on 2016/12/20.
//  Copyright © 2016年 yizhe. All rights reserved.
//

import UIKit
import ObjectMapper

class Article: NSObject,Mappable {
    var id:Int = -1
    private var idStr:String = "-1"
    var title:String = ""
    var content:String = ""
//    init(id:Int, title:String, content:String) {
//        self.id = id
//        self.title = title
//        self.content = content
//    }
    
    required init(map _:Map) {
        
    }
    
    func mapping(map:Map){
        self.idStr <- map["id"]
        self.id = Int(self.idStr)!
        self.title <- map["title"]
        self.content <- map["content"]
    }
    
}
