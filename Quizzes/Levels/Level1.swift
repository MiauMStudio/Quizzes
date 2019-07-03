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
        let question1 = "小橘：\n别担心，小白，Python是一种十分简单易学的语言，甚至可以说，它是最简单的编程语言之一。\n小白：\n什么是编程语言啊？\n小橘：\n编程语言是一种“良构（well-formed）”的语言，它由一系列指令（instructions）组成，用来向计算机“发号施令”。像我们熟知的c语言、c++、Java等，都是编程语言。\n小白：\n我还是不太懂，编程语言与我们平时使用的语言有什么不同吗？\n小橘：\n我们平常使用的自然语言，是用于人与人之间的交流，而编程语言能让我们与机器进行交流。人与人沟通，很容易产生误会，比如我们在说的“编程语言”，有人认为编程语言与“计算机语言”等同，但也有人认为它是“计算机语言”的子类，其他一些语言——比如标记语言，就属于计算机语言，但不属于编程语言。可是计算机是不允许指令有歧义的，这便要求编程语言必须有极严格的语法。\n小白：\n不好意思，标记语言又是什么啊？它与编程语言有什么不同呢？\n小橘：\n网页所使用的HTML语言，就是一种标记语言，它不会被执行（exexuted），不能让计算机执行任何动作。比如我可以使用HTML语言，可以在网页上放置一个写着“1 + 1 = ？”的按钮，但我无法让它给出“= 2”的答案；但如果我使用编程语言JavaScript，只需要“alert(1+1)“,它便能计算出“2”。\n如果你还是不明白，不要着急，在以后的学习过程中，你会慢慢理解这些概念的。前面就是金色果冻的家了，让我们做好准备，去迎接第一个挑战吧！\nPS：点选“准备好了”按钮后，可以通过点选左右箭头按钮进行翻页。这个功能也是由编程语言实现的哦！"
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
        
        let question3 = "小白：\n原来有这么多编程语言啊。那为什么我们要学习Python呢？\n小橘：\nPython本身有许多优势，比如它简单易学、功能强大、语法简洁、支持动态输入、完全免费开源。它是解释型语言，Python程序不需要被编译成二进制代码，非常易于移植；它有着丰富的库（libraries）……\n小白：\n啊……好复杂啊，听不懂🥺。\n小橘：\n不要担心，你很快就能充分体会到Python的优势了。现在，让我们看几个具体的例子，感受下Python的魅力吧！\n首先，请跟我来到Python之家\nhttps://www.python.org\n哦，不，不要用手机，你需要一台电脑来更好地练习。\n小白：好吧，现在我进入了Python主页。唉，为什么全是英文啊。\n小橘：\n没关系，我会一步步教你。可是作为一个程序员，英语不合格可不行哦。\n看到菜单栏下面的代码框了吗？\n小白：\n看到了！它的右上角还有一个黄色按钮，写着“>_”。\n小橘L：\n非常棒，现在，把鼠标移到黄色按钮上。\n小白：\nEmmm，它显示“Launch Interactive Shell”。\n小橘：\n点击黄色按钮，你就进入了Python的在线控制台（console）。你能看到光标所在的地方，前方有个“>>>”符号，这叫做解释器提示符（Interpreter Prompt），你可以在其后输入内容。\n现在，试着输入\nprint(\"Hello World\")\n小白：\n它打印出了“Hello World”！\n小橘：\n恭喜你，完成了第一个Python程序！现在，你做好准备接受第二个挑战了吗？\n"
        let answer3_1 = "接受挑战！"
        let quiz3 = Question(question: question3, answers: [answer3_1])
        
        questions.append(quiz3)
        
        let question4 = "2 ^ 3 = ?"
        let answer4_1 = "97777"
        let answer4_2 = "8"
        let answer4_3 = "6"
        let answer4_4 = "5"
        let quiz4 = Question(question: question4, answers: [answer4_1, answer4_2, answer4_3, answer4_4], rightAnswer: answer4_2)
        questions.append(quiz4)
        
        for i in 1...questions.count {
            questions[i-1].isAnswered = UserDefaults.standard.bool(forKey: "level 1 question \(i) is answered") ?? false
        }
    }
}
