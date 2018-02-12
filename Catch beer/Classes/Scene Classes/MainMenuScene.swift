//
//  MainMenuScene.swift
//  Catch beer
//
//  Created by Xuan Tu on 1/29/18.
//  Copyright © 2018 TnTechs. All rights reserved.
//

import SpriteKit
import AVFoundation
import FBSDKLoginKit

class MainMenuScene: SKScene {
    
//    var bestScoreLabel: SKLabelNode?
//    var coinCollectLabel: SKLabelNode?
    var audioPlayer = AVAudioPlayer()
    var alertLogout: UIAlertController?
    var dict : [String : AnyObject]!
    let loginManager = FBSDKLoginManager()
    var sound: SKSpriteNode?
//    var checkSound: Bool?
    
    override func didMove(to view: SKView) {
//        bestScoreLabel = childNode(withName: "BestScoreLabelMenu") as? SKLabelNode!
//        bestScoreLabel?.text = String(GameViewController.bestScore)
//
//        coinCollectLabel = childNode(withName: "CoinCollectLabel") as? SKLabelNode!
//        coinCollectLabel?.text = String(GameViewController.coinCollect)
        
        let alertSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "mainsence", ofType: "mp3")!)
        
        try!AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
        try! AVAudioSession.sharedInstance().setActive(true)
        try! audioPlayer = AVAudioPlayer(contentsOf: alertSound as URL)
        audioPlayer.prepareToPlay()
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
        sound = childNode(withName: "Sound") as? SKSpriteNode
        if GameViewController.checkSound {
            audioPlayer.volume = 1
            sound?.texture = SKTexture(imageNamed: "sound")
        } else {
            audioPlayer.volume = 0
            sound?.texture = SKTexture(imageNamed: "mute")
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if atPoint(location).name == "Start" {
                if let scene = GameplaySceneClass(fileNamed: GetSceneForDevice().getScene(deviceName: UIDevice().modelName)[1]) {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    audioPlayer.stop()
                    // Present the scene
                    view!.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: TimeInterval(2)))
                }
            }
            
            if atPoint(location).name == "Facebook" {
                self.loginFBClicked()
            }
            
            if atPoint(location).name == "Sound" {
                if GameViewController.checkSound {
                    audioPlayer.volume = 0
                    sound?.texture = SKTexture(imageNamed: "mute")
                    GameViewController.defaults.set("mute", forKey: "checkSound")
                } else {
                    audioPlayer.volume = 1
                    sound?.texture = SKTexture(imageNamed: "sound")
                    GameViewController.defaults.set("sound", forKey: "checkSound")
                }
                GameViewController.checkSound = !GameViewController.checkSound
            }
        }
    }
    
    
    func loginFBClicked() {
        if (FBSDKAccessToken.current()) != nil {
            self.didLogIn()
//            print("da co du lieu")
        } else {
            self.loginManager.logIn(withReadPermissions: ["email", "public_profile", "user_friends"], from: view?.window?.rootViewController) { (loginResult, error) -> Void  in
                if (error == nil) {
                    let fbloginresult : FBSDKLoginManagerLoginResult = loginResult!
                    
                    if(fbloginresult.isCancelled) {
                        print("User press cancel")
                        //Show Cancel alert
                    } else if(fbloginresult.grantedPermissions.contains("public_profile") && fbloginresult.grantedPermissions.contains("email") && fbloginresult.grantedPermissions.contains("user_friends")) {
                        self.returnUserData()
                        //fbLoginManager.logOut()
                    }
                }
            }
        }
    }
    
    func didLogIn() {
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! [String : AnyObject]
                    self.alertLogout = UIAlertController(title: "Hello, \(self.dict["name"]!)", message: "", preferredStyle: .actionSheet)
                    
                    let logoutAction = UIAlertAction(title: "Log out", style: .destructive, handler: { (action) in
                        self.loginManager.logOut()
                    })
                    
                    let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
                        print("Cancel log out")
                    })
                    
                    self.alertLogout?.addAction(logoutAction)
                    self.alertLogout?.addAction(cancelAction)
                    
                    self.view?.window?.rootViewController?.present(self.alertLogout!, animated: true, completion: nil)
                    
                    print(result as Any)
                }
            })
        }
    }
    
    func returnUserData() {
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! [String : AnyObject]
                    print(result as Any)
                    print(self.dict)
                }
            })
        }
    }
}
