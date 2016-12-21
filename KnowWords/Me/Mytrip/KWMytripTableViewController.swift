//
//  KWMytripTableViewController.swift
//  KnowWords
//
//  Created by 一折 on 2016/12/20.
//  Copyright © 2016年 yizhe. All rights reserved.
//

import UIKit

class KWMytripTableViewController: UITableViewController {
    
    let texts = ["短对话听力","长对话听力","填空题","口语录音"]
    let detailTexts = [user.shortnumber,user.longnumber,user.blanknumber,user.recordnumber]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor=UIColor.clear
        self.tableView.backgroundColor = inf.backColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellid = ""
        if indexPath.section == 0{
            cellid = "headCell"
        }else{
            cellid = "basicCell"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid)!
        if cellid == "basicCell"{
            cell.textLabel?.text = texts[indexPath.row]
            cell.textLabel?.textColor = inf.frontColor
            cell.detailTextLabel?.text = "\(detailTexts[indexPath.row])"
            cell.detailTextLabel?.textColor = inf.fontColor
        }
        cell.backgroundColor = inf.backColor
        return cell
    }

    
}
