//
//  Level1.swift
//  Quizzes
//
//  Created by 林雅明 on 6/12/19.
//  Copyright © 2019 林雅明. All rights reserved.
//

import Foundation

protocol Level {
    //static var isLocked: Bool { get set }
    var questions: [Question] { get set }
}

struct Level1: Level {
    //static var isLocked: Bool = false
    
    var questions: [Question] = []
    
    init() {
        let question1 = "1 + 1 = ?"
        let answer1_1 = "2"
//        let answer1_2 = "0"
//        let answer1_3 = "11"
        
        let quiz1 = Question(question: question1, answers: [answer1_1], rightAnswer: answer1_1)
        
        questions.append(quiz1)
        
        let question2 = " iOS 7新引入的Sprite Kit类库算是给iOS游戏开发者带来一些福音吧，由于 ..... 首先是坐标系，游戏开发中必须要注意的，如果一个游戏开发者连坐标系都 ...... 渲染出来， cropNode自动在其子node上以maskNode的边框裁剪子node的 .2014年3月5日 - 为你的游戏添加粒子系统很简单，XCode中new file时找到resource，可以看到SpriteKit Particle File这一项，XCode自带粒子系统文件而且可以直接 ..."
        let answer2_1 = "7"
        let answer2_2 = "8"
        let answer2_3 = "2222"
        let quiz2 = Question(question: question2, answers: [answer2_1, answer2_2, answer2_3], rightAnswer: answer2_2)
        
        questions.append(quiz2)
        
        let question3 = "2 ^ 3 = ?"
        let answer3_1 = "9"
        let answer3_2 = "8"
        let answer3_3 = "6"
        let answer3_4 = "5"
        let quiz3 = Question(question: question3, answers: [answer3_1, answer3_2, answer3_3, answer3_4], rightAnswer: answer3_2)
        
        questions.append(quiz3)
    }
}
