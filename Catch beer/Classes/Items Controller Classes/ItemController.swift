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
    
    let bom = GetSceneForDevice().getScaleItem(deviceName: UIDevice().modelName).bom
    let heart = GetSceneForDevice().getScaleItem(deviceName: UIDevice().modelName).heart
    let beerGold = GetSceneForDevice().getScaleItem(deviceName: UIDevice().modelName).beerGold
    let coin = GetSceneForDevice().getScaleItem(deviceName: UIDevice().modelName).coin
    let beer = GetSceneForDevice().getScaleItem(deviceName: UIDevice().modelName).beer
    
    func spawnLittleHeart(y: CGFloat, width: CGFloat) -> SKSpriteNode {
        let item: SKSpriteNode?
        let number = Int(randomBetweenNumbers(firstNum: 1, secondNum: 100))
        if number <= 25 {
            item = SKSpriteNode(imageNamed: "bom")
            //            let bomTexture = SKTexture(imageNamed: "bom")
            item!.name = "bom"
            item?.setScale(bom)
            item?.anchorPoint.y = 0.4
            //            item!.physicsBody = SKPhysicsBody(texture: bomTexture, size: CGSize(width: item!.size.width, height: item!.size.height))
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.width / 2)
        } else if number >= 26 && number <= 30 {
            item = SKSpriteNode(imageNamed: "heart")
            //            let heartTexture = SKTexture(imageNamed: "heart")
            item!.name = "heart"
            item?.setScale(heart)
            //            item!.physicsBody = SKPhysicsBody(texture: heartTexture, size: CGSize(width: item!.size.width, height: item!.size.height))
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 3)
        } else if number >= 31 && number <= 45 {
            item = SKSpriteNode(imageNamed: "beerGold")
            //            let beerGoldTexture = SKTexture(imageNamed: "beer-gold")
            item!.name = "beerGold"
            item?.setScale(beerGold)
            item?.anchorPoint.y = 0.3
            //            item!.physicsBody = SKPhysicsBody(texture: beerGoldTexture, size: CGSize(width: item!.size.width, height: item!.size.height))
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 3)
        } else if number >= 46 && number <= 55 {
            item = SKSpriteNode(imageNamed: "coin")
            //            let beerGoldTexture = SKTexture(imageNamed: "beer-gold")
            item!.name = "coin"
            item?.setScale(coin)
            //            item!.physicsBody = SKPhysicsBody(texture: beerGoldTexture, size: CGSize(width: item!.size.width, height: item!.size.height))
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 3)
        } else {
            item = SKSpriteNode(imageNamed: "beer")
            //            let beerTexture = SKTexture(imageNamed: "beer")
            item!.name = "beer"
            item?.setScale(beer)
            item?.anchorPoint.y = 0.3
            //            item!.physicsBody = SKPhysicsBody(texture: beerTexture, size: CGSize(width: item!.size.width, height: item!.size.height))
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 3)
        }
        item?.zPosition = 3
        let minX = CGFloat(-(width / 2 - item!.size.width / 2)), maxX = (width / 2 - item!.size.width / 2)
        let position = randomBetweenNumbers(firstNum: minX, secondNum: maxX)
        item!.position = CGPoint(x: position, y: y + item!.size.height)
        item!.physicsBody?.isDynamic = true
        item!.physicsBody?.categoryBitMask = ColliderType.PLAYER
        item!.physicsBody?.contactTestBitMask = ColliderType.BEER
        item!.physicsBody?.collisionBitMask = 0
        return item!
    }
    
    func spawnNoHeart(y: CGFloat, width: CGFloat) -> SKSpriteNode {
        let item: SKSpriteNode?
        let number = Int(randomBetweenNumbers(firstNum: 1, secondNum: 100))
        
        if number <= 30 {
            item = SKSpriteNode(imageNamed: "bom")
            //            let bomTexture = SKTexture(imageNamed: "bom")
            item!.name = "bom"
            item?.setScale(bom)
            item?.anchorPoint.y = 0.4
            //            item!.physicsBody = SKPhysicsBody(texture: bomTexture, size: CGSize(width: item!.size.width, height: item!.size.height))
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.width / 2)
        } else if number >= 31 && number <= 45 {
            item = SKSpriteNode(imageNamed: "beerGold")
            //            let beerGoldTexture = SKTexture(imageNamed: "beer-gold")
            item!.name = "beerGold"
            item?.setScale(beerGold)
            item?.anchorPoint.y = 0.3
            //            item!.physicsBody = SKPhysicsBody(texture: beerGoldTexture, size: CGSize(width: item!.size.width, height: item!.size.height))
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 3)
        } else if number >= 46 && number <= 55 {
            item = SKSpriteNode(imageNamed: "coin")
            //            let beerGoldTexture = SKTexture(imageNamed: "beer-gold")
            item!.name = "coin"
            item?.setScale(coin)
            //            item!.physicsBody = SKPhysicsBody(texture: beerGoldTexture, size: CGSize(width: item!.size.width, height: item!.size.height))
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 3)
        } else {
            item = SKSpriteNode(imageNamed: "beer")
            //            let beerTexture = SKTexture(imageNamed: "beer")
            item!.name = "beer"
            item?.setScale(beer)
            item?.anchorPoint.y = 0.3
            //            item!.physicsBody = SKPhysicsBody(texture: beerTexture, size: CGSize(width: item!.size.width, height: item!.size.height))
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 3)
        }
        item?.zPosition = 3
        let minX = CGFloat(-(width / 2 - item!.size.width / 2)), maxX = (width / 2 - item!.size.width / 2)
        let position = randomBetweenNumbers(firstNum: minX, secondNum: maxX)
        item!.position = CGPoint(x: position, y: y + item!.size.height)
        item!.physicsBody?.isDynamic = true
        item!.physicsBody?.categoryBitMask = ColliderType.PLAYER
        item!.physicsBody?.contactTestBitMask = ColliderType.BEER
        item!.physicsBody?.collisionBitMask = 0
        return item!
    }
    
    func spawnNormal(y: CGFloat, width: CGFloat) -> SKSpriteNode {
        let item: SKSpriteNode?
        let number = Int(randomBetweenNumbers(firstNum: 1, secondNum: 100))
        
        if number <= 20 {
            item = SKSpriteNode(imageNamed: "bom")
            //            let bomTexture = SKTexture(imageNamed: "bom")
            item!.name = "bom"
            
            item?.setScale(bom)
            item?.anchorPoint.y = 0.4
            //            item!.physicsBody = SKPhysicsBody(texture: bomTexture, size: CGSize(width: item!.size.width, height: item!.size.height))
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.width / 2)
        } else if number >= 21 && number <= 30 {
            item = SKSpriteNode(imageNamed: "heart")
            //            let heartTexture = SKTexture(imageNamed: "heart")
            item!.name = "heart"
            item?.setScale(heart)
            //            item!.physicsBody = SKPhysicsBody(texture: heartTexture, size: CGSize(width: item!.size.width, height: item!.size.height))
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 3)
        } else if number >= 31 && number <= 45 {
            item = SKSpriteNode(imageNamed: "beerGold")
            //            let beerGoldTexture = SKTexture(imageNamed: "beer-gold")
            item!.name = "beerGold"
            item?.setScale(beerGold)
            item?.anchorPoint.y = 0.3
            //            item!.physicsBody = SKPhysicsBody(texture: beerGoldTexture, size: CGSize(width: item!.size.width, height: item!.size.height))
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 3)
        } else if number >= 46 && number <= 55 {
            item = SKSpriteNode(imageNamed: "coin")
            //            let beerGoldTexture = SKTexture(imageNamed: "beer-gold")
            item!.name = "coin"
            item?.setScale(coin)
            //            item!.physicsBody = SKPhysicsBody(texture: beerGoldTexture, size: CGSize(width: item!.size.width, height: item!.size.height))
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 3)
        } else {
            item = SKSpriteNode(imageNamed: "beer")
            //            let beerTexture = SKTexture(imageNamed: "beer")
            item!.name = "beer"
            item?.setScale(beer)
            item?.anchorPoint.y = 0.3
            //            item!.physicsBody = SKPhysicsBody(texture: beerTexture, size: CGSize(width: item!.size.width, height: item!.size.height))
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 3)
        }
        item?.zPosition = 3
        let minX = CGFloat(-(width / 2 - item!.size.width / 2)), maxX = (width / 2 - item!.size.width / 2)
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
