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
    
    var level: Level
    
    var answeredQuiz = 0
    var score = 0
    var scoreLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
    
    init(size: CGSize, levelId: Int) {
        playableRect = CGRect(x: 20, y: size.height/8, width: size.width - 40, height: size.height*3/4)
        
        switch levelId {
        case 1:
            level = Level1()
        case 2:
            level = Level2()
        default:
            fatalError("Level doesn't exist.")
        }
        
        super.init(size: size)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        print(size)
        backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        
        setupScoreLabel()
        recursiveQuiz()
        addBackButton()
    }
    
    func setupScoreLabel() {
        scoreLabel.zPosition = 100
        scoreLabel.position = CGPoint(
            x: playableRect.midX,
            y: playableRect.maxY + 30)
        scoreLabel.text = "Score: \(score)"
        scoreLabel.name = "scoreLabel"
        addChild(scoreLabel)
    }
    
    func addBackButton() {
        let backLabel = SKLabelNode(text: "Back to main menu")
        backLabel.verticalAlignmentMode = .center
        backLabel.name = "back"
        let cgSize = backLabel.frame.size
        let backButton = SKShapeNode(rectOf: CGSize(
            width: cgSize.width + 15,
            height: cgSize.height + 5), cornerRadius: 20)
        backButton.position = CGPoint(x: playableRect.midX,
                                      y: playableRect.minY)
        backButton.fillColor = .orange
        backButton.strokeColor = .red
        backButton.name = "back"
        addChild(backButton)
        backButton.addChild(backLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let touchPosition = touch.location(in: self)
        guard let node = nodes(at: touchPosition).first else { return }
        
//        if node.name == "right" {
//            recursiveQuiz()
//            score += 10
//            scoreLabel.text = "Score: \(score)"
//        }
//
//        if node.name == "wrong" {
//            recursiveQuiz()
//            scoreLabel.text = "Score: \(score)"
//        }
        
        switch node.name {
        case "right":
            recursiveQuiz()
            score += 10
            scoreLabel.text = "Score: \(score)"
        case "wrong":
            recursiveQuiz()
            scoreLabel.text = "Score: \(score)"
        case "back":
            if let scene = SKScene(fileNamed: "LevelsScene") {
                let reveal = SKTransition.crossFade(withDuration: 0.3)
                view?.presentScene(scene, transition: reveal)
            }
        default:
            return
        }
    }
    
    func recursiveQuiz() {
        
        if level.questions.count == 0 {
            run(SKAction.sequence([SKAction.wait(forDuration: 0.3),
                                   SKAction.run { [unowned self] in
                                    let scene = GameOverScene(score: self.score, size: self.size)
                                    scene.scaleMode = self.scaleMode
                                    let transition = SKTransition.crossFade(withDuration: 0.3)
                                    self.view?.presentScene(scene, transition: transition)}
                ]))
        }
        
        for child in children {
            if child.name != "scoreLabel" && child.name != "back" {
                child.removeFromParent()
            }
        }
        guard level.questions.count > 0 else { return }
        
        if let quiz = level.questions.popLast() {
            // set question label
            questionLabel = SKLabelNode(text: quiz.question)
            questionLabel?.verticalAlignmentMode = .top
            questionLabel?.position = CGPoint(x: size.width/2, y: playableRect.maxY)
            questionLabel?.fontName = "Arial-BoldMT"
            questionLabel?.name = "question"
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
                answerLabel.name = "answer"
                addChild(answerLabel)
                
                if answer == quiz.rigntAnswer {
                    answerLabel.name = "right"
                } else {
                    answerLabel.name = "wrong"
                }
                
                answeredQuiz += 1
            }
        }
    }
}
