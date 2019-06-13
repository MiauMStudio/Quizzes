//
//  Level1.swift
//  Quizzes
//
//  Created by 林雅明 on 6/12/19.
//  Copyright © 2019 林雅明. All rights reserved.
//

import Foundation

class Level1 {
    
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
    }
}
