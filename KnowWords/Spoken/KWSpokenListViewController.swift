//
//  KWSpokenListViewController.swift
//  KnowWords
//
//  Created by 一折 on 2016/12/16.
//  Copyright © 2016年 yizhe. All rights reserved.
//

import UIKit

class KWSpokenListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var articles:[Article] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = inf.backColor
        netTool.getArticle(success: {
            self.articles = titleTool.getArticles()
            self.tableView.reloadData()
        }, fail: {
            message in
            inf.showAlert(inViewController: self, message: message, confirm: "确定")
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    // MARK: - Table view datasource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpokenCell")!
        let imageView = cell.viewWithTag(1) as! UIImageView
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        let imageName = "\(indexPath.row%5+1).png"
        imageView.image = UIImage(named: imageName)
        let titleLabel = cell.viewWithTag(2) as! UILabel
        titleLabel.text = self.articles[indexPath.row].title
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let desViewController = self.storyboard?.instantiateViewController(withIdentifier: "KWSpokenDetailTableViewController") as! KWSpokenDetailTableViewController
        desViewController.text = self.articles[indexPath.row].content
        desViewController.articleId = self.articles[indexPath.row].id
        self.navigationController?.pushViewController(desViewController, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
