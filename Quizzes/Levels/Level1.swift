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
        let answer1_2 = "0"
        let answer1_3 = "11"
        
        let quiz1 = Question(question: question1, answers: [answer1_1, answer1_2, answer1_3], rightAnswer: answer1_1)
        
        questions.append(quiz1)
        
        let question2 = "2 + 2 * 3 = ?"
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
