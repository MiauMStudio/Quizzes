//
//  GameOverScene.swift
//  Quizzes
//
//  Created by 林雅明 on 6/13/19.
//  Copyright © 2019 林雅明. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    override func didMove(to view: SKView) {
        let gameOverLabel = SKLabelNode(text: "Good job!")
        addChild(gameOverLabel)
        gameOverLabel.position = CGPoint(x: size.width/2, y: size.height/2)
    }
}
