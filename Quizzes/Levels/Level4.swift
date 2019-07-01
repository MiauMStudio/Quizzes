//
//  Level4.swift
//  Quizzes
//
//  Created by 林雅明 on 6/16/19.
//  Copyright © 2019 林雅明. All rights reserved.
//

import Foundation

struct Level4: Level {
    //static var isLocked: Bool = true
    
    var questions: [Question] = []
    let id = 4
    
    init() {
        let question1 = "5 + 5 = ?"
        let answer1_1 = "2"
        let answer1_2 = "100"
        let answer1_3 = "11"
        let answer1_4 = "10"
        
        let quiz1 = Question(question: question1, answers: [answer1_1, answer1_2, answer1_3, answer1_4], rightAnswer: answer1_4)
        
        questions.append(quiz1)
        
        let question2 = "2 + 2 * 3 + 2= ?"
        let answer2_1 = "7"
        let answer2_2 = "2232"
        let answer2_3 = "10"
        let quiz2 = Question(question: question2, answers: [answer2_1, answer2_2, answer2_3], rightAnswer: answer2_3)
        
        questions.append(quiz2)
        
        for i in 1...questions.count {
            questions[i-1].isAnswered = UserDefaults.standard.bool(forKey: "level 4 question \(i) is answered") ?? false
        }
    }
}
