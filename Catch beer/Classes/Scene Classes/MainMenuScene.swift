//
//  MainMenuScene.swift
//  Catch beer
//
//  Created by Xuan Tu on 1/29/18.
//  Copyright © 2018 TnTechs. All rights reserved.
//
import UIKit
import SpriteKit
import AVFoundation
import FBSDKLoginKit
import TwitterKit
import FBSDKShareKit
import Toast_Swift
import Alamofire

class MainMenuScene: SKScene, TWTRComposerViewControllerDelegate {
    
    static var sharedInstance = MainMenuScene()
    
    var bestScoreLabel: SKLabelNode?
    var coinCollectLabel: SKLabelNode?
    var audioPlayer = AVAudioPlayer()
    var alertLogout: UIAlertController?
    var dict : [String : AnyObject]!
    let loginManager = FBSDKLoginManager()
    var BGPopup, BGSetting, avatar, checkMusic, checkSound, checkNotification, BGHighScore, changePassword, BGShop, ShopItem, ShopCoin, ShopOrder, item, coin, order, avatarNo1, avatarNo2, avatarNo3, avatarNo4, avatarNo5, avatarNo6, avatarNo7, avatarNo8, avatarNo9, avatarNo10, editName: SKSpriteNode?
    var username, textLogin, textChangePassword, usernameNo1, usernameNo2, usernameNo3, usernameNo4, usernameNo5, usernameNo6, usernameNo7, usernameNo8, usernameNo9, usernameNo10, usernameBorderNo1, usernameBorderNo2, usernameBorderNo3, usernameBorderNo4, usernameBorderNo5, usernameBorderNo6, usernameBorderNo7, usernameBorderNo8, usernameBorderNo9, usernameBorderNo10, scoreNo1, scoreNo2, scoreNo3, scoreNo4, scoreNo5, scoreNo6, scoreNo7, scoreNo8, scoreNo9, scoreNo10, scoreBorderNo1, scoreBorderNo2, scoreBorderNo3, scoreBorderNo4, scoreBorderNo5, scoreBorderNo6, scoreBorderNo7, scoreBorderNo8, scoreBorderNo9, scoreBorderNo10, quantityItemHeart, quantityItemBom, quantityItemCoin, quantityItemSlow, quantityItemProtect, quantityOrderHeart, quantityOrderBom, quantityOrderCoin, quantityOrderSlow, quantityOrderProtect: SKLabelNode?
    let scaleXSetting = GetSceneForDevice().getScaleSetting(deviceName: UIDevice().modelName).x
    let scaleYSetting = GetSceneForDevice().getScaleSetting(deviceName: UIDevice().modelName).y
    let scaleHighScore = GetSceneForDevice().getScaleHighScore(deviceName: UIDevice().modelName)
    let scaleShop = GetSceneForDevice().getScaleShop(deviceName: UIDevice().modelName)
    var userNameHighScore = [String](repeating: "", count: 10)
    var scoreHighScore = [String](repeating: "", count: 10)
    var textField: UITextField?
    var checkEdit = true
    
    
    // create loading view
    let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    override func didMove(to view: SKView) {
        MainMenuScene.sharedInstance = self
//        print("did move")
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
        editName = BGSetting?.childNode(withName: "EditName") as? SKSpriteNode
        BGPopup?.run(SKAction.hide())
        BGSetting?.run(SKAction.hide())
        BGSetting?.setScale(0)
        
        
        BGHighScore = childNode(withName: "BGHighScore") as? SKSpriteNode
        BGHighScore?.run(SKAction.hide())
        BGHighScore?.setScale(0)
        
        avatarNo1 = BGHighScore?.childNode(withName: "AvatarNo1") as? SKSpriteNode
        avatarNo2 = BGHighScore?.childNode(withName: "AvatarNo2") as? SKSpriteNode
        avatarNo3 = BGHighScore?.childNode(withName: "AvatarNo3") as? SKSpriteNode
        avatarNo4 = BGHighScore?.childNode(withName: "AvatarNo4") as? SKSpriteNode
        avatarNo5 = BGHighScore?.childNode(withName: "AvatarNo5") as? SKSpriteNode
        avatarNo6 = BGHighScore?.childNode(withName: "AvatarNo6") as? SKSpriteNode
        avatarNo7 = BGHighScore?.childNode(withName: "AvatarNo7") as? SKSpriteNode
        avatarNo8 = BGHighScore?.childNode(withName: "AvatarNo8") as? SKSpriteNode
        avatarNo9 = BGHighScore?.childNode(withName: "AvatarNo9") as? SKSpriteNode
        avatarNo10 = BGHighScore?.childNode(withName: "AvatarNo10") as? SKSpriteNode
        
        usernameNo1 = BGHighScore?.childNode(withName: "UsernameNo1") as? SKLabelNode
        usernameNo2 = BGHighScore?.childNode(withName: "UsernameNo2") as? SKLabelNode
        usernameNo3 = BGHighScore?.childNode(withName: "UsernameNo3") as? SKLabelNode
        usernameNo4 = BGHighScore?.childNode(withName: "UsernameNo4") as? SKLabelNode
        usernameNo5 = BGHighScore?.childNode(withName: "UsernameNo5") as? SKLabelNode
        usernameNo6 = BGHighScore?.childNode(withName: "UsernameNo6") as? SKLabelNode
        usernameNo7 = BGHighScore?.childNode(withName: "UsernameNo7") as? SKLabelNode
        usernameNo8 = BGHighScore?.childNode(withName: "UsernameNo8") as? SKLabelNode
        usernameNo9 = BGHighScore?.childNode(withName: "UsernameNo9") as? SKLabelNode
        usernameNo10 = BGHighScore?.childNode(withName: "UsernameNo10") as? SKLabelNode
        
        usernameBorderNo1 = BGHighScore?.childNode(withName: "UsernameBorderNo1") as? SKLabelNode
        usernameBorderNo2 = BGHighScore?.childNode(withName: "UsernameBorderNo2") as? SKLabelNode
        usernameBorderNo3 = BGHighScore?.childNode(withName: "UsernameBorderNo3") as? SKLabelNode
        usernameBorderNo4 = BGHighScore?.childNode(withName: "UsernameBorderNo4") as? SKLabelNode
        usernameBorderNo5 = BGHighScore?.childNode(withName: "UsernameBorderNo5") as? SKLabelNode
        usernameBorderNo6 = BGHighScore?.childNode(withName: "UsernameBorderNo6") as? SKLabelNode
        usernameBorderNo7 = BGHighScore?.childNode(withName: "UsernameBorderNo7") as? SKLabelNode
        usernameBorderNo8 = BGHighScore?.childNode(withName: "UsernameBorderNo8") as? SKLabelNode
        usernameBorderNo9 = BGHighScore?.childNode(withName: "UsernameBorderNo9") as? SKLabelNode
        usernameBorderNo10 = BGHighScore?.childNode(withName: "UsernameBorderNo10") as? SKLabelNode
        
        scoreNo1 = BGHighScore?.childNode(withName: "ScoreNo1") as? SKLabelNode
        scoreNo2 = BGHighScore?.childNode(withName: "ScoreNo2") as? SKLabelNode
        scoreNo3 = BGHighScore?.childNode(withName: "ScoreNo3") as? SKLabelNode
        scoreNo4 = BGHighScore?.childNode(withName: "ScoreNo4") as? SKLabelNode
        scoreNo5 = BGHighScore?.childNode(withName: "ScoreNo5") as? SKLabelNode
        scoreNo6 = BGHighScore?.childNode(withName: "ScoreNo6") as? SKLabelNode
        scoreNo7 = BGHighScore?.childNode(withName: "ScoreNo7") as? SKLabelNode
        scoreNo8 = BGHighScore?.childNode(withName: "ScoreNo8") as? SKLabelNode
        scoreNo9 = BGHighScore?.childNode(withName: "ScoreNo9") as? SKLabelNode
        scoreNo10 = BGHighScore?.childNode(withName: "ScoreNo10") as? SKLabelNode
        
        scoreBorderNo1 = BGHighScore?.childNode(withName: "ScoreBorderNo1") as? SKLabelNode
        scoreBorderNo2 = BGHighScore?.childNode(withName: "ScoreBorderNo2") as? SKLabelNode
        scoreBorderNo3 = BGHighScore?.childNode(withName: "ScoreBorderNo3") as? SKLabelNode
        scoreBorderNo4 = BGHighScore?.childNode(withName: "ScoreBorderNo4") as? SKLabelNode
        scoreBorderNo5 = BGHighScore?.childNode(withName: "ScoreBorderNo5") as? SKLabelNode
        scoreBorderNo6 = BGHighScore?.childNode(withName: "ScoreBorderNo6") as? SKLabelNode
        scoreBorderNo7 = BGHighScore?.childNode(withName: "ScoreBorderNo7") as? SKLabelNode
        scoreBorderNo8 = BGHighScore?.childNode(withName: "ScoreBorderNo8") as? SKLabelNode
        scoreBorderNo9 = BGHighScore?.childNode(withName: "ScoreBorderNo9") as? SKLabelNode
        scoreBorderNo10 = BGHighScore?.childNode(withName: "ScoreBorderNo10") as? SKLabelNode
        
        BGShop = childNode(withName: "BGShop") as? SKSpriteNode
        BGShop?.run(SKAction.hide())
        BGShop?.setScale(0)
        ShopItem = BGShop?.childNode(withName: "ShopItem") as? SKSpriteNode
        ShopCoin = BGShop?.childNode(withName: "ShopCoin") as? SKSpriteNode
        ShopOrder = BGShop?.childNode(withName: "ShopOrder") as? SKSpriteNode
        item = BGShop?.childNode(withName: "Item") as? SKSpriteNode
        item?.run(SKAction.hide())
        coin = BGShop?.childNode(withName: "Coin") as? SKSpriteNode
        coin?.run(SKAction.hide())
        order = BGShop?.childNode(withName: "Order") as? SKSpriteNode
        order?.run(SKAction.hide())
        
        quantityItemHeart = item?.childNode(withName: "QuantityItemHeart") as? SKLabelNode
        quantityItemBom = item?.childNode(withName: "QuantityItemBom") as? SKLabelNode
        quantityItemCoin = item?.childNode(withName: "QuantityItemCoin") as? SKLabelNode
        quantityItemSlow = item?.childNode(withName: "QuantityItemSlow") as? SKLabelNode
        quantityItemProtect = item?.childNode(withName: "QuantityItemProtect") as? SKLabelNode
        
        quantityOrderHeart = order?.childNode(withName: "QuantityOrderHeart") as? SKLabelNode
        quantityOrderBom = order?.childNode(withName: "QuantityOrderBom") as? SKLabelNode
        quantityOrderCoin = order?.childNode(withName: "QuantityOrderCoin") as? SKLabelNode
        quantityOrderSlow = order?.childNode(withName: "QuantityOrderSlow") as? SKLabelNode
        quantityOrderProtect = order?.childNode(withName: "QuantityOrderProtect") as? SKLabelNode
        
        bestScoreLabel = childNode(withName: "BestScore") as? SKLabelNode!
        bestScoreLabel?.text = String(GameViewController.bestScore)

        coinCollectLabel = childNode(withName: "CoinCollect") as? SKLabelNode!
        if GameViewController.coinCollect > 99999 {
            coinCollectLabel?.fontSize = 40
        }
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
        
        if let _ = defaults.string(forKey: "tokenLogin") {
            if FBSDKAccessToken.current() != nil || TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers() {
                self.changePassword?.zPosition = -1
                self.textChangePassword?.zPosition = -1
                textLogin?.text = "Log out"
            } else {
                self.changePassword?.zPosition = 5
                self.textChangePassword?.zPosition = 6
                textLogin?.text = "Login"
            }
        } else {
            self.changePassword?.zPosition = -1
            self.textChangePassword?.zPosition = -1
            textLogin?.text = "Login"
        }
        
//        let textFieldFrame = CGRect(origin: CGPoint(x: username!.position.x + (self.frame.size.width / 2),y: -username!.position.y + (self.frame.size.height / 2)), size: CGSize(width: 200, height: 30))
////        let textFieldFrame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 200, height: 30))
//        let textField = UITextField(frame: textFieldFrame)
//        textField.layer.anchorPoint = CGPoint(x: 1, y: 1)
//        textField.backgroundColor = UIColor.red
//        textField.placeholder = "hello world"
//        self.view?.addSubview(textField)
    }
    
    func handleGetUserInfo() {
        if let tokenLogin = defaults.string(forKey: "tokenLogin") {
            //            print("tokenLogin: ", tokenLogin) // Some String Value

            activityIndicatorView.color = UIColor.black
            self.view?.addSubview(activityIndicatorView)
            activityIndicatorView.frame = (self.view?.frame)!
            activityIndicatorView.center = (self.view?.center)!
            activityIndicatorView.startAnimating()

            // call get info user
            getInfoUser(tokenLogin: tokenLogin)
        } else {
            self.view?.makeToast("You are not login", duration: 3.0, position: .bottom)
        }
    }
    
    func getInfoUser(tokenLogin: String) {
//        print("tokenLoginGetUser: ", tokenLogin)
        
        
        let parametersUserInfo: Parameters = [
            "token" : tokenLogin,
            ]
        
        Alamofire.request("http://demo.tntechs.com.vn/manhtu/bear/api/user/info", method: .post, parameters: parametersUserInfo, encoding: JSONEncoding.default).responseJSON { (respond) in
            if let respondData = respond.result.value as! [String: Any]? {
                if (respondData["state"] as? String) ?? "" == "error" {
                    if (respondData["token"] != nil) {
                        // save tokenLogin to local
                        defaults.set(respondData["token"] as! String, forKey: "tokenLogin")
                        self.getInfoUser(tokenLogin: respondData["token"] as! String)
                    } else {
                        defaults.removeObject(forKey: "tokenLogin")
                        self.activityIndicatorView.stopAnimating()
                        self.view?.makeToast("You are not login", duration: 1.5, position: .bottom)
                    }
                    
                } else if (respondData["state"] as? String) ?? "" == "Success" {
                    // success
                    //Automatic login
                    userInfo = respondData["result"] as! [String : Any]
                    
                    self.username?.text = userInfo["email"] as? String
                    self.textLogin?.text = "Log out"
                    
                    self.view?.makeToast("Welcome \(String(describing: userInfo["email"] as! String))", duration: 1.5, position: .bottom)
                    self.activityIndicatorView.stopAnimating()
                    
//                    self.activityIndicatorView.stopAnimating()
                }
                
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "EditName" {
                if checkEdit {
                    print("Edit")
                    username?.zPosition = -1
                    editName?.texture = SKTexture(imageNamed: "done_edit")
                    let textFieldFrame = CGRect(origin: CGPoint(x: username!.position.x + (self.frame.size.width / 2),y: -username!.position.y + (self.frame.size.height / 2)), size: CGSize(width: BGSetting!.size.width / 3, height: 50))
                    textField = UITextField(frame: textFieldFrame)
                    textField?.layer.anchorPoint = CGPoint(x: 1, y: 1)
                    textField?.backgroundColor = UIColor.white
                    textField?.layer.borderWidth = 1
                    textField?.layer.borderColor = UIColor.black.cgColor
                    textField?.font = UIFont(name: "Comic Book", size: 30)
                    textField?.text = username?.text
                    self.view?.addSubview(textField!)
                    checkEdit = false
                } else {
                    print("done")
                    username?.text = textField?.text
                    username?.zPosition = 5
                    editName?.texture = SKTexture(imageNamed: "button-edit")
                    textField?.removeFromSuperview()
                    checkEdit = true
                }
            }
            
            if atPoint(location).name == "Start" {
                if let scene = GameplaySceneClass(fileNamed: GetSceneForDevice().getScene(deviceName: UIDevice().modelName)[1]) {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    audioPlayer.stop()
                    // Present the scene
                    view!.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: TimeInterval(2)))
                }
            }
            // login fb
            if atPoint(location).name == "Facebook" {
                print("Click FB")
                if (FBSDKAccessToken.current()) == nil {
                    self.loginFBClicked()
                }
            }
            //login twiter
            if atPoint(location).name == "Twitter" {
                if !TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers() {
                    self.loginTWClicked()
                }
            }
            //turn on/off sound effect
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
            //turn on/off music
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
            //login with email & password
            if atPoint(location).name == "Login" || atPoint(location).name == "TextLogin" {
                if textLogin?.text == "Login" {
                    print("login")
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
                    let loginViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    self.view?.window?.rootViewController?.present(loginViewController, animated: true, completion: nil)
                } else {
                    print("logout")
                    if FBSDKAccessToken.current() != nil {
                        self.loginManager.logOut()
                    }
                    if TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers() {
                        TWTRTwitter.sharedInstance().sessionStore.logOutUserID(TWTRTwitter.sharedInstance().sessionStore.session()!.userID)
                    }
                    defaults.removeObject(forKey: "tokenLogin")
                    userInfo = [:]
                    self.username?.text = "Username"
                    textLogin?.text = "Login"
                    self.changePassword?.zPosition = -1
                    self.textChangePassword?.zPosition = -1
                }
            }
            //open setting
            if atPoint(location).name == "Setting" {
                BGPopup?.run(SKAction.unhide())
                BGSetting?.run(SKAction.unhide())
                BGSetting?.run(SKAction.group([SKAction.scaleX(to: scaleXSetting, duration: 0.3), SKAction.scaleY(to: scaleYSetting, duration: 0.3)]))
            }
            
            //ChangePassword
            
            if atPoint(location).name == "ChangePassword" || atPoint(location).name == "TextChangePassword" {
                print("ChangePassword")
                let storyBoard: UIStoryboard = UIStoryboard(name: "ChangePassword", bundle: nil)
                let ChangePasswordViewController = storyBoard.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordViewController
                self.view?.window?.rootViewController?.present(ChangePasswordViewController, animated: true, completion: nil)
            }
            
            if atPoint(location).name == "CloseSetting" || atPoint(location).name == "BGPopup" || atPoint(location).name == "CloseHighScore" || atPoint(location).name == "CloseShop" {
                BGSetting?.run(SKAction.sequence([SKAction.scale(to: 0, duration: 0.3), SKAction.hide()]))
                BGHighScore?.run(SKAction.sequence([SKAction.scale(to: 0, duration: 0.3), SKAction.hide()]))
                BGShop?.run(SKAction.sequence([SKAction.scale(to: 0, duration: 0.3), SKAction.hide()]))
                BGPopup?.run(SKAction.hide())
            }
            //open highscore
            if atPoint(location).name == "HighScore" {
//                print("High Score")
                
                //create loading view
                let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
                activityIndicatorView.color = UIColor.black
                self.view?.addSubview(activityIndicatorView)
                activityIndicatorView.frame = self.view!.frame
                activityIndicatorView.center = self.view!.center
                activityIndicatorView.startAnimating()
                
                if let tokenLogin = defaults.string(forKey: "tokenLogin") {
                    
                    let parametersBestScore: Parameters = [
                        "token" : tokenLogin,
                        ]
                    
                    Alamofire.request("http://demo.tntechs.com.vn/manhtu/bear/api/user/top-best-score", method: .post, parameters: parametersBestScore, encoding: JSONEncoding.default).responseJSON(completionHandler: { (resBestScore) in
                        if let respondBestScore = resBestScore.result.value as! [String: Any]? {
                            if (respondBestScore["state"] as? String) ?? "" == "error" {
                                activityIndicatorView.stopAnimating()
                                self.view?.makeToast(respondBestScore["message"] as? String, duration: 3.0, position: .bottom)
                            } else if (respondBestScore["state"] as? String) ?? "" == "Success" {
                                if let arrBestScore = respondBestScore["data"] as! [[String:Any]]? {
                                    for i in 0...arrBestScore.count - 1 {
                                        let email = arrBestScore[i]["email"] as! String
//                                        print("check email", "\(String(email.prefix(6)))...")
                                        self.userNameHighScore[i] = "\(String(email.prefix(6)))..."
                                        let highScore = arrBestScore[i]["best_score"] as! Int
//                                        print("check high score", highScore)
                                        self.scoreHighScore[i] = String(highScore)
                                    }
                                }
                                self.setData()
                                activityIndicatorView.stopAnimating()
                                self.BGPopup?.run(SKAction.unhide())
                                self.BGHighScore?.run(SKAction.unhide())
                                self.BGHighScore?.run(SKAction.scale(to: self.scaleHighScore, duration: 0.3))
                            }
                        }
                    })
                } else {
                    Alamofire.request("http://demo.tntechs.com.vn/manhtu/bear/api/best-score", method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON(completionHandler: { (resBestScore) in
                        if let respondBestScore = resBestScore.result.value as! [String: Any]? {
                            if (respondBestScore["state"] as? String) ?? "" == "error" {
                                activityIndicatorView.stopAnimating()
                                self.view?.makeToast(respondBestScore["message"] as? String, duration: 3.0, position: .bottom)
                            } else if (respondBestScore["state"] as? String) ?? "" == "Success" {
                                if let arrBestScore = respondBestScore["data"] as! [[String:Any]]? {
                                    for i in 0...arrBestScore.count - 1 {
                                        let name = arrBestScore[i]["name"] as! String
                                        //                                        print("check email", "\(String(email.prefix(6)))...")
                                        self.userNameHighScore[i] = "\(String(name.prefix(6)))..."
                                        let highScore = arrBestScore[i]["best_score"] as! Int
                                        //                                        print("check high score", highScore)
                                        self.scoreHighScore[i] = String(highScore)
                                    }
                                }
                                self.setData()
                                activityIndicatorView.stopAnimating()
                                self.BGPopup?.run(SKAction.unhide())
                                self.BGHighScore?.run(SKAction.unhide())
                                self.BGHighScore?.run(SKAction.scale(to: self.scaleHighScore, duration: 0.3))
                            }
                        }
                    })
                }
            }
            //share fb
            if atPoint(location).name == "ShareFB" {
                let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
                content.contentURL = NSURL(string: "https://www.google.com.vn/?gfe_rd=cr&dcr=0&ei=KwKeWpeRPI3j8weWlZjQAQ")! as URL
                FBSDKShareDialog.show(from: self.view?.window?.rootViewController, with: content, delegate: nil)
            }
            //share twiter
            if atPoint(location).name == "ShareTwiter" {
                if (TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers()) {
                    // App must have at least one logged-in user to compose a Tweet
                    let appURL = NSURL(string: "https://www.google.com.vn/?gfe_rd=cr&dcr=0&ei=KwKeWpeRPI3j8weWlZjQAQ")! as URL
                    let composer = TWTRComposer()
                    composer.setURL(appURL)
                    composer.show(from: (self.view?.window?.rootViewController)!, completion: { (result) in
                        if result == .done {
                            print("done")
                        } else {
                            print("cancel")
                        }
                    })
                } else {
                    // Log in, and then check again
                    TWTRTwitter.sharedInstance().logIn { session, error in
                        if session != nil { // Log in succeeded
                            let appURL = NSURL(string: "https://www.google.com.vn/?gfe_rd=cr&dcr=0&ei=KwKeWpeRPI3j8weWlZjQAQ")! as URL
                            let composer = TWTRComposer()
                            composer.setURL(appURL)
                            composer.show(from: (self.view?.window?.rootViewController)!, completion: { (result) in
                                if result == .done {
                                    print("done")
                                } else {
                                    print("cancel")
                                }
                            })
                        } else {
                            let alert = UIAlertController(title: "No Twitter Accounts Available", message: "You must log in before presenting a composer.", preferredStyle: .alert)
                            self.view?.window?.rootViewController?.present(alert, animated: false, completion: nil)
                        }
                    }
                }
            }
            
            //open shop
            if atPoint(location).name == "Shop" {
                
                if defaults.integer(forKey: "itemHeart") > 0 {
                    quantityItemHeart?.text = "x\(String(defaults.integer(forKey: "itemHeart")))"
                } else {
                    quantityItemHeart?.text = ""
                }
                
                if defaults.integer(forKey: "itemBom") > 0 {
                    quantityItemBom?.text = "x\(String(defaults.integer(forKey: "itemBom")))"
                } else {
                    quantityItemBom?.text = ""
                }
                
                if defaults.integer(forKey: "itemCoin") > 0 {
                    quantityItemCoin?.text = "x\(String(defaults.integer(forKey: "itemCoin")))"
                } else {
                    quantityItemCoin?.text = ""
                }
                
                if defaults.integer(forKey: "itemSlow") > 0 {
                    quantityItemSlow?.text = "x\(String(defaults.integer(forKey: "itemSlow")))"
                } else {
                    quantityItemSlow?.text = ""
                }
                
                if defaults.integer(forKey: "itemProtect") > 0 {
                    quantityItemProtect?.text = "x\(String(defaults.integer(forKey: "itemProtect")))"
                } else {
                    quantityItemProtect?.text = ""
                }
                
                BGPopup?.run(SKAction.unhide())
                BGShop?.run(SKAction.unhide())
                ShopItem?.size = CGSize(width: 190, height: 70)
                ShopItem?.position = CGPoint(x: -200, y: 238)
                item?.run(SKAction.unhide())
                ShopCoin?.size = CGSize(width: 190, height: 55)
                ShopCoin?.position = CGPoint(x: 0, y: 231)
                coin?.run(SKAction.hide())
                
                ShopOrder?.size = CGSize(width: 190, height: 55)
                ShopOrder?.position = CGPoint(x: 200, y: 231)
                order?.run(SKAction.hide())
                BGShop?.run(SKAction.scale(to: scaleShop, duration: 0.3))
            }
            
            //buy heart
            if atPoint(location).name == "Heart" {
                if defaults.integer(forKey: "coinCollect") > 50 {
                    defaults.set(defaults.integer(forKey: "itemHeart") + 1, forKey: "itemHeart")
                    quantityItemHeart?.text = "x\(String(defaults.integer(forKey: "itemHeart")))"
                    defaults.set(defaults.integer(forKey: "coinCollect") - 50, forKey: "coinCollect")
                    if defaults.integer(forKey: "coinCollect") > 99999 {
                        coinCollectLabel?.fontSize = 40
                    } else {
                        coinCollectLabel?.fontSize = 45
                    }
                    coinCollectLabel?.text = String(defaults.integer(forKey: "coinCollect"))
                    defaults.set(defaults.integer(forKey: "orderHeart") + 1, forKey: "orderHeart")
                }
            }
            
            //buy bom
            if atPoint(location).name == "Bom" {
                if defaults.integer(forKey: "coinCollect") > 100 {
                    defaults.set(defaults.integer(forKey: "itemBom") + 1, forKey: "itemBom")
                    quantityItemBom?.text = "x\(String(defaults.integer(forKey: "itemBom")))"
                    defaults.set(defaults.integer(forKey: "coinCollect") - 100, forKey: "coinCollect")
                    if defaults.integer(forKey: "coinCollect") > 99999 {
                        coinCollectLabel?.fontSize = 40
                    } else {
                        coinCollectLabel?.fontSize = 45
                    }
                    coinCollectLabel?.text = String(defaults.integer(forKey: "coinCollect"))
                    defaults.set(defaults.integer(forKey: "orderBom") + 1, forKey: "orderBom")
                }
            }
            
            //buy coin
            if atPoint(location).name == "Coin" {
                if defaults.integer(forKey: "coinCollect") > 160 {
                    defaults.set(defaults.integer(forKey: "itemCoin") + 1, forKey: "itemCoin")
                    quantityItemCoin?.text = "x\(String(defaults.integer(forKey: "itemCoin")))"
                    defaults.set(defaults.integer(forKey: "coinCollect") - 160, forKey: "coinCollect")
                    if defaults.integer(forKey: "coinCollect") > 99999 {
                        coinCollectLabel?.fontSize = 40
                    } else {
                        coinCollectLabel?.fontSize = 45
                    }
                    coinCollectLabel?.text = String(defaults.integer(forKey: "coinCollect"))
                    defaults.set(defaults.integer(forKey: "orderCoin") + 1, forKey: "orderCoin")
                }
            }
            
            //buy slow
            if atPoint(location).name == "Slow" {
                if defaults.integer(forKey: "coinCollect") > 200 {
                    defaults.set(defaults.integer(forKey: "itemSlow") + 1, forKey: "itemSlow")
                    quantityItemSlow?.text = "x\(String(defaults.integer(forKey: "itemSlow")))"
                    defaults.set(defaults.integer(forKey: "coinCollect") - 200, forKey: "coinCollect")
                    if defaults.integer(forKey: "coinCollect") > 99999 {
                        coinCollectLabel?.fontSize = 40
                    } else {
                        coinCollectLabel?.fontSize = 45
                    }
                    coinCollectLabel?.text = String(defaults.integer(forKey: "coinCollect"))
                    defaults.set(defaults.integer(forKey: "orderSlow") + 1, forKey: "orderSlow")
                }
            }
            
            //buy protect
            if atPoint(location).name == "Protect" {
                if defaults.integer(forKey: "coinCollect") > 250 {
                    defaults.set(defaults.integer(forKey: "itemProtect") + 1, forKey: "itemProtect")
                    quantityItemProtect?.text = "x\(String(defaults.integer(forKey: "itemProtect")))"
                    defaults.set(defaults.integer(forKey: "coinCollect") - 250, forKey: "coinCollect")
                    if defaults.integer(forKey: "coinCollect") > 99999 {
                        coinCollectLabel?.fontSize = 40
                    } else {
                        coinCollectLabel?.fontSize = 45
                    }
                    coinCollectLabel?.text = String(defaults.integer(forKey: "coinCollect"))
                    defaults.set(defaults.integer(forKey: "orderProtect") + 1, forKey: "orderProtect")
                }
            }
            
            //open tab shop item
            if atPoint(location).name == "ShopItem" || atPoint(location).name == "TextShopItem" {
                ShopItem?.size = CGSize(width: 190, height: 70)
                ShopItem?.position = CGPoint(x: -200, y: 238)
                item?.run(SKAction.unhide())
                
                ShopCoin?.size = CGSize(width: 190, height: 55)
                ShopCoin?.position = CGPoint(x: 0, y: 231)
                coin?.run(SKAction.hide())
                
                ShopOrder?.size = CGSize(width: 190, height: 55)
                ShopOrder?.position = CGPoint(x: 200, y: 231)
                order?.run(SKAction.hide())
            }
            
            //buy 100 coin
            if atPoint(location).name == "Coin1" {
                defaults.set(defaults.integer(forKey: "coinCollect") + 100, forKey: "coinCollect")
                if defaults.integer(forKey: "coinCollect") > 99999 {
                    coinCollectLabel?.fontSize = 40
                }
                coinCollectLabel?.text = String(defaults.integer(forKey: "coinCollect"))
            }
            
            //buy 500 coin
            if atPoint(location).name == "Coin2" {
                defaults.set(defaults.integer(forKey: "coinCollect") + 500, forKey: "coinCollect")
                if defaults.integer(forKey: "coinCollect") > 99999 {
                    coinCollectLabel?.fontSize = 40
                }
                coinCollectLabel?.text = String(defaults.integer(forKey: "coinCollect"))
            }
            
            //buy 1000 coin
            if atPoint(location).name == "Coin3" {
                defaults.set(defaults.integer(forKey: "coinCollect") + 1000, forKey: "coinCollect")
                if defaults.integer(forKey: "coinCollect") > 99999 {
                    coinCollectLabel?.fontSize = 40
                }
                coinCollectLabel?.text = String(defaults.integer(forKey: "coinCollect"))
            }
            
            //buy 1800 coin
            if atPoint(location).name == "Coin4" {
                defaults.set(defaults.integer(forKey: "coinCollect") + 1800, forKey: "coinCollect")
                if defaults.integer(forKey: "coinCollect") > 99999 {
                    coinCollectLabel?.fontSize = 40
                }
                coinCollectLabel?.text = String(defaults.integer(forKey: "coinCollect"))
            }
            
            //buy 2490 coin
            if atPoint(location).name == "Coin5" {
                defaults.set(defaults.integer(forKey: "coinCollect") + 2490, forKey: "coinCollect")
                if defaults.integer(forKey: "coinCollect") > 99999 {
                    coinCollectLabel?.fontSize = 40
                }
                coinCollectLabel?.text = String(defaults.integer(forKey: "coinCollect"))
            }
            
            //open tab shop coin
            if atPoint(location).name == "ShopCoin" || atPoint(location).name == "TextShopCoin" {
                ShopItem?.size = CGSize(width: 190, height: 55)
                ShopItem?.position = CGPoint(x: -200, y: 231)
                item?.run(SKAction.hide())
                
                ShopCoin?.size = CGSize(width: 190, height: 70)
                ShopCoin?.position = CGPoint(x: 0, y: 238)
                coin?.run(SKAction.unhide())
                
                ShopOrder?.size = CGSize(width: 190, height: 55)
                ShopOrder?.position = CGPoint(x: 200, y: 231)
                order?.run(SKAction.hide())
            }
            
            
            
            //open tab shop order
            if atPoint(location).name == "ShopOrder" || atPoint(location).name == "TextShopOrder" {
                
                quantityOrderHeart?.text = "x\(String(defaults.integer(forKey: "orderHeart")))"
                quantityOrderBom?.text = "x\(String(defaults.integer(forKey: "orderBom")))"
                quantityOrderCoin?.text = "x\(String(defaults.integer(forKey: "orderCoin")))"
                quantityOrderSlow?.text = "x\(String(defaults.integer(forKey: "orderSlow")))"
                quantityOrderProtect?.text = "x\(String(defaults.integer(forKey: "orderProtect")))"
                
                ShopItem?.size = CGSize(width: 190, height: 55)
                ShopItem?.position = CGPoint(x: -200, y: 231)
                item?.run(SKAction.hide())
                
                ShopCoin?.size = CGSize(width: 190, height: 55)
                ShopCoin?.position = CGPoint(x: 0, y: 231)
                coin?.run(SKAction.hide())
                
                ShopOrder?.size = CGSize(width: 190, height: 70)
                ShopOrder?.position = CGPoint(x: 200, y: 238)
                order?.run(SKAction.unhide())
            }
            
            
        }
    }
    //set username and score
    func setData() {
        usernameNo1?.text = userNameHighScore[0]
        usernameNo2?.text = userNameHighScore[1]
        usernameNo3?.text = userNameHighScore[2]
        usernameNo4?.text = userNameHighScore[3]
        usernameNo5?.text = userNameHighScore[4]
        usernameNo6?.text = userNameHighScore[5]
        usernameNo7?.text = userNameHighScore[6]
        usernameNo8?.text = userNameHighScore[7]
        usernameNo9?.text = userNameHighScore[8]
        usernameNo10?.text = userNameHighScore[9]
        
        usernameBorderNo1?.text = userNameHighScore[0]
        usernameBorderNo2?.text = userNameHighScore[1]
        usernameBorderNo3?.text = userNameHighScore[2]
        usernameBorderNo4?.text = userNameHighScore[3]
        usernameBorderNo5?.text = userNameHighScore[4]
        usernameBorderNo6?.text = userNameHighScore[5]
        usernameBorderNo7?.text = userNameHighScore[6]
        usernameBorderNo8?.text = userNameHighScore[7]
        usernameBorderNo9?.text = userNameHighScore[8]
        usernameBorderNo10?.text = userNameHighScore[9]
        
        scoreNo1?.text = scoreHighScore[0]
        scoreNo2?.text = scoreHighScore[1]
        scoreNo3?.text = scoreHighScore[2]
        scoreNo4?.text = scoreHighScore[3]
        scoreNo5?.text = scoreHighScore[4]
        scoreNo6?.text = scoreHighScore[5]
        scoreNo7?.text = scoreHighScore[6]
        scoreNo8?.text = scoreHighScore[7]
        scoreNo9?.text = scoreHighScore[8]
        scoreNo10?.text = scoreHighScore[9]
        
        scoreBorderNo1?.text = scoreHighScore[0]
        scoreBorderNo2?.text = scoreHighScore[1]
        scoreBorderNo3?.text = scoreHighScore[2]
        scoreBorderNo4?.text = scoreHighScore[3]
        scoreBorderNo5?.text = scoreHighScore[4]
        scoreBorderNo6?.text = scoreHighScore[5]
        scoreBorderNo7?.text = scoreHighScore[6]
        scoreBorderNo8?.text = scoreHighScore[7]
        scoreBorderNo9?.text = scoreHighScore[8]
        scoreBorderNo10?.text = scoreHighScore[9]
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
