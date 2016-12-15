//
//  Information.swift
//  KnowWords
//
//  Created by 一折 on 2016/12/11.
//  Copyright © 2016年 yizhe. All rights reserved.
//

import UIKit

let inf = Information()

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

class Information: NSObject {
    //colors
    let backColor = UIColor(hex:0xf5f5f5)
    let fontColor = UIColor(hex: 0x2f2f2f)
    let frontColor = UIColor(hex: 0x0F7678)
    let wrongColor = UIColor(hex: 0xDE2A00)
    
    //sizes
    let sWidth = UIScreen.main.bounds.width
    let sHeight = UIScreen.main.bounds.height
    
    //example test
    let exampleTest = [
        "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu.",
        "A. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
        "B. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
        "C. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ",
        "D. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. ",
        "解析：正确答案 B. Dolor in reprehenderit in voluptate sunt in culpa qui officia deserunt.",
    ]
    
    let answerIndex = ["A":1,"B":2,"C":3,"D":4]
    
    let exampleTests = [
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
    
    let exampleLongTests = [
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
    
    let blankTests = [
        ["Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore _____ aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco _____ nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat _____ pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt www.google.com anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.","das","zuca","gut"],
        ["Lorem ipsum dolor sit er elit lamet, consectetaur cillium _____ pecu, sed do eiusmod tempor incididunt ut labore et dolore das aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco zuca nisi ut aliquip ex ea commodo _____. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat gut pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt www.google.com anim id est laborum. Nam _____ te conscient to factor tum poen legum odioque civiuda.","adipisicing","consequat","liber"]
    ]
}
