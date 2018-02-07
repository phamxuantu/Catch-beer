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
    var bestScoreLabel: SKLabelNode?
    var alertController: UIAlertController?
    var oldPosition: CGFloat?
    var gameTimer:Timer!
    var coinLabel: SKLabelNode?
    var coin: Int = 0
    var firstBody = SKPhysicsBody()
    var secondBody = SKPhysicsBody()
    private var minX = CGFloat(-300), maxX = CGFloat(300)
    private var score = 0 {
        didSet {
            if score > GameViewController.bestScore {
                bestScoreLabel?.text = String(score)
                GameViewController.bestScore = score
            }
            if score >= 100 && score < 250 {
                if gameTimer.timeInterval != 0.9 {
                    if gameTimer != nil {
                        gameTimer.invalidate()
                        gameTimer = nil
                    }
                    gameTimer = Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(spawnItems), userInfo: nil, repeats: true)
                }
//                check = "nho hon 500 lon hon 200"
            } else if score >= 250 && score < 450 {
                if gameTimer.timeInterval != 0.67 {
                    if gameTimer != nil {
                        gameTimer.invalidate()
                        gameTimer = nil
                    }
                    gameTimer = Timer.scheduledTimer(timeInterval: 0.67, target: self, selector: #selector(spawnItems), userInfo: nil, repeats: true)
                }
//                check = "lon hon 500"
            } else if score >= 450 && score < 700 {
                if gameTimer.timeInterval != 0.5 {
                    if gameTimer != nil {
                        gameTimer.invalidate()
                        gameTimer = nil
                    }
                    gameTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(spawnItems), userInfo: nil, repeats: true)
                }
                //                check = "lon hon 500"
            } else if score >= 700 && score < 1000 {
                if gameTimer.timeInterval != 0.43 {
                    if gameTimer != nil {
                        gameTimer.invalidate()
                        gameTimer = nil
                    }
                    gameTimer = Timer.scheduledTimer(timeInterval: 0.43, target: self, selector: #selector(spawnItems), userInfo: nil, repeats: true)
                }
                //                check = "lon hon 500"
            } else if score >= 1000 && score < 1350 {
                if gameTimer.timeInterval != 0.36 {
                    if gameTimer != nil {
                        gameTimer.invalidate()
                        gameTimer = nil
                    }
                    gameTimer = Timer.scheduledTimer(timeInterval: 0.36, target: self, selector: #selector(spawnItems), userInfo: nil, repeats: true)
                }
                //                check = "lon hon 500"
            } else if score >= 1350 && score < 1750 {
                if gameTimer.timeInterval != 0.29 {
                    if gameTimer != nil {
                        gameTimer.invalidate()
                        gameTimer = nil
                    }
                    gameTimer = Timer.scheduledTimer(timeInterval: 0.29, target: self, selector: #selector(spawnItems), userInfo: nil, repeats: true)
                }
                //                check = "lon hon 500"
            } else if score >= 1750 {
                if gameTimer.timeInterval != 0.21 {
                    if gameTimer != nil {
                        gameTimer.invalidate()
                        gameTimer = nil
                    }
                    gameTimer = Timer.scheduledTimer(timeInterval: 0.21, target: self, selector: #selector(spawnItems), userInfo: nil, repeats: true)
                }
                //                check = "lon hon 500"
            }
        }
    }
    private var life = 3 {
        didSet {
            if life <= 0 {
                GameViewController.coinCollect += coin
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
                        self.view!.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: TimeInterval(1)))
                    }
                }
                
                alertController?.addAction(restartAction)
                alertController?.addAction(exitAction)
                view?.window?.rootViewController?.present(alertController!, animated: true, completion: nil)
            }
//            else {
//                self.lifeLabel?.text = ""
//                for _ in 1...self.life {
//                    self.lifeLabel?.text = self.lifeLabel!.text! + "❤️"
//                }
//            }
        }
    }
    
    override func didMove(to view: SKView) {
        initializeGame()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            if touchLocation.y < 0 {
                let sub = touchLocation.x - oldPosition!
                player?.position.x += (1.2 * sub)
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
//        print(arr.count)
        
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
                secondBody.node?.setScale(0.05)
                var arrAction = [SKAction]()
                arrAction.append(SKAction.move(to: lifeLabel!.position, duration: 1))
                arrAction.append(SKAction.run {
                    self.lifeLabel?.text = ""
                    for _ in 1...self.life {
                        self.lifeLabel?.text = self.lifeLabel!.text! + "❤️"
                    }
                })
                arrAction.append(SKAction.removeFromParent())
                secondBody.node?.run(SKAction.sequence(arrAction))
            } else {
                life += 1
                secondBody.node?.setScale(0.05)
                var arrAction = [SKAction]()
                arrAction.append(SKAction.move(to: lifeLabel!.position, duration: 1))
                arrAction.append(SKAction.run {
                    self.lifeLabel?.text = ""
                    for _ in 1...self.life {
                        self.lifeLabel?.text = self.lifeLabel!.text! + "❤️"
                    }
                })
                arrAction.append(SKAction.removeFromParent())
                secondBody.node?.run(SKAction.sequence(arrAction))
//                secondBody.node?.removeFromParent()
            }
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "coin" {
            coin += 1
            coinLabel?.text = String(coin)
            secondBody.node?.removeFromParent()
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "bom" {
//            let explosion = SKEmitterNode(fileNamed: "Explosion.sks")!
            lifeLabel?.text = ""
            for child in self.children {
                let explosion = SKEmitterNode(fileNamed: "Explosion")!
                if child.name == "beer" ||  child.name == "beer-gold" || child.name == "bom" || child.name == "heart" || child.name == "coin" {
                    explosion.position = child.position
                    child.removeFromParent()
                    self.addChild(explosion)
                    if self.gameTimer != nil {
                        self.gameTimer.invalidate()
                        self.gameTimer = nil
                    }
                    self.run(SKAction.wait(forDuration: 1), completion: {
                        explosion.removeFromParent()
                        self.life = 0
                    })
                    
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
        lifeLabel?.text = "❤️❤️❤️"
        
        coinLabel = childNode(withName: "CoinLabel") as? SKLabelNode!
        coinLabel?.text = "0"
        
        bestScoreLabel = childNode(withName: "BestScoreLabelPlay") as? SKLabelNode!
        bestScoreLabel?.text = String(GameViewController.bestScore)
        
        if gameTimer == nil {
            gameTimer = Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(spawnItems), userInfo: nil, repeats: true)
        }
        
//            print("xuat hien: ", gameTimer!)
    }
    
    @objc func spawnItems(){
        let item: SKSpriteNode?
        if life == 3 || life == 4 {
            item = itemController.spawnLittleHeart(y: self.frame.size.height / 2)
        } else if life == 5 {
            item = itemController.spawnNoHeart(y: self.frame.size.height / 2)
        } else {
            item = itemController.spawnNormal(y: self.frame.size.height / 2)
        }
//        let item = itemController.spawnItems(y: self.frame.size.height / 2)
        self.addChild(item!)
        let animationDuration:TimeInterval?
        if score < 100 {
            animationDuration = TimeInterval(itemController.randomBetweenNumbers(firstNum: 4.5, secondNum: 5))
        } else if score >= 100 && score < 250 {
            animationDuration = TimeInterval(itemController.randomBetweenNumbers(firstNum: 4, secondNum: 4.5))
        } else if score >= 250 && score < 450 {
            animationDuration = TimeInterval(itemController.randomBetweenNumbers(firstNum: 3.5, secondNum: 4))
        } else if score >= 450 && score < 700 {
            animationDuration = TimeInterval(itemController.randomBetweenNumbers(firstNum: 3, secondNum: 3.5))
        } else if score >= 700 && score < 1000 {
            animationDuration = TimeInterval(itemController.randomBetweenNumbers(firstNum: 2.5, secondNum: 3))
        } else if score >= 1000 && score < 1350 {
            animationDuration = TimeInterval(itemController.randomBetweenNumbers(firstNum: 2, secondNum: 2.5))
        } else if score >= 1350 && score < 1750 {
            animationDuration = TimeInterval(itemController.randomBetweenNumbers(firstNum: 1.5, secondNum: 2))
        } else {
            animationDuration = TimeInterval(itemController.randomBetweenNumbers(firstNum: 1, secondNum: 1.5))
        }
//        print("toc do: ", animationDuration!)
        var actionArray = [SKAction]()
        actionArray.append(SKAction.move(to: CGPoint(x: item!.position.x, y: -(self.frame.size.height / 2 + item!.size.height)), duration: animationDuration!))
        actionArray.append(SKAction.run {
            if item!.position.y <= -(self.frame.size.height / 2) {
                if item!.name == "beer" || item!.name == "beer-gold" {
                    self.life -= 1
                    if self.life <= 0 {
                        self.lifeLabel?.text = ""
                        for child in self.children {
                            if child.name == "beer" ||  child.name == "beer-gold" || child.name == "bom" || child.name == "heart" || child.name == "coin" {
                                child.removeFromParent()
                                if self.gameTimer != nil {
                                    self.gameTimer.invalidate()
                                    self.gameTimer = nil
                                }
                            }
                        }
                    } else {
                        self.lifeLabel?.text = ""
                        for _ in 1...self.life {
                            self.lifeLabel?.text = self.lifeLabel!.text! + "❤️"
                        }
                    }
                }
            }
        })
        actionArray.append(SKAction.removeFromParent())
        item!.run(SKAction.sequence(actionArray))
        
    }
    
    @objc func restartGame() {
        if let scene = GameplaySceneClass(fileNamed: "GameplayScene") {
            scene.scaleMode = .aspectFill
            view?.presentScene(scene, transition: SKTransition.doorsOpenHorizontal(withDuration: TimeInterval(2)))
        }
    }
}
