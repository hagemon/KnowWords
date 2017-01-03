//
//  KWMeTableViewController.swift
//  KnowWords
//
//  Created by 一折 on 2016/12/19.
//  Copyright © 2016年 yizhe. All rights reserved.
//

import UIKit

class KWMeTableViewController: UITableViewController {
    
    
    let cellText = [["我的录音","我的历程","设置"],["清除缓存","退出登录"]]
    let icons = [["myrecord","mytrip","setting"],["clear","logout"]]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundView = nil
        self.tableView.backgroundColor = inf.backColor
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 3
        case 2:
            return 2
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0{return 150}
            else{return 80}
        case 1:
            return 44
        default:
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellid = ""
        switch indexPath.section {
        case 0:
            if indexPath.row == 0{cellid="headCell"}
            else{cellid="nameCell"}
        case 1:
            cellid = "basicCell"
        default:
            cellid = "basicCell"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid)!
        
        if cellid == "headCell"{
            let headView = cell.viewWithTag(1) as!UIImageView
            headView.image = UIImage(named: "avatar")
        }else if cellid == "nameCell"{
            let usernameLabel = cell.viewWithTag(1) as!UILabel
            usernameLabel.text = user.username
            let nicknameLabel = cell.viewWithTag(2) as!UILabel
            nicknameLabel.text = user.nickname
        }else{
            let index = indexPath.section-1
            cell.textLabel?.text = self.cellText[index][indexPath.row]
            cell.textLabel?.textColor = inf.fontColor
            cell.imageView?.image = UIImage(named: self.icons[index][indexPath.row])
        }
        cell.backgroundColor = inf.backColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section>0 else {
            return
        }
        if indexPath.section == 1{
            
            switch indexPath.row {
            case 0:
                self.pushViewController(withIdentifier: "KWMyrecordTableViewController")
            case 1:
                self.pushViewController(withIdentifier: "KWMytripTableViewController")
            default:
                return
            }
            
        }else{
            switch indexPath.row {
            case 0:
                return
            case 1:
                self.dismiss(animated: true, completion: nil)
            default:
                return
            }
        }
        
    }
    func pushViewController(withIdentifier:String){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: withIdentifier)
        self.navigationController?.pushViewController(controller!, animated: true)
    }

    
}
