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
    
    let score: Int
    
    init(score: Int, size: CGSize) {
        self.score = score
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        let gameOverLabel = SKLabelNode(text: """
You got \(score) score!
      Good job!
""")
        gameOverLabel.numberOfLines = 0
        gameOverLabel.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(gameOverLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let _ = touches.first else {
            return
        }
        
        if let scene = SKScene(fileNamed: "LevelsScene") {
            let reveal = SKTransition.crossFade(withDuration: 0.3)
            view?.presentScene(scene, transition: reveal)
        }
    }
}
