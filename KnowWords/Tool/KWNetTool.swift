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
        let target = self.address.appending(function+".php")
        return target
    }

    func login(username:String, password:String, success:@escaping ()->Void, fail:@escaping (_ message:String)->Void){
        Alamofire.request(self.getUrl(function: "login"),
                          method: .post,
                          parameters: ["username":username,"password":password])
            .responseJSON(completionHandler: {
                response in
                let data = response.result.value
                if data == nil { fail("网络错误"); return }
                let status = (data as! NSDictionary)["status"] as!String
                if status == "fail"{
                    fail("用户名或密码错误")
                    return
                }else{
                    user = Mapper<User>().map(JSONObject: data)
                    user.saveInformation()
                    success()
                }

            })
    }
    
    func getShortTitle(level:String,success:@escaping ()->Void, fail:@escaping (_ message:String)->Void){
        let levelPra = level.lowercased().replacingOccurrences(of: "-", with: "")
        Alamofire.request(self.getUrl(function: "getShort"),
                          method: .post,
                          parameters: ["id":user.userid,"level":levelPra])
            .responseJSON(completionHandler: {
                response in
                let data = response.result.value
                guard data != nil else{
                    fail("获取题目失败")
                    return
                }
                titleTool.shortTitles = data as! [[String]]
                success()
            })
    }
    
    func getLongTitle(level:String,success:@escaping ()->Void, fail:@escaping (_ message:String)->Void){
        let levelPra = level.lowercased().replacingOccurrences(of: "-", with: "")
        Alamofire.request(self.getUrl(function: "getLong"),
                          method: .post,
                          parameters: ["id":user.userid,"level":levelPra])
            .responseJSON(completionHandler: {
                response in
                let data = response.result.value
                guard data != nil else{
                    fail("获取题目失败")
                    return
                }
                titleTool.longTitles = data as! [[String]]
                success()
            })
    }
    
    func getBlank(level:String,success:@escaping ()->Void, fail:@escaping (_ message:String)->Void){
        let levelPra = level.lowercased().replacingOccurrences(of: "-", with: "")
        Alamofire.request(self.getUrl(function: "getBlank"),
                          method: .post,
                          parameters: ["id":user.userid,"level":levelPra])
            .responseJSON(completionHandler: {
                response in
                let data = response.result.value
                guard data != nil else{
                    fail("获取题目失败")
                    return
                }
                titleTool.blankTitles = data as! [[String]]
                success()
            })
    }
    
    func getArticle(success:@escaping ()->Void, fail:@escaping (_ message:String)->Void){
        Alamofire.request(self.getUrl(function: "getArticle"),
                          method: .post,
                          parameters: ["id":user.userid])
            .responseJSON(completionHandler: {
                response in
                let data = response.result.value
                guard data != nil else{
                    fail("获取文章列表失败")
                    return
                }
                titleTool.setArticles(data: data as! [Any])
                success()
            })
    }
    
    func getArticles(with ids:[Int], success:@escaping (_ results:[Article])->Void, fail:@escaping (_ message:String)->Void){
        Alamofire.request(self.getUrl(function: "getArticleById"),
                          method: .post,
                          parameters: ["ids":ids])
            .responseJSON(completionHandler: {
                response in
                let data = response.result.value
                guard data != nil else{
                    fail("获取列表失败")
                    return
                }
                
                var articles:[Article] = []
                for d in (data as! [Any]){
                    let a = Mapper<Article>().map(JSONObject: d)
                    articles.append(a!)
                }
                success(articles)
            })
    }
    
    func upload(filename:String, articleId:Int, success:@escaping ()->Void, fail:@escaping (_ message:String)->Void){
        let fileUrl = inf.documentsFolder(filename: filename)
        var name = filename.replacingOccurrences(of: " ", with: "-")
        name = name.replacingOccurrences(of: ":", with: "-")
        let parameters = [
            "filename":name,
            "articleid":"\(articleId)",
            "userid":"\(user.userid)"
        ]
        Alamofire.upload(
            multipartFormData: {
                multipartFormData in
                let data = NSData(contentsOf: fileUrl) as!Data
                multipartFormData.append(data, withName: "record", fileName: name+".caf", mimeType: "audio/x-caf")
            
                for (key,value) in parameters{
                    multipartFormData.append(value.data(using: String.Encoding.utf8)! , withName: key)
                }
            
            },
            to: self.getUrl(function: "uploadRecord"),
            encodingCompletion: { encodingResult in
                switch encodingResult{
                case .success(let upload,_,_):
                    upload.responseJSON{ response in
                        let data = response.result.value
                        guard data != nil else{
                            fail("上传失败");return
                        }
                        let res = data as! NSDictionary
                        if res["status"]as!String == "fail"{
                            fail("上传失败");return
                        }
                        success()
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
        })
    }
    
    func getComment(withArticleId id:Int, success:@escaping (_ results:[Comment])->Void, fail:@escaping (_ message:String)->Void){
        Alamofire.request(self.getUrl(function: "getComment"),
                          method: .post,
                          parameters: ["articleid":id])
            .responseJSON(completionHandler: {
                response in
                let data = response.result.value
                guard data != nil else{
                    fail("获取该文章录音失败")
                    return
                }
                
                var comments:[Comment] = []
                for d in (data as! [Any]){
                    let a = Mapper<Comment>().map(JSONObject: d)
                    comments.append(a!)
                }
                success(comments)
            })
    }


    
}
