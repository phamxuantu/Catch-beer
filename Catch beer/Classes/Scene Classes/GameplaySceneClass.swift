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
    private var itemController = ItemController()
    private var scoreLabel: SKLabelNode?
    private var lifeLabel: SKLabelNode?
    private var score = 0
    private var life = 3
    var firstBody = SKPhysicsBody()
    var secondBody = SKPhysicsBody()
    var alertController: UIAlertController?
    var oldPosition: CGFloat?
    var gameTimer:Timer!
    var check:String?
    private var minX = CGFloat(-175), maxX = CGFloat(175)
    
    override func didMove(to view: SKView) {
        initializeGame()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            if touchLocation.y < -(self.frame.size.height/2 - 200) {
                let sub = touchLocation.x - oldPosition!
                player?.position.x += sub
                if (player?.position.x)! < minX {
                    player?.position.x = minX
                }
                if (player?.position.x)! > maxX {
                    player?.position.x = maxX
                }
                oldPosition = touchLocation.x
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            oldPosition = location.x
        }
    }
    
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "beer" {
            score += 5
            scoreLabel?.text = String(score)
            secondBody.node?.removeFromParent()
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "beer-gold" {
            score += 10
            scoreLabel?.text = String(score)
            secondBody.node?.removeFromParent()
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "heart" {
            if life == 5 {
                life = 5
                lifeLabel?.text = "5"
                secondBody.node?.removeFromParent()
            } else {
                life += 1
                lifeLabel?.text = String(life)
                secondBody.node?.removeFromParent()
            }
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "bom" {
            life = 0
            lifeLabel?.text = "0"
            for child in self.children {
                if child.name == "beer" ||  child.name == "beer-gold" || child.name == "bom" || child.name == "heart"{
                    child.removeFromParent()
                }
            }
            firstBody.node?.removeFromParent()
            secondBody.node?.removeFromParent()
        }
    }
    
    private func initializeGame(){
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        player = childNode(withName: "Player") as? Player!
        player?.initializePlayer()
        
        scoreLabel = childNode(withName: "ScoreLabel") as? SKLabelNode!
        scoreLabel?.text = "0"
        
        lifeLabel = childNode(withName: "LifeLabel") as? SKLabelNode!
        lifeLabel?.text = "3"
        if life > 0 {
            if gameTimer == nil {
                gameTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(setTime), userInfo: nil, repeats: true)
            }
//            print("xuat hien: ", gameTimer!)
        }
    }
    
    @objc func setTime(){
        if score <= 200 {
            Timer.scheduledTimer(timeInterval: TimeInterval(itemController.randomBetweenNumbers(firstNum: 0.75, secondNum: 1.25)), target: self, selector: #selector(spawnItems), userInfo: nil, repeats: false)
            check = "nho hon 200"
        } else if score > 200 && score <= 500 {
            Timer.scheduledTimer(timeInterval: TimeInterval(itemController.randomBetweenNumbers(firstNum: 0.5, secondNum: 0.7)), target: self, selector: #selector(spawnItems), userInfo: nil, repeats: false)
            check = "nho hon 500 lon hon 200"
        } else {
            Timer.scheduledTimer(timeInterval: TimeInterval(itemController.randomBetweenNumbers(firstNum: 0.3, secondNum: 0.5)), target: self, selector: #selector(spawnItems), userInfo: nil, repeats: false)
            check = "lon hon 500"
        }
        print("time", check!)
    }
    
    @objc func spawnItems(){
        if life <= 0 {
            firstBody.node?.removeFromParent()
            secondBody.node?.removeFromParent()
            
            if self.gameTimer != nil {
                self.gameTimer.invalidate()
                self.gameTimer = nil
            }
            
            alertController = UIAlertController(title: "Game over", message: "Your score: \(score)", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Play again", style: .default) { (action) in
                self.life = 3
                Timer.scheduledTimer(timeInterval: TimeInterval(0), target: self, selector: #selector(GameplaySceneClass.restartGame), userInfo: nil, repeats: false)
            }
            let exitAction = UIAlertAction(title: "Exit", style: .default) { (action) in
                
                if self.gameTimer != nil {
                    self.gameTimer.invalidate()
                    self.gameTimer = nil
                }
                
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
            let item = itemController.spawnItems(y: self.frame.size.height / 2)
            self.addChild(item)
            let animationDuration:TimeInterval?
            if score < 200 {
                animationDuration = TimeInterval(itemController.randomBetweenNumbers(firstNum: 3.5, secondNum: 5))
            } else if score > 200 && score <= 500 {
                animationDuration = TimeInterval(itemController.randomBetweenNumbers(firstNum: 2, secondNum: 3))
            } else {
                animationDuration = TimeInterval(itemController.randomBetweenNumbers(firstNum: 1, secondNum: 1.5))
            }
            print("toc do: ", animationDuration!)
            var actionArray = [SKAction]()
            actionArray.append(SKAction.move(to: CGPoint(x: item.position.x, y: -(self.frame.size.height / 2 + item.size.height)), duration: animationDuration!))
            actionArray.append(SKAction.run {
                if item.position.y <= -(self.frame.size.height / 2) {
                    if item.name == "beer" || item.name == "beer-gold" {
                        self.life -= 1
                        if self.life <= 0 {
                            self.lifeLabel?.text = "0"
                            for child in self.children {
                                if child.name == "beer" ||  child.name == "beer-gold" || child.name == "bom" || child.name == "heart"{
                                    child.removeFromParent()
                                    if self.gameTimer != nil {
                                        self.gameTimer.invalidate()
                                        self.gameTimer = nil
                                    }
                                }
                            }
                        } else {
                            self.lifeLabel?.text = String(self.life)
                        }
                    }
                }
            })
            actionArray.append(SKAction.removeFromParent())
            item.run(SKAction.sequence(actionArray))
        }
        
    }
    
    @objc func restartGame() {
        if let scene = GameplaySceneClass(fileNamed: "GameplayScene") {
            scene.scaleMode = .aspectFill
            view?.presentScene(scene, transition: SKTransition.doorsOpenHorizontal(withDuration: TimeInterval(2)))
        }
    }
}
