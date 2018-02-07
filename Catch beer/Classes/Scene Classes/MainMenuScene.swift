//
//  MainMenuScene.swift
//  Catch beer
//
//  Created by Xuan Tu on 1/29/18.
//  Copyright © 2018 TnTechs. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    
    var bestScoreLabel: SKLabelNode?
    var coinCollectLabel: SKLabelNode?
    
    override func didMove(to view: SKView) {
        bestScoreLabel = childNode(withName: "BestScoreLabelMenu") as? SKLabelNode!
        bestScoreLabel?.text = String(GameViewController.bestScore)
        
        coinCollectLabel = childNode(withName: "CoinCollectLabel") as? SKLabelNode!
        coinCollectLabel?.text = String(GameViewController.coinCollect)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if atPoint(location).name == "Start" {
                if let scene = GameplaySceneClass(fileNamed: "GameplayScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view!.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: TimeInterval(2)))
                }
            }
        }
    }
}
