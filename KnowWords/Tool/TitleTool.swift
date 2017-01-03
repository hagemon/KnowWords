//
//  TitleTool.swift
//  KnowWords
//
//  Created by 一折 on 2017/1/1.
//  Copyright © 2017年 yizhe. All rights reserved.
//

import UIKit
import ObjectMapper

let titleTool = TitleTool()

class TitleTool: NSObject {
    
    var shortTitles:[[String]] = []
    var longTitles:[[String]] = []
    var blankTitles:[[String]] = []
//    var articles:[[String]] = []
    var articles:[Article] = []
    
    let answerIndex = ["A":1,"B":2,"C":3,"D":4]
    
    func getShortTitles()->[[String]]{
        return self.shortTitles.isEmpty ? self.exampleTests : self.shortTitles
    }
    
    func getLongTitles()->NSArray{
        return (self.longTitles.isEmpty ? self.exampleLongTests : self.longTitles) as NSArray
    }
    
    func getBlankTitles()->[[String]]{
        return self.blankTitles.isEmpty ? self.blankTests : self.blankTitles
    }
    
    func getArticles()->[Article]{
        return self.articles
    }
    
    func setArticles(data:[Any]){
        for d in data{
            let article = Mapper<Article>().map(JSONObject: d)
            self.articles.append(article!)
        }
    }

    
    //default data
    private let exampleTests = [
        [
            "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu.",
            "A. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
            "B. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            "C. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ",
            "D. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. ",
            "解析：正确答案 B. Dolor in reprehenderit in voluptate sunt in culpa qui officia deserunt.",
            "B"
        ],
        [
            "Nam liber te conscient to factor tum poen legum odioque civiuda.",
            "A. Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit ",
            "B. Nam libero tempore, cum soluta nobis est eligendi optio, cumque nihil impedit.",
            "C. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, ut et voluptates repudiandae sint et molestiae non recusandae. ",
            "D. Sed ut perspiciatis, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium. ",
            "解析：正确答案 C. Nemo enim ipsam voluptatem, quia voluptas sit, aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos, qui ratione voluptatem sequi nesciunt, neque porro quisquam est, qui dolorem ipsum.",
            "C"
        ]
        
    ]

    private let exampleLongTests = [
        [
            "1. Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu.",
            "A. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
            "B. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            "C. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ",
            "D. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. ",
            "B"
        ],
        [
            "2. Nam liber te conscient to factor tum poen legum odioque civiuda.",
            "A. Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit ",
            "B. Nam libero tempore, cum soluta nobis est eligendi optio, cumque nihil impedit.",
            "C. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, ut et voluptates repudiandae sint et molestiae non recusandae. ",
            "D. Sed ut perspiciatis, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium. ",
            "C"
        ],
        [
            "3. Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu.",
            "A. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
            "B. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            "C. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ",
            "D. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. ",
            "B"
        ],
        [
            "4. Nam liber te conscient to factor tum poen legum odioque civiuda.",
            "A. Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit ",
            "B. Nam libero tempore, cum soluta nobis est eligendi optio, cumque nihil impedit.",
            "C. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet, ut et voluptates repudiandae sint et molestiae non recusandae. ",
            "D. Sed ut perspiciatis, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium. ",
            "C"
        ],
        [
            "解析：正确答案 B. Dolor in reprehenderit in voluptate sunt in culpa qui officia deserunt.",
            "解析：正确答案 C. Nemo enim ipsam voluptatem, quia voluptas sit, aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos, qui ratione voluptatem sequi nesciunt, neque porro quisquam est, qui dolorem ipsum.",
            "解析：正确答案 B. Dolor in reprehenderit in voluptate sunt in culpa qui officia deserunt.",
            "解析：正确答案 C. Nemo enim ipsam voluptatem, quia voluptas sit, aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos, qui ratione voluptatem sequi nesciunt, neque porro quisquam est, qui dolorem ipsum."
        ]
    ]
    
    private let blankTests = [
        ["Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore _____ aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco _____ nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat _____ pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt www.google.com anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.","das","zuca","gut"],
        ["Lorem ipsum dolor sit er elit lamet, consectetaur cillium _____ pecu, sed do eiusmod tempor incididunt ut labore et dolore das aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco zuca nisi ut aliquip ex ea commodo _____. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat gut pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt www.google.com anim id est laborum. Nam _____ te conscient to factor tum poen legum odioque civiuda.","adipisicing","consequat","liber"]
    ]
    
//    private let articleTests = [
//        ["-1","Example Article Title","Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."],
//        ["-1","Example Article Title","Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."]
//    ]
    
    let exampleURL = ["http://xia2.kekenet.com/Sound/2016/04/cet62015123s2_37345925xm.mp3","http://xia2.kekenet.com/Sound/2016/03/cet62015122s1_4108904WrJ.mp3"]

}
