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
    
    var pagesNum: Int = 0 {
        willSet {
            pageLabel.text = "Page: \(newValue)"
        }
    }
    var questionLabel: SKLabelNode?
    var answerLabels: [SKLabelNode] = []
    
    var playableRect: CGRect?
    var playableArea: SKSpriteNode?
    let cropNode: SKCropNode = SKCropNode()
    
    var level: Level
    var levelId: Int
    
    var answeredQuiz = 0
    var pageLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")

    var backButton: SKShapeNode = SKShapeNode()
    var nextButton: SKShapeNode = SKShapeNode()
    var previousButton: SKShapeNode = SKShapeNode()
    
    let quizNode = SKNode()
    
    var startPositionY: CGFloat = 0
    var yDistance: CGFloat = 0
    var yPosition: CGFloat = 0
    
    var labelFrame = SKShapeNode()
    
    init(size: CGSize, levelId: Int) {
        
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
   
        addBackButton()
        addNextButton()
        addPreviousButton()
        
        recursiveQuiz()
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
        quizNode.position = .zero
        cropNode.addChild(quizNode)
    }
    
    func setupScoreLabel() {
        pageLabel.zPosition = 100
        pageLabel.position = CGPoint(
            x: playableRect!.midX,
            y: playableRect!.maxY + view!.frame.height/8 + 30)
        pageLabel.text = "Page: \(pagesNum)"
        pageLabel.name = "scoreLabel"
        addChild(pageLabel)
    }
    
    func addBackButton() {
        
        let backLabel = SKLabelNode(text: "Map")
        backLabel.verticalAlignmentMode = .center
        backLabel.horizontalAlignmentMode = .center
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
    
    func addNextButton() {
        
        let nextLabel = SKLabelNode(text: "→")
        nextLabel.verticalAlignmentMode = .center
        nextLabel.horizontalAlignmentMode = .center
        nextLabel.name = "nextPage"
        let cgSize = nextLabel.frame.size
        nextButton = SKShapeNode(rectOf: CGSize(
            width: cgSize.width + 15,
            height: cgSize.height + 5), cornerRadius: 20)
        nextButton.position = CGPoint(
            x: playableRect!.maxX*3/4,
            y: view!.frame.height/16)
        nextButton.fillColor = .lightGray
        nextButton.strokeColor = .darkGray
        if level.questions[pagesNum].isAnswered {
            nextButton.fillColor = .orange
            nextButton.strokeColor = .red
        }
        nextButton.name = "next"
        addChild(nextButton)
        nextButton.addChild(nextLabel)
        nextButton.isHidden = pagesNum >= level.questions.count - 1
    }
    
    func addPreviousButton() {
        
        let previousLabel = SKLabelNode(text: "←")
        previousLabel.verticalAlignmentMode = .center
        previousLabel.horizontalAlignmentMode = .center
        previousLabel.name = "previous"
        let cgSize = previousLabel.frame.size
        previousButton = SKShapeNode(rectOf: CGSize(
            width: cgSize.width + 15,
            height: cgSize.height + 5), cornerRadius: 20)
        previousButton.position = CGPoint(
            x: playableRect!.maxX/4, y: view!.frame.height/16)
        previousButton.fillColor = .orange
        previousButton.strokeColor = .red
        previousButton.name = "previous"
        addChild(previousButton)
        previousButton.addChild(previousLabel)
        previousButton.isHidden = pagesNum == 0
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
        
        if previousButton.contains(touchPosition) {
            
            pagesNum -= 2
            guard pagesNum >= 0 else { return }
            recursiveQuiz()
        }
        
        if nextButton.contains(touchPosition) {
            if level.questions[pagesNum-1].isAnswered {
                recursiveQuiz()
            } else {
                return
            }
        }
        
        let touchLocation = touch.location(in: cropNode)
        
        guard touchPosition.y > 0 else { return }
        
        switch node.name {
        case "right":
//            animiteAnswer(right: true, node: node, touchPosition: touchLocation)
            rightAnswer(touchPosition: touchPosition, node: node)
        case "wrong":
            animiteAnswer(right: false, node: node, touchPosition: touchLocation)
            wrongAnswer()
        case "next":
            let quiz = level.questions[pagesNum-1]
            quiz.isAnswered = true
            let colorRectAnimation = SKAction.run { [unowned self] in
                self.labelFrame.strokeColor = .green
            }
            let backColor = SKAction.run { [unowned self] in
                self.labelFrame.strokeColor = .white
            }
            
            run(SKAction.sequence([colorRectAnimation, SKAction.wait(forDuration: 0.5), backColor]))
            saveData(quiz: quiz)
            nextButton.fillColor = .orange
            nextButton.strokeColor = .red
        default:
            return
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        let touchPosition = touch.location(in: cropNode)
        
        guard ((playableArea?.frame.contains(touchPosition))!) else { return }

        if startPositionY == 0 {
            startPositionY = touchPosition.y
        }
        
        guard startPositionY != touchPosition.y else { return }

        quizNode.position.y += touchPosition.y - startPositionY
        startPositionY = 0
        
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
        let rect = CGRect(x: 0, y: 0, width: playableRect!.width, height: node.frame.height)
        let colorRect = SKShapeNode(rectOf: rect.size)
        colorRect.position = node.position
        colorRect.position.y = node.position.y + node.frame.height/2
        colorRect.strokeColor = .red
        
        quizNode.addChild(colorRect)
        
        colorRect.run(SKAction.sequence([
            SKAction.fadeOut(withDuration: 1.5),
            SKAction.removeFromParent()]))
    }
    
    func recursiveQuiz() {
        
        quizNode.position = .zero
        
        // Hide the previous or next button at first or end page.
        nextButton.isHidden = pagesNum >= level.questions.count - 1
        previousButton.isHidden = pagesNum == 0
        
        quizNode.removeAllChildren()
        
        guard pagesNum < level.questions.count else {
            return
        }
        
        let quiz = level.questions[pagesNum]
        if quiz.isAnswered {
            nextButton.fillColor = .orange
            nextButton.strokeColor = .red
        } else if !quiz.isAnswered {
            nextButton.fillColor = .lightGray
            nextButton.strokeColor = .darkGray
        }
        
        // set question label
        questionLabel = SKLabelNode(text: quiz.question)
        questionLabel?.verticalAlignmentMode = .top
        questionLabel?.position = CGPoint(x: 0, y: playableRect!.height/2)
        questionLabel?.fontName = "Arial-BoldMT"
        questionLabel?.name = "question"
        questionLabel?.numberOfLines = 0
        questionLabel?.lineBreakMode = .byWordWrapping
        questionLabel?.preferredMaxLayoutWidth = playableArea!.frame.width
        questionLabel?.fontSize = 22
        
        quizNode.addChild(questionLabel!)
        // set answer labels
        let count = quiz.answers.count
        var answers = quiz.answers
        for i in 1...count {
            let answer: String = answers.randomElement()!
            
            let index = answers.firstIndex(of: answer)
            answers.remove(at: index!)
            
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
                labelFrame = SKShapeNode(rectOf: CGSize(
                    width: answerLabel.frame.width + 20,
                    height: answerLabel.frame.height + 10), cornerRadius: 15)
                //labelFrame.strokeColor = .green
                labelFrame.lineWidth = 3
                labelFrame.position = .zero
                labelFrame.position.y = answerLabel.frame.height/2
                labelFrame.name = "next"
                answerLabel.addChild(labelFrame)
            }
            
            answeredQuiz += 1
        }
            pagesNum += 1
    }
    
    func saveData(quiz: Question) {
        let prefixId: String = "level \(level.id) "
        guard let quizIndex = level.questions.firstIndex(of: quiz) else { return }
        let middleId = "question \(quizIndex + 1) "
        let quizAnswered = prefixId + middleId + "is answered"
        UserDefaults.standard.set(quiz.isAnswered, forKey: quizAnswered)
    }
    
    func wrongAnswer() {
        let alert = UIAlertController(title: "答错了😔", message: "不好意思，你回答错了，请回到上一页复习一下基础知识吧。", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "好吧。。。", style: .default, handler: nil))
        self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    func rightAnswer(touchPosition: CGPoint, node: SKNode) {
        let rect = CGRect(x: 0, y: 0, width: playableRect!.width, height: node.frame.height)
        let colorRect = SKShapeNode(rectOf: rect.size)
        colorRect.position = node.position
        colorRect.position.y = node.position.y + node.frame.height/2

        colorRect.strokeColor = .green
        quizNode.addChild(colorRect)
        
        colorRect.run(SKAction.sequence([
            SKAction.fadeOut(withDuration: 1.5),
            SKAction.removeFromParent()]))
        
        let alert = UIAlertController(title: "答对了😊", message: "恭喜你，回答正确！请进入下一关吧！", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "没问题！😉", style: .default, handler: { [unowned self] action in
            let quiz = self.level.questions[self.pagesNum-1]
            quiz.isAnswered = true
            self.nextButton.strokeColor = .red
            self.nextButton.fillColor = .orange
            self.saveData(quiz: quiz)
            if self.pagesNum == self.level.questions.count {
                let scene = GameOverScene(levelNum: self.levelId, size: self.size)
                scene.scaleMode = self.scaleMode
                let reveal = SKTransition.reveal(with: .left, duration: 0.5)
                self.view?.presentScene(scene, transition: reveal)
                if self.levelId < lockLevels.count {
                    lockLevels[self.levelId] = false
                }
            }
            
        }))
        self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
