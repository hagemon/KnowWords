//
//  KWLongTestViewController.swift
//  KnowWords
//
//  Created by 一折 on 2016/12/13.
//  Copyright © 2016年 yizhe. All rights reserved.
//

import UIKit

class KWLongTestViewController: KWShortTestViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var answers = [0,0,0,0]
    var titleData:NSArray = inf.exampleLongTests as NSArray
    var currentTitle = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func nextAction(_ sender: Any) {
        guard !self.answers.contains(0) else {
            let alertController = UIAlertController(title: nil, message: "请完成所有题目", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "确定", style: .default, handler: {
                _ in
                alertController.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        self.testStatus = TestStatus(rawValue: (self.testStatus.rawValue+1) % 2)!
        if self.testStatus == .Checking{
            self.tableView.reloadData()
            self.tableView.allowsSelection = false
            self.collectionView.allowsSelection = false
        }else{
            self.titleData = inf.exampleLongTests as NSArray // change data
            self.answers = [0,0,0,0]
            self.currentTitle = 0
            self.tableView.reloadData()
            self.collectionView.reloadData()
            self.tableView.allowsSelection = true
            self.collectionView.allowsSelection = true
        }
        
    }
    
    func reloadTitle(){
        self.tableView.reloadData()
        let indexPath = IndexPath(row: answers[currentTitle], section: 0)
        self.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
    }
    
    // MARK: - Tableview datasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if testStatus == .Doing{
            return 5
        }
        return (titleData.lastObject as! [String]).count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        var cellid = ""
        
        if self.testStatus == .Doing{
            if index == 0 {
                cellid = "TitleCell"
            }else{
                cellid = "SelectionCell"
            }

        }else{
            cellid = "AnswerCell"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid)!
        let contentLabel = cell.viewWithTag(1) as! UILabel
        if cellid == "AnswerCell"{
            contentLabel.text = (titleData.lastObject as! [String])[index]
        }else{
            contentLabel.text = (titleData[currentTitle]as![String])[index]
        }
        
        if cellid == "SelectionCell" {
            
            if answers[currentTitle] == index{
                contentLabel.textColor = inf.frontColor
                let checkMark = cell.viewWithTag(2) as!UIImageView
                checkMark.image = UIImage(named: "radio")
            }
            else{
                contentLabel.textColor = inf.fontColor
                let checkMark = cell.viewWithTag(2) as!UIImageView
                checkMark.image = UIImage(named: "unRadio")
            }

        }
        if cellid == "AnswerCell"{
            
            let sans = inf.answerIndex[(titleData[currentTitle]as![String]).last!]
            
            if answers[indexPath.row] == sans{
                contentLabel.textColor = inf.frontColor
            }else{
                contentLabel.textColor = inf.wrongColor
            }
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row>0 && indexPath.row<5 else {
            return
        }
        let cell = tableView.cellForRow(at: indexPath)!
        (cell.viewWithTag(1) as!UILabel).textColor = inf.frontColor
        (cell.viewWithTag(2) as!UIImageView).image = UIImage(named: "radio")
        self.selectedIndex = indexPath.row
        self.answers[self.currentTitle] = indexPath.row
        self.collectionView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        guard indexPath.row>0 && indexPath.row<5 else {
            return indexPath
        }
        let cell = tableView.cellForRow(at: indexPath)!
        (cell.viewWithTag(1) as!UILabel).textColor = inf.fontColor
        (cell.viewWithTag(2) as!UIImageView).image = UIImage(named: "unRadio")
        return indexPath
    }

    
    // MARK: - Collection datasource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TitleCell", for: indexPath)
        let titleNumber = cell.viewWithTag(1) as!UILabel
        let backView = cell.viewWithTag(2)
        let number = indexPath.row+1
        
        titleNumber.text = "\(number)"
        
        if answers[number-1] == 0{
            backView?.setBorder(width: 1, color: inf.fontColor, cornerRadius: (backView?.frame.width)!/2)
            backView?.backgroundColor = inf.backColor
            titleNumber.textColor = inf.fontColor
        }else{
            backView?.setBorder(width: 0, color: inf.frontColor, cornerRadius: (backView?.frame.width)!/2)
            backView?.backgroundColor = inf.frontColor
            titleNumber.textColor = UIColor.white
        }
        
        return cell
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleData.count-1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.currentTitle = indexPath.row
        self.reloadTitle()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellCount = titleData.count-1
        let totalCellWidth = 40 * cellCount
        let totalSpacingWidth = 20 * (cellCount - 1)
        
        let leftInset = (collectionView.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2;
        let rightInset = leftInset
        
        return UIEdgeInsetsMake(0, leftInset, 0, rightInset)
    }

}
