//
//  GameScene.swift
//  Quizzes
//
//  Created by 林雅明 on 6/12/19.
//  Copyright © 2019 林雅明. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var questionLabel: SKLabelNode?
    var answerLabels: [SKLabelNode] = []
    let playableRect: CGRect
    
    var answeredQuestions: [Question] = []
    
    let level = Level1()
    
    override init(size: CGSize) {
        playableRect = CGRect(x: 20, y: size.height/8, width: size.width - 40, height: size.height*3/4)
        super.init(size: size)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        
        recursiveQuiz()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let touchPosition = touch.location(in: self)
        
        let node = nodes(at: touchPosition)[0]
        if node.name == "right" {
            recursiveQuiz()
        }
        
        if node.name == "wrong" {
            recursiveQuiz()
        }
    }
    
    func recursiveQuiz() {
        if level.questions.count == 0 {
            let scene = GameOverScene(size: size)
            scene.scaleMode = scaleMode
            let transition = SKTransition.crossFade(withDuration: 0.3)
            view?.presentScene(scene, transition: transition)
        }
        removeAllChildren()
        
        if let quiz = level.questions.popLast() {
            // set question label
            questionLabel = SKLabelNode(text: quiz.question)
            questionLabel?.verticalAlignmentMode = .top
            questionLabel?.position = CGPoint(x: size.width/2, y: playableRect.maxY)
            addChild(questionLabel!)
            
            // set answer labels
            let count = quiz.answers.count
            
            for i in 1...count {
                let answer: String = quiz.answers.randomElement()!
                
                let index = quiz.answers.firstIndex(of: answer)
                quiz.answers.remove(at: index!)
                
                let answerLabel = SKLabelNode(text: answer)
                answerLabel.position = CGPoint(
                    x: size.width/2,
                    y: playableRect.maxY/CGFloat(count+1)*CGFloat(i))
                addChild(answerLabel)
                
                if answer == quiz.rigntAnswer {
                    answerLabel.name = "right"
                } else {
                    answerLabel.name = "wrong"
                }
            }
        }
    }
}
