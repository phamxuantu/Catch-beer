//
//  Player.swift
//  Catch beer
//
//  Created by Xuan Tu on 1/29/18.
//  Copyright © 2018 TnTechs. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    func initializePlayer() {
        name = "Player"
        physicsBody = SKPhysicsBody(circleOfRadius: size.height / 3)
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = ColliderType.BEER
        physicsBody?.contactTestBitMask = ColliderType.PLAYER
    }
}
