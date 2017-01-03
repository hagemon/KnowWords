//
//  KWMyrecordListTableViewController.swift
//  KnowWords
//
//  Created by 一折 on 2016/12/20.
//  Copyright © 2016年 yizhe. All rights reserved.
//

import UIKit

class KWMyrecordListTableViewController: UITableViewController {

    var localRecords:[(String,String)] = []
    var articles:NSMutableDictionary = [:]
    var files:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor=UIColor.clear
        self.getLocalRecords()
        self.tableView.backgroundColor = inf.backColor
    }
    
    func getLocalRecords(){
        self.files = inf.getRecords()
        for filename in files{
            self.localRecords.append(inf.getRecordInformation(filename: filename))
        }
        self.localRecords = self.localRecords.filter{
            (id,_) in
            Int(id)!>0
        }
        self.getReomoteArticles()
    }
    
    func getReomoteArticles(){
        var ids:[Int] = []
        localRecords.forEach({
            (id,_) in
            ids.append(Int(id)!)
        })
        ids = ids.filter{$0>0}
        // request with ids
//        let exampleArticle = Article(id: -1, title: "Example Article Title", content: "Example Article Content")
//        articles.setValue(exampleArticle, forKey: "-1")
        netTool.getArticles(with: ids, success: {
            articles in
            self.articles.removeAllObjects()
            for a in articles{
                self.articles.setValue(a, forKey: "\(a.id)")
            }
            if self.articles.count == 0{
                inf.showAlert(inViewController: self, message: "尚未有本地录音",confirm: "确定")
            }
            self.tableView.reloadData()
        }, fail: {
            message in
            inf.showAlert(inViewController: self, message: message, confirm: "确定")
        })
        
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
        return self.articles.count>0 ? self.localRecords.count : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell")!
        let titleLabel = cell.viewWithTag(1) as!UILabel
        let dateLabel = cell.viewWithTag(2) as!UILabel
        let articleId = localRecords[indexPath.row].0
        let date = localRecords[indexPath.row].1
        let article = articles[articleId] as!Article

        
        titleLabel.text = article.title
        dateLabel.text = date
        
        cell.backgroundColor = inf.backColor
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "KWMyrecordDetailViewController") as!KWMyrecordDetailViewController
        controller.articleId = Int(localRecords[indexPath.row].0)!
        controller.filename = self.files[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }


}
