//
//  Question.swift
//  Quizzes
//
//  Created by 林雅明 on 6/12/19.
//  Copyright © 2019 林雅明. All rights reserved.
//

import Foundation

class Question: Hashable {
    
    static func == (lhs: Question, rhs: Question) -> Bool {
        return lhs.question == rhs.question
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(question)
    }
    
    var question: String
    var answers: Set<String>
    var rigntAnswer: String?
    
    init(question: String, answers: Set<String>, rightAnswer: String? = nil) {
        self.question = question
        self.answers = answers
        self.rigntAnswer = rightAnswer
    }
}
