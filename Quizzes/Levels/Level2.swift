//
//  Level2.swift
//  Quizzes
//
//  Created by 林雅明 on 6/13/19.
//  Copyright © 2019 林雅明. All rights reserved.
//

import Foundation

struct Level2: Level {
    //static var isLocked: Bool = true
    
    var questions: [Question] = []
    let id = 2
    
    init() {
        let question1 = "99 + 1 = ?"
        let answer1_1 = "2"
        let answer1_2 = "100"
        let answer1_3 = "11"
        
        let quiz1 = Question(question: question1, answers: [answer1_1, answer1_2, answer1_3], rightAnswer: answer1_2)
        
        questions.append(quiz1)
        
        let question2 = "2 + 2 ^ 3 = ?"
        let answer2_1 = "7"
        let answer2_2 = "8"
        let answer2_3 = "10"
        let quiz2 = Question(question: question2, answers: [answer2_1, answer2_2, answer2_3], rightAnswer: answer2_3)
        
        questions.append(quiz2)
        
        for i in 1...questions.count {
            questions[i-1].isAnswered = UserDefaults.standard.bool(forKey: "level 2 question \(i) is answered") ?? false
        }
    }
}
