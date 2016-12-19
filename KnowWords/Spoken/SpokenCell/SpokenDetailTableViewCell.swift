//
//  SpokenDetailTableViewCell.swift
//  KnowWords
//
//  Created by 一折 on 2016/12/17.
//  Copyright © 2016年 yizhe. All rights reserved.
//


import UIKit

class SpokenDetailTableViewCell: UITableViewCell {

    @IBOutlet var avatar: UIImageView!
    @IBOutlet var bubble: UIImageView!
    @IBOutlet var goodButton: UIButton!
    @IBOutlet var nickname: UILabel!
    var isGood = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bubble.animationImages = [UIImage(named:"bubble1")!,UIImage(named:"bubble2")!,UIImage(named:"bubble3")!]
        bubble.animationDuration = 1.5
        goodButton.setImage(UIImage(named:"good_highlight"), for: .selected)
        self.backgroundColor = inf.backColor
        self.selectionStyle = .none
        // Initialization code
    }
    
    func goodAction(){
        self.goodButton.setTitleColor(inf.frontColor, for: .normal)
        self.goodButton.setImage(UIImage(named:"good_highlight"), for: .normal)
    }
    func ungoodAction(){
        self.goodButton.setTitleColor(inf.fontColor, for: .normal)
        self.goodButton.setImage(UIImage(named:"good"), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
