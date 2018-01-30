//
//  ItemController.swift
//  Catch beer
//
//  Created by Xuan Tu on 1/29/18.
//  Copyright © 2018 TnTechs. All rights reserved.
//

import SpriteKit

struct ColliderType {
    static let PLAYER: UInt32 = 0
    static let BEER: UInt32 = 1
}

class ItemController {
    
    private var minX = CGFloat(-175), maxX = CGFloat(175)
    
    func spawnItems() -> SKSpriteNode {
        let item: SKSpriteNode?
        item = SKSpriteNode(imageNamed: "beer")
        item!.name = "beer"
        item!.setScale(0.2)
        item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 2)
        item!.physicsBody?.categoryBitMask = ColliderType.BEER
        item!.zPosition = 3
        item?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        item!.position.x = randomBetweenNumbers(firstNum: minX, secondNum: maxX)
        item!.position.y = 500
        return item!
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
}
