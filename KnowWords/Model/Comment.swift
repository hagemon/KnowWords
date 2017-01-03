//
//  Comment.swift
//  KnowWords
//
//  Created by 一折 on 2017/1/3.
//  Copyright © 2017年 yizhe. All rights reserved.
//

import UIKit
import ObjectMapper

class Comment: NSObject,Mappable {
    var nickname = ""
    var likeNumber = ""
    var url = ""
    
    required init(map _:Map) {
        
    }
    
    func mapping(map:Map){
        self.nickname <- map["nickname"]
        self.likeNumber <- map["like_number"]
        self.url <- map["url"]
    }

}
