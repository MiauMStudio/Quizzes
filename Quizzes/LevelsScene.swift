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
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        
        let levelOneNode = childNode(withName: "levelOne") as! SKSpriteNode
        let levelTwoNode = childNode(withName: "levelTwo") as! SKSpriteNode
        
        levelsNode.append(levelOneNode)
        levelsNode.append(levelTwoNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let touchPosition = touch.location(in: self)
//        if nodes(at: touchPosition).contains(levelOneNode!) {
//            let scene = GameScene(size: size, levelId: 1)
//            scene.scaleMode = scaleMode
//
//            let reveal = SKTransition.crossFade(withDuration: 0.3)
//            view?.presentScene(scene, transition: reveal)
//        }
        
        for (index, levelNode) in levelsNode.enumerated() {
            if levelNode.contains(touchPosition) {
                let scene = GameScene(size: size, levelId: index+1)
                scene.scaleMode = scaleMode
                
                let reveal = SKTransition.crossFade(withDuration: 0.3)
                view?.presentScene(scene, transition: reveal)
            }
        }
    }
}
