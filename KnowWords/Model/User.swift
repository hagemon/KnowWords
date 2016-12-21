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
    var username:String=""
    var password:String=""
    var shortnumber:Int=0
    var longnumber:Int=0
    var blanknumber:Int=0
    var recordnumber:Int=0
    required init(map _:Map) {

    }
    
    func mapping(map:Map){
        self.username <- map["username"]
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
