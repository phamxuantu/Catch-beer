//
//  GameViewController.swift
//  Catch beer
//
//  Created by Xuan Tu on 1/29/18.
//  Copyright © 2018 TnTechs. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    static var defaults = UserDefaults.standard
    
    static var bestScore: Int = 0
    static var coinCollect: Int = 0
    static var checkSound: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bestScoreSave = GameViewController.defaults.integer(forKey: "bestScore")
        if bestScoreSave != 0 {
            GameViewController.bestScore = bestScoreSave
        }
        
        let coinCollectSave = GameViewController.defaults.integer(forKey: "coinCollect")
        if coinCollectSave != 0 {
            GameViewController.coinCollect = coinCollectSave
        }
        
        let statusSound = GameViewController.defaults.string(forKey: "checkSound")
        if statusSound != nil {
            if statusSound == "sound" {
                GameViewController.checkSound = true
            } else {
                GameViewController.checkSound = false
            }
        }
        
//        print(UIDevice.current.modelName)

        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
//            UIDevice().modelName
            if let scene = MainMenuScene(fileNamed: GetSceneForDevice().getScene(deviceName: UIDevice().modelName)[0]) {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // Present the scene
                view.presentScene(scene)
            }
            
            
            
//            GetSceneForDevice.init().getScene(deviceName: UIDevice.current.modelName)[0]
            
            view.ignoresSiblingOrder = true
            view.showsPhysics = false
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
