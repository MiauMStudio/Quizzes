//
//  LevelsScene.swift
//  Quizzes
//
//  Created by 林雅明 on 6/13/19.
//  Copyright © 2019 林雅明. All rights reserved.
//

import Foundation
import SpriteKit

class LevelsScene: SKScene {
    
    var levelsNode: [SKSpriteNode] = []
    var startTouchYPosition: CGFloat = 0
    
    override func didMove(to view: SKView) {
        backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
        let levelOneNode = childNode(withName: "levelOne") as! SKSpriteNode
        let levelTwoNode = childNode(withName: "levelTwo") as! SKSpriteNode
        let levelThreeNode = childNode(withName: "levelThree") as! SKSpriteNode
        
        levelsNode.append(levelOneNode)
        levelsNode.append(levelTwoNode)
        levelsNode.append(levelThreeNode)
        
        let yPosition = (levelsNode.first?.position.y)! - 70 + view.frame.height/2
        camera?.position.y = yPosition
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        
        let touchPosition = touch.location(in: self)
        
        for (index, levelNode) in levelsNode.enumerated() {
            if levelNode.contains(touchPosition) {
                let scene = GameScene(size: size, levelId: index+1)
                scene.scaleMode = scaleMode
                
                let reveal = SKTransition.crossFade(withDuration: 0.3)
                view?.presentScene(scene, transition: reveal)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let touchPosition = touch.location(in: self)
        
        if startTouchYPosition == 0 {
            startTouchYPosition = touchPosition.y
        }
        
        guard let camera = camera else {
            return
        }
        
        guard startTouchYPosition != touchPosition.y else { return }
        
        camera.position.y += -touchPosition.y + startTouchYPosition
        
        let upperLimit = max((levelsNode.last?.position.y)! + 70 - (view?.bounds.height)!/2, 0)
        
        let yRange = SKRange(
            lowerLimit: (levelsNode.first?.position.y)! - 70 + (view?.frame.height)!/2,
            upperLimit: upperLimit)
        
        let zeroRange = SKRange(constantValue: 0)
        let edgeConstraint = SKConstraint.positionX(zeroRange, y: yRange)
        
        camera.constraints = [edgeConstraint]
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        startTouchYPosition = 0
    }
}
