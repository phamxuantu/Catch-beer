//
//  ItemController.swift
//  Catch beer
//
//  Created by Xuan Tu on 1/29/18.
//  Copyright © 2018 TnTechs. All rights reserved.
//

import SpriteKit

struct ColliderType {
    static let PLAYER: UInt32 = 0x1 << 1
    static let BEER: UInt32 = 0x1 << 0
}

class ItemController {
    
    private var minX = CGFloat(-300), maxX = CGFloat(300)
    
//    func spawnItems(y: CGFloat, life: Int) -> SKSpriteNode {
//
//        if life == 3 || life == 4 {
//            spawnLittleHeart(y: y)
//        } else if life == 5 {
//            spawnNoHeart(y: y)
//        } else {
//            spawnNormal(y: y)
//        }
//    }
    
    func spawnLittleHeart(y: CGFloat) -> SKSpriteNode {
        let item: SKSpriteNode?
        let number = Int(randomBetweenNumbers(firstNum: 1, secondNum: 100))
        
        if number <= 25 {
            item = SKSpriteNode(imageNamed: "bom")
            //            let bomTexture = SKTexture(imageNamed: "bom")
            item!.name = "bom"
            item?.setScale(0.2)
            //            item!.physicsBody = SKPhysicsBody(texture: bomTexture, size: CGSize(width: item!.size.width, height: item!.size.height))
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.width / 2)
        } else if number >= 26 && number <= 30 {
            item = SKSpriteNode(imageNamed: "heart")
            //            let heartTexture = SKTexture(imageNamed: "heart")
            item!.name = "heart"
            item?.setScale(0.097)
            //            item!.physicsBody = SKPhysicsBody(texture: heartTexture, size: CGSize(width: item!.size.width, height: item!.size.height))
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 3)
        } else if number >= 31 && number <= 45 {
            item = SKSpriteNode(imageNamed: "beer-gold")
            //            let beerGoldTexture = SKTexture(imageNamed: "beer-gold")
            item!.name = "beer-gold"
            item?.setScale(1.1)
            //            item!.physicsBody = SKPhysicsBody(texture: beerGoldTexture, size: CGSize(width: item!.size.width, height: item!.size.height))
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 3)
        } else if number >= 46 && number <= 55 {
            item = SKSpriteNode(imageNamed: "coin")
            //            let beerGoldTexture = SKTexture(imageNamed: "beer-gold")
            item!.name = "coin"
            item?.setScale(0.35)
            //            item!.physicsBody = SKPhysicsBody(texture: beerGoldTexture, size: CGSize(width: item!.size.width, height: item!.size.height))
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 3)
        } else {
            item = SKSpriteNode(imageNamed: "beer")
            //            let beerTexture = SKTexture(imageNamed: "beer")
            item!.name = "beer"
            item?.setScale(0.3)
            //            item!.physicsBody = SKPhysicsBody(texture: beerTexture, size: CGSize(width: item!.size.width, height: item!.size.height))
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 3)
        }
        item?.zPosition = 3
        let position = randomBetweenNumbers(firstNum: minX, secondNum: maxX)
        item!.position = CGPoint(x: position, y: y + item!.size.height)
        item!.physicsBody?.isDynamic = true
        item!.physicsBody?.categoryBitMask = ColliderType.PLAYER
        item!.physicsBody?.contactTestBitMask = ColliderType.BEER
        item!.physicsBody?.collisionBitMask = 0
        return item!
    }
    
    func spawnNoHeart(y: CGFloat) -> SKSpriteNode {
        let item: SKSpriteNode?
        let number = Int(randomBetweenNumbers(firstNum: 1, secondNum: 100))
        
        if number <= 30 {
            item = SKSpriteNode(imageNamed: "bom")
            //            let bomTexture = SKTexture(imageNamed: "bom")
            item!.name = "bom"
            item?.setScale(0.2)
            //            item!.physicsBody = SKPhysicsBody(texture: bomTexture, size: CGSize(width: item!.size.width, height: item!.size.height))
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.width / 2)
        } else if number >= 31 && number <= 45 {
            item = SKSpriteNode(imageNamed: "beer-gold")
            //            let beerGoldTexture = SKTexture(imageNamed: "beer-gold")
            item!.name = "beer-gold"
            item?.setScale(1.1)
            //            item!.physicsBody = SKPhysicsBody(texture: beerGoldTexture, size: CGSize(width: item!.size.width, height: item!.size.height))
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 3)
        } else if number >= 46 && number <= 55 {
            item = SKSpriteNode(imageNamed: "coin")
            //            let beerGoldTexture = SKTexture(imageNamed: "beer-gold")
            item!.name = "coin"
            item?.setScale(0.35)
            //            item!.physicsBody = SKPhysicsBody(texture: beerGoldTexture, size: CGSize(width: item!.size.width, height: item!.size.height))
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 3)
        } else {
            item = SKSpriteNode(imageNamed: "beer")
            //            let beerTexture = SKTexture(imageNamed: "beer")
            item!.name = "beer"
            item?.setScale(0.3)
            //            item!.physicsBody = SKPhysicsBody(texture: beerTexture, size: CGSize(width: item!.size.width, height: item!.size.height))
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 3)
        }
        item?.zPosition = 3
        let position = randomBetweenNumbers(firstNum: minX, secondNum: maxX)
        item!.position = CGPoint(x: position, y: y + item!.size.height)
        item!.physicsBody?.isDynamic = true
        item!.physicsBody?.categoryBitMask = ColliderType.PLAYER
        item!.physicsBody?.contactTestBitMask = ColliderType.BEER
        item!.physicsBody?.collisionBitMask = 0
        return item!
    }
    
    func spawnNormal(y: CGFloat) -> SKSpriteNode {
        let item: SKSpriteNode?
        let number = Int(randomBetweenNumbers(firstNum: 0, secondNum: 100))
        
        if number <= 20 {
            item = SKSpriteNode(imageNamed: "bom")
            //            let bomTexture = SKTexture(imageNamed: "bom")
            item!.name = "bom"
            item?.setScale(0.2)
            //            item!.physicsBody = SKPhysicsBody(texture: bomTexture, size: CGSize(width: item!.size.width, height: item!.size.height))
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.width / 2)
        } else if number >= 21 && number <= 30 {
            item = SKSpriteNode(imageNamed: "heart")
            //            let heartTexture = SKTexture(imageNamed: "heart")
            item!.name = "heart"
            item?.setScale(0.097)
            //            item!.physicsBody = SKPhysicsBody(texture: heartTexture, size: CGSize(width: item!.size.width, height: item!.size.height))
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 3)
        } else if number >= 31 && number <= 45 {
            item = SKSpriteNode(imageNamed: "beer-gold")
            //            let beerGoldTexture = SKTexture(imageNamed: "beer-gold")
            item!.name = "beer-gold"
            item?.setScale(1.1)
            //            item!.physicsBody = SKPhysicsBody(texture: beerGoldTexture, size: CGSize(width: item!.size.width, height: item!.size.height))
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 3)
        } else if number >= 46 && number <= 55 {
            item = SKSpriteNode(imageNamed: "coin")
            //            let beerGoldTexture = SKTexture(imageNamed: "beer-gold")
            item!.name = "coin"
            item?.setScale(0.35)
            //            item!.physicsBody = SKPhysicsBody(texture: beerGoldTexture, size: CGSize(width: item!.size.width, height: item!.size.height))
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 3)
        } else {
            item = SKSpriteNode(imageNamed: "beer")
            //            let beerTexture = SKTexture(imageNamed: "beer")
            item!.name = "beer"
            item?.setScale(0.3)
            //            item!.physicsBody = SKPhysicsBody(texture: beerTexture, size: CGSize(width: item!.size.width, height: item!.size.height))
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 3)
        }
        item?.zPosition = 3
        let position = randomBetweenNumbers(firstNum: minX, secondNum: maxX)
        item!.position = CGPoint(x: position, y: y + item!.size.height)
        item!.physicsBody?.isDynamic = true
        item!.physicsBody?.categoryBitMask = ColliderType.PLAYER
        item!.physicsBody?.contactTestBitMask = ColliderType.BEER
        item!.physicsBody?.collisionBitMask = 0
        return item!
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
}
