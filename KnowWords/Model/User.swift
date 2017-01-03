//
//  User.swift
//  KnowWords
//
//  Created by 一折 on 2016/12/21.
//  Copyright © 2016年 yizhe. All rights reserved.
//

import UIKit
import ObjectMapper

var user:User!

class User: NSObject,Mappable {
    var userid:Int=0
    var useridStr = "0"
    var username:String=""
    var nickname:String = ""
    var password:String=""
    var shortnumber:String=""
    var longnumber:String=""
    var blanknumber:String=""
    var recordnumber:String=""
    required init(map _:Map) {

    }
    
    func mapping(map:Map){
        self.useridStr <- map["id"]
        self.userid = Int(self.useridStr)!
        self.username <- map["username"]
        self.nickname <- map["nickname"]
        self.password <- map["password"]
        self.shortnumber <- map["shortnumber"]
        self.longnumber <- map["longnumber"]
        self.blanknumber <- map["blanknumber"]
        self.recordnumber <- map["recordnumber"]
    }
    
    func saveInformation(){
        kwdata.set(self.username, forKey:"username")
        kwdata.set(self.password, forKey: "password")
    }
    
}
