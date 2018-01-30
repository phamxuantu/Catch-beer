//
//  Player.swift
//  Catch beer
//
//  Created by Xuan Tu on 1/29/18.
//  Copyright © 2018 TnTechs. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    private var minX = CGFloat(-175), maxX = CGFloat(175)
    
    func initializePlayer() {
        name = "Player"
        physicsBody = SKPhysicsBody(circleOfRadius: size.height / 2)
        
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = ColliderType.PLAYER
        physicsBody?.contactTestBitMask = ColliderType.BEER
    }
    
    func move(left: Bool) {
        if left {
            position.x -= 10
            if position.x < minX {
                position.x = minX
            }
        } else {
            position.x += 10
            if position.x > maxX {
                position.x = maxX
            }
        }
    }
}
