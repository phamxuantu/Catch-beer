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
    
    private var minX = CGFloat(-175), maxX = CGFloat(175)
    
    func spawnItems(y: CGFloat) -> SKSpriteNode {
        
        let item: SKSpriteNode?
        let number = Int(randomBetweenNumbers(firstNum: 0, secondNum: 10))
        
        if number < 3 {
            item = SKSpriteNode(imageNamed: "bom")
            item!.name = "bom"
            item?.setScale(0.1)
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 3)
        } else if number >= 3 && number < 4 {
            item = SKSpriteNode(imageNamed: "heart")
            item!.name = "heart"
            item?.setScale(0.05)
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 3)
        } else if number >= 4 && number <= 6 {
            item = SKSpriteNode(imageNamed: "beer-gold")
            item!.name = "beer-gold"
            item?.setScale(0.2)
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 3)
        } else {
            item = SKSpriteNode(imageNamed: "beer")
            item!.name = "beer"
            item?.setScale(0.2)
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 3)
        }
        let position = randomBetweenNumbers(firstNum: minX, secondNum: maxX)
        item!.position = CGPoint(x: position, y: y + item!.size.height)
        item!.physicsBody?.isDynamic = true
        item!.physicsBody?.categoryBitMask = ColliderType.PLAYER
        item!.physicsBody?.contactTestBitMask = ColliderType.BEER
        item!.physicsBody?.collisionBitMask = 0
        return item!
    }
    
//    func spawnHeart(y: CGFloat) -> SKSpriteNode {
//        let item: SKSpriteNode?
//        item = SKSpriteNode(imageNamed: "heart")
//        item!.name = "heart"
//        item?.setScale(0.2)
//        item!.physicsBody = SKPhysicsBody(rectangleOf: item!.size)
//        let position = randomBetweenNumbers(firstNum: minX, secondNum: maxX)
//        item!.position = CGPoint(x: position, y: y + item!.size.height)
//        item!.physicsBody?.isDynamic = true
//        item!.physicsBody?.categoryBitMask = ColliderType.PLAYER
//        item!.physicsBody?.contactTestBitMask = ColliderType.BEER
//        item!.physicsBody?.collisionBitMask = 0
//        return item!
//    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
}
