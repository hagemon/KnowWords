//
//  KWTestViewController.swift
//  KnowWords
//
//  Created by 一折 on 2016/12/11.
//  Copyright © 2016年 yizhe. All rights reserved.
//

import UIKit

class KWTestViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate {

    @IBOutlet var headView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var nameTop: NSLayoutConstraint!
    var originNameTop:CGFloat!
    
    private class Exam{
        var name:String
        var introduce:String
        var image:String
        init(name:String,introduce:String,image:String){
            self.name = name
            self.introduce = introduce
            self.image = image
        }
    }
    
    let dataArray = NSArray(objects:
        Exam(name: ExamType.CET4.rawValue, introduce: "中国大学生英语四级考试", image: "cet.png"),
        Exam(name: ExamType.CET6.rawValue, introduce: "中国大学生英语六级考试", image: "cet.png"),
        Exam(name: ExamType.N5.rawValue, introduce: "日本语能力测试五级", image: "ntest.png"),
        Exam(name: ExamType.N4.rawValue, introduce: "日本语能力测试四级", image: "ntest.png"),
        Exam(name: ExamType.N3.rawValue, introduce: "日本语能力测试三级", image: "ntest.png"),
        Exam(name: ExamType.N2.rawValue, introduce: "日本语能力测试二级", image: "ntest.png"),
        Exam(name: ExamType.N1.rawValue, introduce: "日本语能力测试一级", image: "ntest.png")
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func initialConfig(){
        //properties
        self.view.backgroundColor = inf.backColor
        self.tableView.backgroundColor = inf.backColor
        self.headView.backgroundColor = inf.backColor
        //values
        self.originNameTop = nameTop.constant
    }
    
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gradeCell", for: indexPath)
        let exam = dataArray[indexPath.row] as! Exam
        
        cell.backgroundColor = inf.backColor
        let imageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = UIImage(named: exam.image)
        
        let nameLabel = cell.viewWithTag(2) as! UILabel
        nameLabel.text = exam.name
        
        let introLabel = cell.viewWithTag(3) as! UILabel
        introLabel.text = exam.introduce
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectionView = self.storyboard?.instantiateViewController(withIdentifier: "KWTypeSelectionTableViewController") as!KWTypeSelectionTableViewController
        let exam = dataArray[indexPath.row] as!Exam
        selectionView.examType = exam.name
        self.navigationController?.pushViewController(selectionView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    // MARK: - Head view change
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY<=0{
            nameTop.constant = self.originNameTop-offsetY/2
        }
    }

}
