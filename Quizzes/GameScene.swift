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
    
    var playableRect: CGRect?
    var playableArea: SKSpriteNode?
    let cropNode: SKCropNode = SKCropNode()
    
    var answeredQuestions: [Question] = []
    
    var level: Level
    var levelId: Int
    
    var answeredQuiz = 0
    var score = 0
    var scoreLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")

    var backButton: SKShapeNode = SKShapeNode()
    
    let quizNode = SKNode()
    
    var startPositionY: CGFloat = 0
    
    init(size: CGSize, levelId: Int) {
//        playableRect = CGRect(x: 20, y: (view?.frame.size.height)!/8 + 50, width: view!.frame.size.width - 40, height: view!.frame.size.height*3/4)
        
        self.levelId = levelId
        switch levelId {
        case 1:
            level = Level1()
        case 2:
            level = Level2()
        case 3:
            level = Level3()
        case 4:
            level = Level4()
        case 5:
            level = Level5()
        case 6:
            level = Level6()
        default:
            fatalError("Level doesn't exist.")
        }
        
        super.init(size: size)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        setupCropNode(view: view)
        setupScoreLabel()
        recursiveQuiz()
        addBackButton()
    }
    
    func setupCropNode(view: SKView) {
        playableRect = CGRect(x: 0, y: 0, width: view.frame.width - 20, height: view.frame.height*3/4)
        let playableSize = CGSize(
            width: view.frame.width - 20,
            height: view.frame.height*3/4)
        backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        
        playableArea = SKSpriteNode(color: .white, size: playableSize)
        playableArea?.position = .zero
        playableArea?.alpha = 1
        cropNode.maskNode = playableArea
        addChild(cropNode)
        cropNode.position = view.center
        //
        //        let bg = SKSpriteNode(imageNamed: "BG")
        //        bg.zPosition = -1
        //        cropNode.addChild(bg)
        quizNode.position = .zero
        cropNode.addChild(quizNode)
    }
    
    func setupScoreLabel() {
        scoreLabel.zPosition = 100
        scoreLabel.position = CGPoint(
            x: playableRect!.midX,
            y: playableRect!.maxY + view!.frame.height/8 + 30)
        scoreLabel.text = "Score: \(score)"
        scoreLabel.name = "scoreLabel"
        addChild(scoreLabel)
    }
    
    func addBackButton() {
        
        let backLabel = SKLabelNode(text: "Back to main menu")
        backLabel.verticalAlignmentMode = .center
        backLabel.name = "back"
        let cgSize = backLabel.frame.size
        backButton = SKShapeNode(rectOf: CGSize(
            width: cgSize.width + 15,
            height: cgSize.height + 5), cornerRadius: 20)
        backButton.position = CGPoint(
            x: playableRect!.midX,
            y: view!.frame.height/16)
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
        
        if backButton.contains(touchPosition) {
            if let scene = SKScene(fileNamed: "LevelsScene") {
                let reveal = SKTransition.crossFade(withDuration: 0.3)
                view?.presentScene(scene, transition: reveal)
            }
        }
        
        let touchLocation = touch.location(in: cropNode)
        
        switch node.name {
        case "right":
            score += 10
            animiteAnswer(right: true, node: node, touchPosition: touchLocation)
        case "wrong":
            animiteAnswer(right: false, node: node, touchPosition: touchLocation)
//        case "back":
//            if let scene = SKScene(fileNamed: "LevelsScene") {
//                let reveal = SKTransition.crossFade(withDuration: 0.3)
//                view?.presentScene(scene, transition: reveal)
//                print(questionLabel?.text)
//            }
        case "next":
            run(SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.run(recursiveQuiz)]))
        default:
            return
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(quizNode.calculateAccumulatedFrame().height)
        guard let touch = touches.first else {
            return
        }
        let touchPosition = touch.location(in: playableArea!)
        
//        guard quizNode.position.y - quizNode.calculateAccumulatedFrame().height/2 < 30 else { return }
//        guard quizNode.position.y + quizNode.calculateAccumulatedFrame().height/2 > 30 else {
//            return
        //        }
        
        guard (playableArea?.contains(touchPosition))! else { return }
        
        if startPositionY == 0 {
            startPositionY = touchPosition.y
        }
        
        guard startPositionY != touchPosition.y else { return }
        let yDistance = touchPosition.y - startPositionY
        
        quizNode.position.y += yDistance
        
        let upperLimit = max(0, quizNode.calculateAccumulatedFrame().height - playableArea!.frame.height)
        let yRange = SKRange(
            lowerLimit: 0,
            upperLimit: upperLimit)
        let yConstraint = SKConstraint.positionY(yRange)
        quizNode.constraints = [yConstraint]
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        startPositionY = 0
    }
    
    func animiteAnswer(right: Bool, node: SKNode, touchPosition: CGPoint) {
        scoreLabel.text = "Score: \(score)"
        let rect = CGRect(x: 0, y: 0, width: playableRect!.width, height: node.frame.height)
        let colorRect = SKShapeNode(rectOf: rect.size)
        colorRect.position = node.position
        colorRect.position.y = node.position.y + node.frame.height/2
        if right {
            colorRect.strokeColor = .green
        } else {
            colorRect.strokeColor = .red
        }
        quizNode.addChild(colorRect)
        let action = SKAction.run(recursiveQuiz)
        colorRect.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.5),
            SKAction.removeFromParent(), action]))
    }
    
    func recursiveQuiz() {
//        print("playable area height: \(playableArea?.frame.height)")
//        if quizNode.calculateAccumulatedFrame().height <= (playableArea?.frame.height)! {
//            quizNode.position = CGPoint(x: 0,
//                                        y: -(playableArea?.frame.height)!/2)
//
//        } else {
//            quizNode.position.y = -quizNode.calculateAccumulatedFrame().height/2
//        }
        
        quizNode.position = .zero
        
        if level.questions.count == 0 {
            if levelId < lockLevels.count {
                lockLevels[levelId] = false
            }
            run(SKAction.sequence([SKAction.wait(forDuration: 0.3),
                                   SKAction.run { [unowned self] in
                                    let scene = GameOverScene(score: self.score, size: self.size)
                                    scene.scaleMode = self.scaleMode
                                    let transition = SKTransition.crossFade(withDuration: 0.3)
                                    self.view?.presentScene(scene, transition: transition)}
                ]))
        }
        
        quizNode.removeAllChildren()
        
        guard level.questions.count > 0 else { return }
        
        let quiz = level.questions.removeFirst()
        
        if quiz.answers.count == 1 {
            scoreLabel.isHidden = true
        } else { scoreLabel.isHidden = false }
        
        // set question label
        questionLabel = SKLabelNode(text: quiz.question)
        questionLabel?.verticalAlignmentMode = .top
        questionLabel?.position = CGPoint(x: 0, y: playableRect!.height/2)
        questionLabel?.fontName = "Arial-BoldMT"
        questionLabel?.name = "question"
        questionLabel?.numberOfLines = 0
        questionLabel?.lineBreakMode = .byWordWrapping
        questionLabel?.preferredMaxLayoutWidth = playableArea!.frame.width
        
        quizNode.addChild(questionLabel!)
        // set answer labels
        let count = quiz.answers.count
        
        for i in 1...count {
            let answer: String = quiz.answers.randomElement()!
            
            let index = quiz.answers.firstIndex(of: answer)
            quiz.answers.remove(at: index!)
            
            let answerLabel = SKLabelNode(text: answer)
            answerLabel.position = CGPoint(
                x: 0,
                y: ((questionLabel?.position.y)! - (questionLabel?.frame.height)!) - CGFloat(i * 60))
            answerLabel.name = "answer"
            quizNode.addChild(answerLabel)
            
            if answer == quiz.rigntAnswer {
                answerLabel.name = "right"
            } else if quiz.rigntAnswer != nil {
                answerLabel.name = "wrong"
            } else if quiz.rigntAnswer == nil {
                let labelFrame = SKShapeNode(rectOf: CGSize(
                    width: answerLabel.frame.width + 20,
                    height: answerLabel.frame.height + 10), cornerRadius: 15)
                labelFrame.strokeColor = .green
                labelFrame.lineWidth = 3
                labelFrame.position = .zero
                labelFrame.position.y = answerLabel.frame.height/2
                labelFrame.name = "next"
                answerLabel.addChild(labelFrame)
            }
            
            answeredQuiz += 1
        }
        
    }
}
