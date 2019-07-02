//
//  GameViewController.swift
//  Quizzes
//
//  Created by 林雅明 on 6/12/19.
//  Copyright © 2019 林雅明. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            let haveReadIntroduction = UserDefaults.standard.integer(forKey: "endIntroduction")
            if haveReadIntroduction == 1 {
                if let scene = SKScene(fileNamed: "LevelsScene") {
                    scene.scaleMode = .resizeFill
                    view.presentScene(scene)
                }
            }
            else {
                if let scene = SKScene(fileNamed: "CatScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .resizeFill
                    
                    // Present the scene
                    view.presentScene(scene)
                }
            }
                
                view.ignoresSiblingOrder = true
                
                view.showsFPS = true
                view.showsNodeCount = true
            
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
