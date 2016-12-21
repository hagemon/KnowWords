//
//  KWNetTool.swift
//  KnowWords
//
//  Created by 一折 on 2016/12/21.
//  Copyright © 2016年 yizhe. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

let netTool = KWNetTool()

class KWNetTool: NSObject {

    private let address = "http://115.28.201.17/knowwords/"
    
    func getUrl(function:String) -> String{
        return self.address.appending(function+".php")
    }
    
    func login(username:String, password:String, handler:@escaping ()->Void){
        Alamofire.request(self.getUrl(function: "login"),
                          method: .post,
                          parameters: ["username":username,"password":password])
            .responseJSON(completionHandler: {
                response in
                let data = response.result.value
                user = Mapper<User>().map(JSONObject: data)
                user.saveInformation()
                handler()
            })
    }
    
}
