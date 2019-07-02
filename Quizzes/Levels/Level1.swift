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
    var id: Int { get }
}

struct Level1: Level {
    //static var isLocked: Bool = false
    
    var questions: [Question] = []
    let id = 1
    
    init() {
        let question1 = "小橘：\n别担心，小白，python是一种十分简单易学的语言，甚至可以说，它是最简单的编程语言之一。\n小白：\n什么是编程语言啊？\n小橘：\n编程语言是一种“良构（well-formed）”的语言，它由一系列指令（instructions）组成，用来向计算机“发号施令”。像我们熟知的c语言、c++、Java等，都是编程语言。\n小白：\n我还是不太懂，编程语言与我们平时使用的语言有什么不同吗？\n小橘：\n我们平常使用的自然语言，是用于人与人之间的交流，而编程语言能让我们与机器进行交流。人与人沟通，很容易产生误会，比如我们在说的“编程语言”，有人认为编程语言与“计算机语言”等同，但也有人认为它是“计算机语言”的子类，其他一些语言——比如标记语言，就属于计算机语言，但不属于编程语言。可是计算机是不允许指令有歧义的，这便要求编程语言必须有极严格的语法。\n小白：\n不好意思，标记语言又是什么啊？它与编程语言有什么不同呢？\n小橘：\n网页所使用的HTML语言，就是一种标记语言，它不会被执行（exexuted），不能让计算机执行任何动作。比如我可以使用HTML语言，可以在网页上放置一个写着“1 + 1 = ？”的按钮，但我无法让它给出“= 2”的答案；但如果我使用编程语言JavaScript，只需要“alert(1+1)“,它便能计算出“2”。\n如果你还是不明白，不要着急，在以后的学习过程中，你会慢慢理解这些概念的。前面就是金色果冻的家了，让我们做好准备，去迎接第一个挑战吧！\nPS：点选“准备好了”按钮后，可以通过点选左右箭头按钮进行翻页。这也是由编程语言实现的哦！"
        let answer1_1 = "准备好了！"
//        let answer1_2 = "0"
//        let answer1_3 = "11"
        
        let quiz1 = Question(question: question1, answers: [answer1_1])
        
        questions.append(quiz1)
        
        let question2 = "请问下列哪种语言不属于编程语言？"
        let answer2_1 = "Java"
        let answer2_2 = "HTML"
        let answer2_3 = "JavaScript"
        let answer2_4 = "c++"
        let quiz2 = Question(question: question2, answers: [answer2_1, answer2_2, answer2_3, answer2_4], rightAnswer: answer2_2)
        
        questions.append(quiz2)
        
        let question3 = "2 ^ 3 = ?"
        let answer3_1 = "9"
        let answer3_2 = "8"
        let answer3_3 = "6"
        let answer3_4 = "5"
        let quiz3 = Question(question: question3, answers: [answer3_1, answer3_2, answer3_3, answer3_4], rightAnswer: answer3_2)
        
        questions.append(quiz3)
        
        for i in 1...questions.count {
            questions[i-1].isAnswered = UserDefaults.standard.bool(forKey: "level 1 question \(i) is answered") ?? false
        }
    }
}
