//
//  Information.swift
//  KnowWords
//
//  Created by 一折 on 2016/12/11.
//  Copyright © 2016年 yizhe. All rights reserved.
//

import UIKit

let inf = Information()
let kwdata = UserDefaults.standard

enum ExamType:String {case
    CET4="cet-4",
    CET6="cet-6",
    N1="N1",
    N2="N2",
    N3="N3",
    N4="N4",
    N5="N5"
}


enum TestStatus:Int{case Doing=0, Checking=1}
enum AudioStatus:Int{case Stop=0, Play=1, Pause=2}

class Information: NSObject {
    //colors
    let backColor = UIColor(hex:0xf5f5f5)
    let fontColor = UIColor(hex: 0x2f2f2f)
    let frontColor = UIColor(hex: 0x0F7678)
    let wrongColor = UIColor(hex: 0xDE2A00)
    
    //sizes
    let sWidth = UIScreen.main.bounds.width
    let sHeight = UIScreen.main.bounds.height
    
    //document
    func getUserFolder()->URL{
        let folder = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
        print(folder)
        let url = URL(fileURLWithPath: folder).appendingPathComponent(user.useridStr)
        if !fileExist(filePath: url) {
            print("not exist")
            do{
                let fileManager = FileManager.default
                try fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            }catch{
                print("create fail")
            }

        }
        return url
    }
    func documentsFolder(filename:String) -> URL{
        return getUserFolder().appendingPathComponent("\(filename).caf")
//        let folder = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
//        return (URL(fileURLWithPath: folder).appendingPathComponent(user.useridStr).appendingPathComponent("\(filename).caf"))
    }
    func fileExist(filePath:URL) -> Bool{
        let fileManager = FileManager.default
        return fileManager.fileExists(atPath: filePath.path)
    }
    func getRecords()->[String]{
//        let folder = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
//        let url = URL(fileURLWithPath:folder)
        let url = getUserFolder()
        let fileManager = FileManager.default
        do{
            var files = try fileManager.contentsOfDirectory(atPath: url.path)
            files = files.filter{!$0.hasPrefix(".")}
            return files.map{
                let index = $0.range(of: ".")
                return $0.substring(to: (index?.lowerBound)!)
            }
        }catch{
            return []
        }
    }
    func getRecordInformation(filename:String)->(String,String){
        let index = filename.range(of: "_")
        let id = filename.substring(to: (index?.lowerBound)!)
        let date = filename.substring(from: (index?.upperBound)!)
        return (id,date)
    }
    func clearCache(){
//        let folder = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
//        let url = URL(fileURLWithPath:folder)
        let url = getUserFolder()
        let fileManager = FileManager.default
        do{
            let files = try fileManager.contentsOfDirectory(atPath: url.path)
            try files.forEach{
                name in
                try fileManager.removeItem(at: url.appendingPathComponent(name))
            }
        }catch{
            return
        }
    }
    func removeRecord(filename:String){
//        let folder = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
//        let url = URL(fileURLWithPath: folder).appendingPathComponent("\(filename).caf")
        let url = getUserFolder().appendingPathComponent("\(filename).caf")
        let fileManager = FileManager.default
        do{
            try fileManager.removeItem(at: url)
        }catch{
            return
        }
    }
    
    //time
    func getCurrentTime()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "zh_Hans_CN")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: Date())
    }
    
    func timeStr(second:Int)->String{
        let minute = second/60
        var timestr = minute>=10 ? "\(minute):" : "0\(minute):"
        timestr = timestr + (second>=10 ? "\(second)" : "0\(second)")
        return timestr
    }
    
    //hud
    
    func showAlert(inViewController controller:UIViewController,message:String,confirm:String="确定", cancel:String="", confirmHandler:@escaping ()->Void = {}){
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        if !confirm.isEmpty{
            let confirmAction = UIAlertAction(title: confirm, style: .default, handler: {
                _ in
                alertController.dismiss(animated: true, completion: confirmHandler)
            })
            alertController.addAction(confirmAction)
        }
        if !cancel.isEmpty{
            let cancelAction = UIAlertAction(title: cancel, style: .default, handler: {
                _ in
                alertController.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(cancelAction)
        }
        controller.present(alertController, animated: true, completion: nil)
        return
    }


}
