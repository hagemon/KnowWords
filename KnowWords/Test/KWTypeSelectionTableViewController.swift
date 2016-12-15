//
//  KWTypeSelectionTableViewController.swift
//  KnowWords
//
//  Created by 一折 on 2016/12/12.
//  Copyright © 2016年 yizhe. All rights reserved.
//

import UIKit

class KWTypeSelectionTableViewController: UITableViewController {

    var examType:String = ExamType.CET4.rawValue
    
    let dataArr = [
        ["name":"短对话","introduce":"从一段对话中根据问题选择正确选项"],
        ["name":"长对话","introduce":"从一组对话中根据问题选择正确选项"],
        ["name":"填空","introduce":"根据录音在空白处填写单词"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor=UIColor.clear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCell", for: indexPath)
        let data = dataArr[indexPath.row] as NSDictionary
        
        let nameLabel = tableView.viewWithTag(1) as! UILabel
        nameLabel.text = data["name"] as?String
        let introLabel = tableView.viewWithTag(2) as! UILabel
        introLabel.text = data["introduce"] as?String

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var viewid = ""
        switch indexPath.row {
        case 0:
            viewid = "KWShortTestViewController"
        case 1:
            viewid = "KWLongTestViewController"
        case 2:
            viewid = "KWBlankTestViewController"
        default:
            return
        }
        let destinationViewController = self.storyboard?.instantiateViewController(withIdentifier: viewid)
        self.present(destinationViewController!, animated: true, completion: nil)
    }
 
}
