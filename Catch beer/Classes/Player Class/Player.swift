//
//  Player.swift
//  Catch beer
//
//  Created by Xuan Tu on 1/29/18.
//  Copyright © 2018 TnTechs. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
//    let motionManager = CMMotionManager()
//    var xAcceleration: CGFloat = 0
    
    func initializePlayer() {
        name = "Player"
        physicsBody = SKPhysicsBody(circleOfRadius: size.height / 2)
        
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = ColliderType.PLAYER
        physicsBody?.contactTestBitMask = ColliderType.BEER
    }
    
//    func move() {
//        motionManager.accelerometerUpdateInterval = 0.2
//        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data: CMAccelerometerData?, error: Error?) in
//            if let accelerometerData = data {
//                let acceleration = accelerometerData.acceleration
//                self.xAcceleration = CGFloat(acceleration.x) * 0.75 + self.xAcceleration * 0.25
//            }
//        }
//        if left {
//            position.x -= 10
//            if position.x < minX {
//                position.x = minX
//            }
//        } else {
//            position.x += 10
//            if position.x > maxX {
//                position.x = maxX
//            }
//        }
//    }
}
