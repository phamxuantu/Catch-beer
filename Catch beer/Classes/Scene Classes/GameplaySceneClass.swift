//
//  GameplaySceneClass.swift
//  Catch beer
//
//  Created by Xuan Tu on 1/29/18.
//  Copyright © 2018 TnTechs. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameplaySceneClass: SKScene, SKPhysicsContactDelegate {
    
    static var sharedInstance = GameplaySceneClass()
    
    private var player: Player?
    private var itemController = ItemController()
    private var scoreLabel: SKLabelNode?
    private var lifeLabel: SKLabelNode?
    var oldPosition: CGFloat?
    var gameTimer:Timer!
    var coinLabel: SKLabelNode?
    var coin: Int = 0
    var firstBody = SKPhysicsBody()
    var secondBody = SKPhysicsBody()
    var sound: SKSpriteNode?
//    let width = UIScreen.main.bounds.width
    var width: CGFloat?
    var height: CGFloat?
    var checkSound: Bool = GameViewController.checkSound
    var BG: SKSpriteNode?
    var BGPopUp: SKSpriteNode?
    var textScore: SKLabelNode?
    var yourScoreLabel: SKLabelNode?
    var menu: SKSpriteNode?
    var playAgain: SKSpriteNode?
    var checkBestScore: Bool = false
    var checkGameScene: Bool = false
    var BGTap: SKSpriteNode?
    var textTap: SKLabelNode?
    var checkTouch = false
//    var audioBottleFalls = AVAudioPlayer()
//    var audioBoom = AVAudioPlayer()
//    var audioCoin = AVAudioPlayer()
//    var audioHeart = AVAudioPlayer()
    var score = 0 {
        didSet {
            if score > GameViewController.bestScore {
                GameViewController.bestScore = score
                checkBestScore = true
            }
            if score >= 100 && score < 250 {
                if gameTimer.timeInterval != 0.9 {
                    if gameTimer != nil {
                        gameTimer.invalidate()
                        gameTimer = nil
                    }
                    gameTimer = Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(spawnItems), userInfo: nil, repeats: true)
                }
            } else if score >= 250 && score < 450 {
                if gameTimer.timeInterval != 0.67 {
                    if gameTimer != nil {
                        gameTimer.invalidate()
                        gameTimer = nil
                    }
                    gameTimer = Timer.scheduledTimer(timeInterval: 0.67, target: self, selector: #selector(spawnItems), userInfo: nil, repeats: true)
                }
            } else if score >= 450 && score < 700 {
                if gameTimer.timeInterval != 0.5 {
                    if gameTimer != nil {
                        gameTimer.invalidate()
                        gameTimer = nil
                    }
                    gameTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(spawnItems), userInfo: nil, repeats: true)
                }
            } else if score >= 700 && score < 1000 {
                if gameTimer.timeInterval != 0.43 {
                    if gameTimer != nil {
                        gameTimer.invalidate()
                        gameTimer = nil
                    }
                    gameTimer = Timer.scheduledTimer(timeInterval: 0.43, target: self, selector: #selector(spawnItems), userInfo: nil, repeats: true)
                }
            } else if score >= 1000 && score < 1350 {
                if gameTimer.timeInterval != 0.36 {
                    if gameTimer != nil {
                        gameTimer.invalidate()
                        gameTimer = nil
                    }
                    gameTimer = Timer.scheduledTimer(timeInterval: 0.36, target: self, selector: #selector(spawnItems), userInfo: nil, repeats: true)
                }
            } else if score >= 1350 && score < 1750 {
                if gameTimer.timeInterval != 0.29 {
                    if gameTimer != nil {
                        gameTimer.invalidate()
                        gameTimer = nil
                    }
                    gameTimer = Timer.scheduledTimer(timeInterval: 0.29, target: self, selector: #selector(spawnItems), userInfo: nil, repeats: true)
                }
            } else if score >= 1750 {
                if gameTimer.timeInterval != 0.21 {
                    if gameTimer != nil {
                        gameTimer.invalidate()
                        gameTimer = nil
                    }
                    gameTimer = Timer.scheduledTimer(timeInterval: 0.21, target: self, selector: #selector(spawnItems), userInfo: nil, repeats: true)
                }
            }
        }
    }
    private var life = 3 {
        didSet {
            if life <= 0 {
                checkGameScene = false
                GameViewController.defaults.set(GameViewController.bestScore, forKey: "bestScore")
                
                firstBody.node?.removeFromParent()
                secondBody.node?.removeFromParent()
                
                if self.gameTimer != nil {
                    self.gameTimer.invalidate()
                    self.gameTimer = nil
                }
                
                BG?.zPosition = 5
                BGPopUp?.zPosition = 6
                textScore?.zPosition = 7
                if checkBestScore {
                    textScore?.text = "High Score"
                    textScore?.run(SKAction.repeatForever(.sequence([SKAction.scale(to: 1.1, duration: 0.5), SKAction.scale(to: 0.9, duration: 0.5)])))
                }
                
                yourScoreLabel?.text = String(score)
                yourScoreLabel?.zPosition = 7
                menu?.zPosition = 7
                playAgain?.zPosition = 7
            }
        }
    }
    
    override func didMove(to view: SKView) {
        checkGameScene = true
        GameplaySceneClass.sharedInstance = self
        width = self.frame.size.width
        height = self.frame.size.height
        sound = childNode(withName: "Sound") as? SKSpriteNode
        
//        try!AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
//        try! AVAudioSession.sharedInstance().setActive(true)
//
//        let soundBottleFalls = NSURL(fileURLWithPath: Bundle.main.path(forResource: "bottleFalls", ofType: "mp3")!)
//        try! audioBottleFalls = AVAudioPlayer(contentsOf: soundBottleFalls as URL)
//        audioBottleFalls.prepareToPlay()
//
//        let soundBoom = NSURL(fileURLWithPath: Bundle.main.path(forResource: "boom", ofType: "mp3")!)
//        try! audioBoom = AVAudioPlayer(contentsOf: soundBoom as URL)
//        audioBoom.prepareToPlay()
//
//        let soundCoin = NSURL(fileURLWithPath: Bundle.main.path(forResource: "coin", ofType: "wav")!)
//        try! audioCoin = AVAudioPlayer(contentsOf: soundCoin as URL)
//        audioCoin.prepareToPlay()
//
//        let soundHeart = NSURL(fileURLWithPath: Bundle.main.path(forResource: "heart", ofType: "wav")!)
//        try! audioHeart = AVAudioPlayer(contentsOf: soundHeart as URL)
//        audioHeart.prepareToPlay()
        
        if checkSound {
            sound?.texture = SKTexture(imageNamed: "sound")
//            audioBottleFalls.volume = 1
//            audioBoom.volume = 1
//            audioCoin.volume = 1
//            audioHeart.volume = 1
        } else {
            sound?.texture = SKTexture(imageNamed: "mute")
//            audioBottleFalls.volume = 0
//            audioBoom.volume = 0
//            audioCoin.volume = 0
//            audioHeart.volume = 0
        }
        
        BG = childNode(withName: "BG") as? SKSpriteNode
        BG?.zPosition = -2
        BGPopUp = childNode(withName: "BGPopUp") as? SKSpriteNode
        BGPopUp?.zPosition = -2
        textScore = childNode(withName: "TextScore") as? SKLabelNode
        textScore?.zPosition = -2
        yourScoreLabel = childNode(withName: "YourScoreLabel") as? SKLabelNode
        yourScoreLabel?.zPosition = -2
        menu = childNode(withName: "Menu") as? SKSpriteNode
        menu?.zPosition = -2
        playAgain = childNode(withName: "PlayAgain") as? SKSpriteNode
        playAgain?.zPosition = -2
        BGTap = childNode(withName: "BGTap") as? SKSpriteNode
        BGTap?.zPosition = -2
        textTap = childNode(withName: "TapToResume") as? SKLabelNode
        textTap?.zPosition = -2
        
        initializeGame()
    }
    
    func pauseGame() {
        if self.gameTimer != nil {
            self.gameTimer.invalidate()
            self.physicsWorld.speed = 0.0
            self.speed = 0.0
//            textTap?.speed = 1.0
            print("ok")
        } else {
            print("not ok")
        }
    }
    
    func prepareResume() {
        if self.checkGameScene {
            BGTap?.zPosition = 8
            textTap?.zPosition = 9
        }
    }

    func resumeGame() {
        if self.checkGameScene {
            if self.physicsWorld.speed == 0.0 {
                self.physicsWorld.speed = 1.0
                self.speed = 1.0
            }
            if score >= 100 && score < 250 {
                gameTimer = Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(spawnItems), userInfo: nil, repeats: true)
            }
            if score >= 250 && score < 450 {
                gameTimer = Timer.scheduledTimer(timeInterval: 0.67, target: self, selector: #selector(spawnItems), userInfo: nil, repeats: true)
            }
            if score >= 450 && score < 700 {
                gameTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(spawnItems), userInfo: nil, repeats: true)
            }
            if score >= 700 && score < 1000 {
                gameTimer = Timer.scheduledTimer(timeInterval: 0.43, target: self, selector: #selector(spawnItems), userInfo: nil, repeats: true)
            }
            if score >= 1000 && score < 1350 {
                gameTimer = Timer.scheduledTimer(timeInterval: 0.36, target: self, selector: #selector(spawnItems), userInfo: nil, repeats: true)
            }
            if score >= 1350 && score < 1750 {
                gameTimer = Timer.scheduledTimer(timeInterval: 0.29, target: self, selector: #selector(spawnItems), userInfo: nil, repeats: true)
            }
            if score >= 1750 {
                gameTimer = Timer.scheduledTimer(timeInterval: 0.21, target: self, selector: #selector(spawnItems), userInfo: nil, repeats: true)
            }
            if score < 100 {
                gameTimer = Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(spawnItems), userInfo: nil, repeats: true)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let width = self.frame.size.width
//        print(self.frame.size.width)
        checkTouch = true
        let minX = CGFloat(-(width! / 2 - player!.size.width / 2)), maxX = CGFloat(width! / 2 - player!.size.width / 2)
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
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        checkTouch = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if !checkTouch {
                oldPosition = location.x
            }
            
            if atPoint(location).name == "Sound" {
                if checkSound {
//                    audioBottleFalls.volume = 0
//                    audioBoom.volume = 0
//                    audioCoin.volume = 0
//                    audioHeart.volume = 0
                    sound?.texture = SKTexture(imageNamed: "mute")
                    GameViewController.defaults.set("mute", forKey: "checkSound")
                    GameViewController.defaults.set("mute", forKey: "checkMusic")
                    GameViewController.checkMusic = false
                } else {
//                    audioBottleFalls.volume = 1
//                    audioBoom.volume = 1
//                    audioCoin.volume = 1
//                    audioHeart.volume = 1
                    sound?.texture = SKTexture(imageNamed: "sound")
                    GameViewController.defaults.set("sound", forKey: "checkSound")
                    GameViewController.defaults.set("music", forKey: "checkMusic")
                    GameViewController.checkMusic = true
                }
                checkSound = !checkSound
                GameViewController.checkSound = !GameViewController.checkSound
            }
            
            if atPoint(location).name == "Menu" {
                if self.gameTimer != nil {
                    self.gameTimer.invalidate()
                    self.gameTimer = nil
                }
                
                let coinCollect = GameViewController.coinCollect + self.coin
                GameViewController.coinCollect = coinCollect
                GameViewController.defaults.set(coinCollect, forKey: "coinCollect")
                
                if let scene = MainMenuScene(fileNamed: GetSceneForDevice().getScene(deviceName: UIDevice().modelName)[0]) {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    self.view!.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: TimeInterval(1)))
                }
            }
            
            if atPoint(location).name == "PlayAgain" {
                let coinCollect = GameViewController.coinCollect + self.coin
                GameViewController.coinCollect = coinCollect
                GameViewController.defaults.set(coinCollect, forKey: "coinCollect")
                
                self.life = 3
                Timer.scheduledTimer(timeInterval: TimeInterval(0), target: self, selector: #selector(GameplaySceneClass.restartGame), userInfo: nil, repeats: false)
            }
            
            if atPoint(location).name == "BGTap" || atPoint(location).name == "TapToResume" {
                BGTap?.zPosition = -2
                textTap?.zPosition = -2
                resumeGame()
            }
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
//            self.run(SKAction.playSoundFileNamed("bottleIn.mp3", waitForCompletion: false))
            score += 5
            scoreLabel?.text = String(score)
            secondBody.node?.removeFromParent()
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "beerGold" {
//            self.run(SKAction.playSoundFileNamed("bottleIn.mp3", waitForCompletion: false))
            score += 10
            scoreLabel?.text = String(score)
            secondBody.node?.removeFromParent()
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "heart" {
            if checkSound {
                self.run(SKAction.playSoundFileNamed("heart.wav", waitForCompletion: false))
            }
//            audioHeart.play()
            if life == 5 {
                life = 5
                secondBody.node?.setScale(secondBody.node!.xScale - 0.1)
                var arrAction = [SKAction]()
                arrAction.append(SKAction.move(to: lifeLabel!.position, duration: 0.5))
                arrAction.append(SKAction.run {
                    self.lifeLabel?.text = "x5"
//                    for _ in 1...self.life {
//                        self.lifeLabel?.text = self.lifeLabel!.text! + "❤️"
//                    }
                })
                arrAction.append(SKAction.removeFromParent())
                secondBody.node?.run(SKAction.sequence(arrAction))
            } else {
                life += 1
                secondBody.node?.setScale(secondBody.node!.xScale - 0.1)
                var arrAction = [SKAction]()
                arrAction.append(SKAction.move(to: lifeLabel!.position, duration: 0.5))
                arrAction.append(SKAction.run {
                    self.lifeLabel?.text = "x\(self.life)"
//                    for _ in 1...self.life {
//                        self.lifeLabel?.text = self.lifeLabel!.text! + "❤️"
//                    }
                })
                arrAction.append(SKAction.removeFromParent())
                secondBody.node?.run(SKAction.sequence(arrAction))
            }
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "coin" {
            coin += 1
            if checkSound {
                self.run(SKAction.playSoundFileNamed("coin.wav", waitForCompletion: false))
            }
//            audioCoin.play()
            secondBody.node?.setScale(secondBody.node!.xScale - 0.1)
            var arrAction = [SKAction]()
            arrAction.append(SKAction.move(to: coinLabel!.position, duration: 0.5))
            arrAction.append(SKAction.run {
                self.coinLabel?.text = String(self.coin)
            })
            arrAction.append(SKAction.removeFromParent())
            secondBody.node?.run(SKAction.sequence(arrAction))
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "bom" {
//            let explosion = SKEmitterNode(fileNamed: "Explosion.sks")!
            if checkSound {
                self.run(SKAction.playSoundFileNamed("boom.mp3", waitForCompletion: false))
            }
//            audioBoom.play()
            lifeLabel?.text = "x0"
            for child in self.children {
                let explosion = SKEmitterNode(fileNamed: "Explosion")!
                if child.name == "beer" ||  child.name == "beerGold" || child.name == "bom" || child.name == "heart" || child.name == "coin" {
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
        lifeLabel?.text = "x3"
        
        coinLabel = childNode(withName: "CoinLabel") as? SKLabelNode!
        coinLabel?.text = "0"
        
        if gameTimer == nil {
            gameTimer = Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(spawnItems), userInfo: nil, repeats: true)
        }
        
//            print("xuat hien: ", gameTimer!)
    }
    
    @objc func spawnItems(){
        let item: SKSpriteNode?
        if life == 3 || life == 4 {
            item = itemController.spawnLittleHeart(y: self.frame.size.height / 2, width: self.frame.size.width)
        } else if life == 5 {
            item = itemController.spawnNoHeart(y: self.frame.size.height / 2, width: self.frame.size.width)
        } else {
            item = itemController.spawnNormal(y: self.frame.size.height / 2, width: self.frame.size.width)
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
                if item!.name == "beer" || item!.name == "beerGold" {
                    self.life -= 1
                    if self.checkSound {
                        self.run(SKAction.playSoundFileNamed("bottleFalls.mp3", waitForCompletion: false))
                    }
//                    self.audioBottleFalls.play()
                    if self.life <= 0 {
                        self.lifeLabel?.text = "x0"
                        for child in self.children {
                            if child.name == "beer" ||  child.name == "beerGold" || child.name == "bom" || child.name == "heart" || child.name == "coin" {
                                child.removeFromParent()
                                if self.gameTimer != nil {
                                    self.gameTimer.invalidate()
                                    self.gameTimer = nil
                                }
                            }
                        }
                    } else {
                        self.lifeLabel?.text = "x\(self.life)"
//                        for _ in 1...self.life {
//                            self.lifeLabel?.text = self.lifeLabel!.text! + "❤️"
//                        }
                    }
                }
            }
        })
        actionArray.append(SKAction.removeFromParent())
        item!.run(SKAction.sequence(actionArray))
        
    }
    
    @objc func restartGame() {
        if let scene = GameplaySceneClass(fileNamed: GetSceneForDevice().getScene(deviceName: UIDevice().modelName)[1]) {
            scene.scaleMode = .aspectFill
            view?.presentScene(scene, transition: SKTransition.doorsOpenHorizontal(withDuration: TimeInterval(2)))
        }
    }
}
