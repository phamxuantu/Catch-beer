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
        let playerTexture = SKTexture(imageNamed: "Player")
//        physicsBody = SKPhysicsBody(circleOfRadius: size.height / 2)
        physicsBody = SKPhysicsBody(texture: playerTexture, size: CGSize(width: size.width, height: size.height - 25))
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = ColliderType.BEER
        physicsBody?.contactTestBitMask = ColliderType.PLAYER
    }
}
