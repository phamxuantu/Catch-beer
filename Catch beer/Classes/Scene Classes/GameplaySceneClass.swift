//
//  GameplaySceneClass.swift
//  Catch beer
//
//  Created by Xuan Tu on 1/29/18.
//  Copyright © 2018 TnTechs. All rights reserved.
//

import SpriteKit

class GameplaySceneClass: SKScene, SKPhysicsContactDelegate {
    
    private var player: Player?
    private var center = CGFloat()
    private var canMove = false, moveLeft = false
    private var itemController = ItemController()
    private var scoreLabel: SKLabelNode?
    private var lifeLabel: SKLabelNode?
    private var score = 0
    private var life = 3
    var firstBody = SKPhysicsBody()
    var secondBody = SKPhysicsBody()
    var alertController: UIAlertController?
    var endRandom: Int?
    
    override func didMove(to view: SKView) {
        initializeGame()
    }
    
    override func update(_ currentTime: TimeInterval) {
        managePlayer()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if location.x > center {
                moveLeft = false
            } else {
                moveLeft = true
            }
        }
        canMove = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false
    }
    
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
//        if life > 0 {
            if firstBody.node?.name == "Player" && secondBody.node?.name == "beer" {
                score += 1
                scoreLabel?.text = String(score)
                secondBody.node?.removeFromParent()
            }
//            else {
//                life -= 1
//            }
//        } else {
//            firstBody.node?.removeFromParent()
//            secondBody.node?.removeFromParent()
//
//            Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(GameplaySceneClass.restartGame), userInfo: nil, repeats: false)
//        }
    }
    
    private func initializeGame(){
        physicsWorld.contactDelegate = self
        player = childNode(withName: "Player") as? Player!
        player?.initializePlayer()
        
        scoreLabel = childNode(withName: "ScoreLabel") as? SKLabelNode!
        scoreLabel?.text = "0"
        
        lifeLabel = childNode(withName: "LifeLabel") as? SKLabelNode!
        lifeLabel?.text = "3"
        
        center = self.frame.size.width / self.frame.size.height
        //        for _ in 1...2 {
        //            Timer.scheduledTimer(timeInterval: TimeInterval(itemController.randomBetweenNumbers(firstNum: 1, secondNum: 2)), target: self, selector: #selector(GameplaySceneClass.spawnItems), userInfo: nil, repeats: true)
        //        }
//        if score < 15 {
//            endRandom = Int(itemController.randomBetweenNumbers(firstNum: 1, secondNum: 3))
//        } else if score >= 15 {
//            endRandom = Int(itemController.randomBetweenNumbers(firstNum: 2, secondNum: 3))
//        }
//        for _ in 1...endRandom! {
            if life > 0 {
                Timer.scheduledTimer(timeInterval: TimeInterval(itemController.randomBetweenNumbers(firstNum: 1, secondNum: 2)), target: self, selector: #selector(GameplaySceneClass.spawnItems), userInfo: nil, repeats: true)
            }
            Timer.scheduledTimer(timeInterval: TimeInterval(0), target: self, selector: #selector(GameplaySceneClass.removeItems), userInfo: nil, repeats: true)
//        }
    }
    
    private func managePlayer(){
        if canMove {
            player?.move(left: moveLeft)
        }
    }
    
    @objc func spawnItems(){
        if life <= 0 {
            firstBody.node?.removeFromParent()
            secondBody.node?.removeFromParent()
            
            
            alertController = UIAlertController(title: "Game over", message: "Your score: \(score)", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Play again", style: .default) { (action) in
                self.life = 3
                Timer.scheduledTimer(timeInterval: TimeInterval(0), target: self, selector: #selector(GameplaySceneClass.restartGame), userInfo: nil, repeats: false)
            }
            let exitAction = UIAlertAction(title: "Exit", style: .default) { (action) in
                if let scene = MainMenuScene(fileNamed: "MainMenu") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    self.view!.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: TimeInterval(0)))
                }
            }
            
            alertController?.addAction(restartAction)
            alertController?.addAction(exitAction)
            view?.window?.rootViewController?.present(alertController!, animated: true, completion: nil)

        } else {
//            if score < 15 {
//                endRandom = Int(itemController.randomBetweenNumbers(firstNum: 1, secondNum: 3))
//            } else if score >= 15 {
//                endRandom = Int(itemController.randomBetweenNumbers(firstNum: 2, secondNum: 3))
//            }
//            for _ in 1...endRandom! {
//                if life > 0 {
                    self.scene?.addChild(itemController.spawnItems())
//                }
//            }
        }
        
    }
    
    @objc func restartGame() {
        if let scene = GameplaySceneClass(fileNamed: "GameplayScene") {
            scene.scaleMode = .aspectFill
            view?.presentScene(scene, transition: SKTransition.doorsOpenHorizontal(withDuration: TimeInterval(2)))
        }
    }
    
    @objc func removeItems() {
        for child in children {
            if child.name == "beer" {
                if child.position.y < -self.scene!.frame.height - 100 {
                    life -= 1
                    lifeLabel?.text = String(life)
                    child.removeFromParent()
                }
            }
        }
    }
}
