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
import TwitterKit
import FBSDKShareKit
import Toast_Swift
import Alamofire

class MainMenuScene: SKScene {
    
    static var sharedInstance = MainMenuScene()
    
    var bestScoreLabel: SKLabelNode?
    var coinCollectLabel: SKLabelNode?
    var audioPlayer = AVAudioPlayer()
    var alertLogout: UIAlertController?
    var dict : [String : AnyObject]!
    let loginManager = FBSDKLoginManager()
    var BGPopup, BGSetting, avatar, checkMusic, checkSound, checkNotification, BGHighScore, changePassword: SKSpriteNode?
    var username, textLogin, textChangePassword: SKLabelNode?
    let scaleXSetting = GetSceneForDevice().getScaleSetting(deviceName: UIDevice().modelName).x
    let scaleYSetting = GetSceneForDevice().getScaleSetting(deviceName: UIDevice().modelName).y
    let scaleHighScore = GetSceneForDevice().getScaleHighScore(deviceName: UIDevice().modelName)
    
    override func didMove(to view: SKView) {
        MainMenuScene.sharedInstance = self
//        print("did move")
        
        if ConnectionCheck.isConnectedToNetwork() {
            print("Connected")
            if let tokenLogin = defaults.string(forKey: "tokenLogin") {
                //            print("tokenLogin: ", tokenLogin) // Some String Value
                getInfoUser(tokenLogin: tokenLogin)
            }
        } else {
            print("DisConnected")
            self.view?.makeToast("You are not conected internet", duration: 3.0, position: .bottom)
        }
        username?.text = userInfo["email"] as? String != "" ? userInfo["email"] as? String : "Username"
        BGPopup = childNode(withName: "BGPopup") as? SKSpriteNode
        BGSetting = childNode(withName: "BGSetting") as? SKSpriteNode
        avatar = BGSetting?.childNode(withName: "Avatar") as? SKSpriteNode
        checkMusic = BGSetting?.childNode(withName: "CheckMusic") as? SKSpriteNode
        checkSound = BGSetting?.childNode(withName: "CheckSound") as? SKSpriteNode
        checkNotification = BGSetting?.childNode(withName: "CheckNotification") as? SKSpriteNode
        username = BGSetting?.childNode(withName: "Username") as? SKLabelNode!
        changePassword = BGSetting?.childNode(withName: "ChangePassword") as? SKSpriteNode
        textChangePassword = BGSetting?.childNode(withName: "TextChangePassword") as? SKLabelNode!
        textLogin = childNode(withName: "TextLogin") as? SKLabelNode!
        BGHighScore = childNode(withName: "BGHighScore") as? SKSpriteNode
        BGPopup?.run(SKAction.hide())
        BGSetting?.run(SKAction.hide())
        BGSetting?.setScale(0)
        BGHighScore?.run(SKAction.hide())
        BGHighScore?.setScale(0)
        bestScoreLabel = childNode(withName: "BestScore") as? SKLabelNode!
        bestScoreLabel?.text = String(GameViewController.bestScore)

        coinCollectLabel = childNode(withName: "CoinCollect") as? SKLabelNode!
        coinCollectLabel?.text = String(GameViewController.coinCollect)
        
        let alertSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "mainsence", ofType: "mp3")!)
        
        try!AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
        try! AVAudioSession.sharedInstance().setActive(true)
        try! audioPlayer = AVAudioPlayer(contentsOf: alertSound as URL)
        audioPlayer.prepareToPlay()
        audioPlayer.numberOfLoops = -1
        if GameViewController.checkSound {
            checkSound?.texture = SKTexture(imageNamed: "check")
        } else {
            checkSound?.texture = SKTexture(imageNamed: "uncheck")
        }
        
        if GameViewController.checkMusic {
            checkMusic?.texture = SKTexture(imageNamed: "check")
            audioPlayer.play()
        } else {
            checkMusic?.texture = SKTexture(imageNamed: "uncheck")
            audioPlayer.stop()
        }
        
        if (FBSDKAccessToken.current()) != nil {
            textLogin?.text = "Log out"
            self.changePassword?.zPosition = -1
            self.textChangePassword?.zPosition = -1
        }
    }
    
    func getInfoUser(tokenLogin: String) {
//        print("tokenLoginGetUser: ", tokenLogin)
        let parametersUserInfo: Parameters = [
            "token" : tokenLogin,
            ]
        Alamofire.request("http://demo.tntechs.com.vn/manhtu/bear/api/user/info", method: .post, parameters: parametersUserInfo, encoding: JSONEncoding.default).responseJSON { (respond) in
            print("respond Login: ", respond)
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
                print("Click FB")
                if (FBSDKAccessToken.current()) == nil {
                    self.loginFBClicked()
                }
            }
            
            if atPoint(location).name == "Twitter" {
                self.loginTWClicked()
            }
            
            if atPoint(location).name == "CheckSound" {
                if GameViewController.checkSound {
                    checkSound?.texture = SKTexture(imageNamed: "uncheck")
                    GameViewController.defaults.set("mute", forKey: "checkSound")
                } else {
                    checkSound?.texture = SKTexture(imageNamed: "check")
                    GameViewController.defaults.set("sound", forKey: "checkSound")
                }
                GameViewController.checkSound = !GameViewController.checkSound
            }
            
            if atPoint(location).name == "CheckMusic" {
                if GameViewController.checkMusic {
                    audioPlayer.stop()
                    checkMusic?.texture = SKTexture(imageNamed: "uncheck")
                    GameViewController.defaults.set("mute", forKey: "checkMusic")
                } else {
                    audioPlayer.play()
                    checkMusic?.texture = SKTexture(imageNamed: "check")
                    GameViewController.defaults.set("music", forKey: "checkMusic")
                }
                GameViewController.checkMusic = !GameViewController.checkMusic
            }
            
            if atPoint(location).name == "Login" || atPoint(location).name == "TextLogin" {
                if textLogin?.text == "Login" {
                    print("login")
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
                    let loginViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    self.view?.window?.rootViewController?.present(loginViewController, animated: true, completion: nil)
                } else {
                    print("logout")
                    self.loginManager.logOut()
                    textLogin?.text = "Login"
                    self.changePassword?.zPosition = 5
                    self.textChangePassword?.zPosition = 6
                }
            }
            
            if atPoint(location).name == "Setting" {
                BGPopup?.run(SKAction.unhide())
                BGSetting?.run(SKAction.unhide())
                BGSetting?.run(SKAction.group([SKAction.scaleX(to: scaleXSetting, duration: 0.3), SKAction.scaleY(to: scaleYSetting, duration: 0.3)]))
            }
            
            if atPoint(location).name == "CloseSetting" || atPoint(location).name == "BGPopup" || atPoint(location).name == "CloseHighScore" {
                BGSetting?.run(SKAction.sequence([SKAction.scale(to: 0, duration: 0.3), SKAction.hide()]))
                BGHighScore?.run(SKAction.sequence([SKAction.scale(to: 0, duration: 0.3), SKAction.hide()]))
                BGPopup?.run(SKAction.hide())
            }
            
            if atPoint(location).name == "HighScore" {
//                print("High Score")
                
                BGPopup?.run(SKAction.unhide())
                BGHighScore?.run(SKAction.unhide())
                BGHighScore?.run(SKAction.scale(to: scaleHighScore, duration: 0.3))
            }
            
            if atPoint(location).name == "ShareFB" {
                let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
                content.contentURL = NSURL(string: "https://www.google.com.vn/?gfe_rd=cr&dcr=0&ei=KwKeWpeRPI3j8weWlZjQAQ")! as URL
                FBSDKShareDialog.show(from: self.view?.window?.rootViewController, with: content, delegate: nil)
            }
        }
    }
    
    fileprivate func loginTWClicked() {
        TWTRTwitter.sharedInstance().logIn {(session, error) in
            if session != nil {
                if let s = session {
                    let client = TWTRAPIClient()
                    
                    client.loadUser(withID: s.userID, completion: { (user, error) in
                        print("user twitter: ", user as Any)
                    })
                }
            } else {
                print("Failed to login via Twitter: ", error as Any)
            }
        }
    }
    
    
    func loginFBClicked() {
        self.loginManager.logIn(withReadPermissions: ["email", "public_profile", "user_friends"], from: view?.window?.rootViewController) { (loginResult, error) -> Void  in
            if (error == nil) {
                let fbloginresult : FBSDKLoginManagerLoginResult = loginResult!
                
                if(fbloginresult.isCancelled) {
                    print("User press cancel")
                    //Show Cancel alert
                } else if(fbloginresult.grantedPermissions.contains("public_profile") && fbloginresult.grantedPermissions.contains("email") && fbloginresult.grantedPermissions.contains("user_friends")) {
                    self.textLogin?.text = "Log out"
                    self.changePassword?.zPosition = -1
                    self.textChangePassword?.zPosition = -1
                    self.returnUserData()
                    //fbLoginManager.logOut()
                }
            }
        }
    }
    
//    func didLogIn() {
//        if((FBSDKAccessToken.current()) != nil){
//            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
//                if (error == nil){
//                    self.dict = result as! [String : AnyObject]
//                    self.alertLogout = UIAlertController(title: "Hello, \(self.dict["name"]!)", message: "", preferredStyle: .actionSheet)
//
//                    let logoutAction = UIAlertAction(title: "Log out", style: .destructive, handler: { (action) in
//                        self.loginManager.logOut()
//                    })
//
//                    let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
//                        print("Cancel log out")
//                    })
//
//                    self.alertLogout?.addAction(logoutAction)
//                    self.alertLogout?.addAction(cancelAction)
//
//                    self.view?.window?.rootViewController?.present(self.alertLogout!, animated: true, completion: nil)
//
//                    print(result as Any)
//                }
//            })
//        }
//    }
    
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
