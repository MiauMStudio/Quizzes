//
//  CatScene.swift
//  Quizzes
//
//  Created by 林雅明 on 6/30/19.
//  Copyright © 2019 林雅明. All rights reserved.
//

import UIKit
import SpriteKit

class CatScene: SKScene {
    
    var white: SKSpriteNode?
    var orange: SKSpriteNode?
    var dialog: SKLabelNode?
    var page = 1
    var pass: SKLabelNode?
    
    override func didMove(to view: SKView) {
        pass = childNode(withName: "pass") as! SKLabelNode
        firstPage()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch page {
        case 2:
            secondPage()
        case 3:
            thirdPage()
        case 4:
            fourthPage()
        case 5:
            fifthPage()
        case 6:
            sixthPage()
        case 7:
            seventhPage()
        case 8:
            eighthPage()
        case 9:
            endPage()
        case 10:
            endIntroduction()
        default:
            return
        }
        
        guard let touch = touches.first else { return }
        let touchPosition = touch.location(in: self)
        if (pass?.contains(touchPosition))! {
            endIntroduction()
        }
    }
    
    func firstPage() {
        white = childNode(withName: "white") as! SKSpriteNode
        orange = childNode(withName: "orange") as! SKSpriteNode
        dialog = childNode(withName: "dialog") as! SKLabelNode
        
        white?.alpha = 1
        orange?.alpha = 0.5
        
        dialog?.verticalAlignmentMode = .bottom
        dialog?.horizontalAlignmentMode = .left
        
        dialog?.numberOfLines = 0
        dialog?.preferredMaxLayoutWidth = 240
        dialog?.lineBreakMode = .byWordWrapping
        dialog?.fontSize = 18
        dialog?.fontColor = .purple
        dialog?.text = "小白：\n我是小白，我在Python森林里迷路了。树精爷爷，您能告诉我森林出口在哪里吗？"
        
        page += 1
    }
    
    func secondPage() {
        white?.alpha = 0.5
        orange?.alpha = 1
        dialog?.text = "树精：\n孩子，抱歉，我只是个守林人，我从没有踏入过森林深处。不过，森林里居住着许多Python果冻，它们会告诉你正确的路。"
        page += 1
    }
    
    func thirdPage() {
        dialog?.text = "树精：\n要想得到它们的指引，你需要回答出它们的问题。通常，像它们的名字一样，它们会问你Python知识。"
        page += 1
    }
    
    func fourthPage() {
        white?.alpha = 1
        orange?.alpha = 0.5
        dialog?.text = "小白：\n谢谢树精爷爷，可是，我完全不懂Python啊。"
        page += 1
    }
    func fifthPage() {
        white?.alpha = 0.5
        orange?.alpha = 1
        orange?.texture = SKTexture(imageNamed: "white_cat1")
        orange?.xScale = 0.024
        orange?.yScale = 0.031
        orange?.color = .orange
        orange?.colorBlendFactor = 1
        dialog?.text = "小橘：\n你好，我是小橘,我很乐意教你Python知识，但是果冻们只接受你自己来回答问题。"
        page += 1
    }
    
    func sixthPage() {
        white?.alpha = 1
        orange?.alpha = 0.5
        dialog?.text = "小白：\n真的吗？太感谢你们了！"
        page += 1
    }
    
    func seventhPage()  {
        white?.alpha = 0.5
        orange?.colorBlendFactor = 0
        orange?.xScale = -0.025
        orange?.yScale = 0.025
        orange?.alpha = 1
        orange?.texture = SKTexture(imageNamed: "treeSprite")
        dialog?.text = "树精：\n当你解不出难题时，可以来问我，这些小果冻们还是很给老头儿面子的。"
        page += 1
    }
    
    func eighthPage() {
        dialog?.text = "树精：\n顺着这条路往前走，便能到达金色果冻的家。勇敢地去吧，我的孩子。"
        page += 1
    }
    
    func endPage() {
        white?.alpha = 1
        orange?.alpha = 1
        orange?.texture = SKTexture(imageNamed: "white_cat1")
        orange?.xScale = 0.024
        orange?.yScale = 0.031
        orange?.color = .orange
        orange?.colorBlendFactor = 1
        dialog?.text = "小白，小橘：\n爷爷再见，我们马上出发了！"
        page += 1
    }
    
    func endIntroduction() {
        if let scene = SKScene(fileNamed: "LevelsScene") {
            scene.scaleMode = .resizeFill
            let reveal = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
            view?.presentScene(scene, transition: reveal)
        }
        UserDefaults.standard.set(1, forKey: "endIntroduction")
    }
    
}
