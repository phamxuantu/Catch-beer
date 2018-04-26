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


var paymentInfo: [String: Any] = [:]

class MainMenuScene: SKScene, TWTRComposerViewControllerDelegate {
    
    static var sharedInstance = MainMenuScene()
    
    var bestScoreLabel: SKLabelNode?
    var coinCollectLabel: SKLabelNode?
    var audioPlayer = AVAudioPlayer()
    var alertLogout: UIAlertController?
    var dict : [String : AnyObject]!
    let loginManager = FBSDKLoginManager()
    var BGPopup, BGSetting, avatar, checkMusic, checkSound, checkNotification, BGHighScore, changePassword, BGShop, ShopItem, ShopCoin, ShopOrder, item, coin, order, avatarNo1, avatarNo2, avatarNo3, avatarNo4, avatarNo5, avatarNo6, avatarNo7, avatarNo8, avatarNo9, avatarNo10, editName, bgMainMenu: SKSpriteNode?
    var username, textLogin, textChangePassword, usernameNo1, usernameNo2, usernameNo3, usernameNo4, usernameNo5, usernameNo6, usernameNo7, usernameNo8, usernameNo9, usernameNo10, scoreNo1, scoreNo2, scoreNo3, scoreNo4, scoreNo5, scoreNo6, scoreNo7, scoreNo8, scoreNo9, scoreNo10, quantityItemHeart, quantityItemBom, quantityItemCoin, quantityItemSlow, quantityItemProtect, quantityOrderHeart, quantityOrderBom, quantityOrderCoin, quantityOrderSlow, quantityOrderProtect: SKLabelNode?
    let scaleXSetting = GetSceneForDevice().getScaleSetting(deviceName: UIDevice().modelName).x
    let scaleYSetting = GetSceneForDevice().getScaleSetting(deviceName: UIDevice().modelName).y
    let scaleHighScore = GetSceneForDevice().getScaleHighScore(deviceName: UIDevice().modelName)
    let scaleShop = GetSceneForDevice().getScaleShop(deviceName: UIDevice().modelName)
    var userNameHighScore = [String](repeating: "", count: 10)
    var scoreHighScore = [String](repeating: "", count: 10)
    var textField: UITextField?
    var checkEdit = true
    let fontCoinLow = GetSceneForDevice().getFontCoin(deviceName: UIDevice().modelName).low
    let fontCoinHigh = GetSceneForDevice().getFontCoin(deviceName: UIDevice().modelName).high
    
    var btnFbLogin, btnTwitter: SKSpriteNode?
    var lblConnectWith: SKLabelNode?
//    let buttonLoginFb = childNode(withName: "Facebook") as? SKSpriteNode
//    let btnLoginTwitter = childNode(withName: "Twitter") as? SKSpriteNode
    
    // create loading view
    let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    override func didMove(to view: SKView) {
        MainMenuScene.sharedInstance = self
        print("did move: \(userInfo["name"] as? String)")
//        username?.text = userInfo["name"] as! String != "" ? userInfo["name"] as! String : "Username"
        
        btnFbLogin = childNode(withName: "Facebook") as? SKSpriteNode
        btnTwitter = childNode(withName: "Twitter") as? SKSpriteNode
        lblConnectWith = childNode(withName: "lblConectWith") as? SKLabelNode
        
        bgMainMenu = childNode(withName: "MenuBG") as? SKSpriteNode
        bgMainMenu?.size.width = self.frame.size.width
        bgMainMenu?.size.height = self.frame.size.height
        
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
        
        
        if let _ = defaults.string(forKey: "tokenLogin") {
            print("vao day em oi: \(userInfo) \(username?.zPosition)")
            username?.text = userInfo["name"] as? String ?? "Username"
            username?.zPosition = 10
            editName?.texture = SKTexture(imageNamed: "button-edit")
            editName?.zPosition = 5
            print("username?.text: \(username?.text) \(username?.zPosition)")
        } else {
            username?.text = "Username"
            username?.zPosition = 5
        }
        
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
//        usernameNo1?.fontName = "CarterOne"
        usernameNo2 = BGHighScore?.childNode(withName: "UsernameNo2") as? SKLabelNode
        usernameNo3 = BGHighScore?.childNode(withName: "UsernameNo3") as? SKLabelNode
        usernameNo4 = BGHighScore?.childNode(withName: "UsernameNo4") as? SKLabelNode
        usernameNo5 = BGHighScore?.childNode(withName: "UsernameNo5") as? SKLabelNode
        usernameNo6 = BGHighScore?.childNode(withName: "UsernameNo6") as? SKLabelNode
        usernameNo7 = BGHighScore?.childNode(withName: "UsernameNo7") as? SKLabelNode
        usernameNo8 = BGHighScore?.childNode(withName: "UsernameNo8") as? SKLabelNode
        usernameNo9 = BGHighScore?.childNode(withName: "UsernameNo9") as? SKLabelNode
        usernameNo10 = BGHighScore?.childNode(withName: "UsernameNo10") as? SKLabelNode
        
        
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
        bestScoreLabel?.fontName = "Comic Book Bold"
        bestScoreLabel?.fontSize = fontCoinLow

        coinCollectLabel = childNode(withName: "CoinCollect") as? SKLabelNode!
        coinCollectLabel?.fontName = "Comic Book Bold"
        coinCollectLabel?.fontSize = fontCoinLow
        if defaults.integer(forKey: "coinCollect") > 99999 {
            coinCollectLabel?.fontSize = fontCoinHigh
        }
        coinCollectLabel?.text = String(defaults.integer(forKey: "coinCollect"))
        
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
        
//        if FBSDKAccessToken.current() != nil  {
//            username?.text = defaults.string(forKey: "nameFB")
//            textLogin?.text = "Log out"
//        }
        
        if let _ = defaults.string(forKey: "tokenLogin") {
            // check has login social
            if FBSDKAccessToken.current() != nil || TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers() {
                
                self.changePassword?.zPosition = -1
                self.textChangePassword?.zPosition = -1
                textLogin?.text = "Log out"
                
                if FBSDKAccessToken.current() != nil  {
                    username?.text = defaults.string(forKey: "nameFB")
                } // coming soon handler twiter
            } else {
                self.changePassword?.zPosition = 5
                self.textChangePassword?.zPosition = 6
                textLogin?.text = "Log out"
            }
            
            editName?.zPosition = 5
            // hide social login
            hideSocicalLogin()
        } else {
            self.changePassword?.zPosition = -1
            self.textChangePassword?.zPosition = -1
            editName?.zPosition = -2
            textLogin?.text = "Login"
            
            if FBSDKAccessToken.current() != nil || TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers() {
                print("haizzzzzzzzzz")
                LogoutSocial()
            }
            
            // unhide social login
            showSocialLogin()
            
        } // end if else let _
        
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
            self.LogoutSocial()
            self.view?.makeToast("You are not login", duration: 3.0, position: .bottom)
            self.textLogin?.text = "Login"
            
            // show social login
            showSocialLogin()
        }
    }
    
    func getInfoUser(tokenLogin: String) {
//        print("tokenLoginGetUser: ", tokenLogin)
        
        
        let parametersUserInfo: Parameters = [
            "token" : tokenLogin,
            ]
        
        Alamofire.request("http://103.28.38.10/~tngame/manhtu/bear/api/user/info", method: .post, parameters: parametersUserInfo, encoding: JSONEncoding.default).responseJSON { (respond) in
            self.activityIndicatorView.stopAnimating()
            print("handler auto login: ", respond)
            if let respondData = respond.result.value as! [String: Any]? {
                if (respondData["state"] as? String) ?? "" == "error" {
                    if (respondData["token"] != nil) {
                        // save tokenLogin to local
                        defaults.set(respondData["token"] as! String, forKey: "tokenLogin")
                        self.getInfoUser(tokenLogin: respondData["token"] as! String)
                    } else {
                        
                        defaults.set(0, forKey: "flag")
                        defaults.set(0, forKey: "itemBom")
                        defaults.set(0, forKey: "itemSlow")
                        defaults.set(0, forKey: "itemProtect")
                        defaults.set(0, forKey: "itemCoin")
                        defaults.set(0, forKey: "itemHeart")
                        defaults.set(0, forKey: "bestScore")
                        defaults.set(0, forKey: "coinCollect")
                        self.bestScoreLabel?.text = "0"
                        self.coinCollectLabel?.text = String(defaults.integer(forKey: "coinCollect"))
                        defaults.removeObject(forKey: "tokenLogin")
                        self.textLogin?.text = "Login"
//                        self.activityIndicatorView.stopAnimating()
                        self.LogoutSocial()
                        self.showSocialLogin()
                        self.view?.makeToast("You are not login", duration: 1.5, position: .bottom)
                    }
                    
                } else if (respondData["state"] as? String) ?? "" == "Success" {
                    // success
                    //Automatic login
                    userInfo = respondData["result"] as! [String : Any]
                    print("userinfor in handler login \(userInfo)")
                    self.username?.text = (userInfo["name"] != nil) ? userInfo["name"] as? String : userInfo["email"] as? String
                    self.textLogin?.text = "Log out"
                    self.bestScoreLabel?.text = String(describing: userInfo["best_score"]!)
                    self.coinCollectLabel?.text = String(describing: userInfo["remain_coin"]!)
                    defaults.set(userInfo["best_score"]!, forKey: "bestScore")
                    print("userinfor: \(defaults.integer(forKey: "bestScore"))")
                    // hide social login
                    self.hideSocicalLogin()
                    
                    self.view?.makeToast("Welcome \(self.username?.text! ?? "Username")", duration: 1.5, position: .bottom)
                }
                
            }
        }
    } // func getInfoUser
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            // edit name
            if atPoint(location).name == "EditName" {
                if checkEdit {
                    print("Edit")
                    username?.zPosition = -1
                    editName?.texture = SKTexture(imageNamed: "done_edit")
                    let textFieldFrame = CGRect(origin: CGPoint(x: username!.position.x + (self.frame.size.width / 2),y: -(username!.position.y * BGSetting!.yScale) + (self.frame.size.height / 2)), size: CGSize(width: BGSetting!.size.width / 2, height: BGSetting!.size.height / 10))
                    textField = UITextField(frame: textFieldFrame)
                    textField?.layer.anchorPoint = CGPoint(x: 1, y: 1)
                    textField?.backgroundColor = UIColor.white
//                    textField?.layer.borderWidth = 1
//                    textField?.layer.borderColor = UIColor.black.cgColor
                    textField?.becomeFirstResponder()
                    textField?.font = UIFont(name: "Comic Book", size: GetSceneForDevice().getFontUserSetting(deviceName: UIDevice().modelName))
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
                    userInfo["name"] = textField?.text
                    // update edit name to server
                    editNameHandler()
                }
            }
            
            if atPoint(location).name == "Start" {
                if let scene = GameplaySceneClass(fileNamed: GetSceneForDevice().getScene(deviceName: UIDevice().modelName)[1]) {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    audioPlayer.stop()
                    // Present the scene
                    view!.presentScene(scene, transition: SKTransition.doorsOpenHorizontal(withDuration: TimeInterval(2)))
                }
            }
            // login fb
            if atPoint(location).name == "Facebook" {
                print("Click FB")
                if (FBSDKAccessToken.current()) == nil && defaults.string(forKey: "tokenLogin") == nil {
                    self.loginFBClicked()
                }
            }
            //login twiter
            if atPoint(location).name == "Twitter" {
                if !TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers() && defaults.string(forKey: "tokenLogin") == nil {
                    self.loginTWClicked()
                }
            }
            //turn on/off sound effect
            if atPoint(location).name == "CheckSound" {
                if GameViewController.checkSound {
                    checkSound?.texture = SKTexture(imageNamed: "uncheck")
                    defaults.set("mute", forKey: "checkSound")
                } else {
                    checkSound?.texture = SKTexture(imageNamed: "check")
                    defaults.set("sound", forKey: "checkSound")
                }
                GameViewController.checkSound = !GameViewController.checkSound
            }
            //turn on/off music
            if atPoint(location).name == "CheckMusic" {
                if GameViewController.checkMusic {
                    audioPlayer.stop()
                    checkMusic?.texture = SKTexture(imageNamed: "uncheck")
                    defaults.set("mute", forKey: "checkMusic")
                } else {
                    audioPlayer.play()
                    checkMusic?.texture = SKTexture(imageNamed: "check")
                    defaults.set("music", forKey: "checkMusic")
                }
                GameViewController.checkMusic = !GameViewController.checkMusic
            }
            
            //login with email & password
            if atPoint(location).name == "Login" || atPoint(location).name == "TextLogin" {
                if textLogin?.text == "Login" {
//                    editName?.zPosition = 5
                    print("login")
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
                    let loginViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    self.view?.window?.rootViewController?.present(loginViewController, animated: true, completion: nil)
                } else {
                    print("logout")
                    activityIndicatorView.color = UIColor.black
                    self.view?.addSubview(activityIndicatorView)
                    activityIndicatorView.frame = self.view!.frame
                    activityIndicatorView.center = self.view!.center
                    activityIndicatorView.startAnimating()
                    print("token login: ", defaults.string(forKey: "tokenLogin"))
                    handlerLogout()
                } // end else
            } // end point login
            
            
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
                textField?.removeFromSuperview()
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
                
                getBestScore()
                activityIndicatorView.stopAnimating()
            } // end open high socre
            
            
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
                checkDisableBtnCoins()
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
//                ShopItem?.texture = SKTexture(imageNamed: "bgItemShopActive")
                item?.run(SKAction.unhide())
                ShopCoin?.size = CGSize(width: 190, height: 55)
                ShopCoin?.position = CGPoint(x: 0, y: 231)
//                ShopCoin?.texture = SKTexture(imageNamed: "bgCoinShop")
                coin?.run(SKAction.hide())
                
                ShopOrder?.size = CGSize(width: 190, height: 55)
                ShopOrder?.position = CGPoint(x: 200, y: 231)
//                ShopOrder?.texture = SKTexture(imageNamed: "bgOrderShop")
                order?.run(SKAction.hide())
                BGShop?.run(SKAction.scale(to: scaleShop, duration: 0.3))
            }
            
            //buy heart price: 10
            if atPoint(location).name == "Heart" {
                if defaults.integer(forKey: "coinCollect") >= 10 && defaults.integer(forKey: "itemHeart") < 999 {
                    defaults.set(defaults.integer(forKey: "itemHeart") + 1, forKey: "itemHeart")
                    quantityItemHeart?.text = "x\(String(defaults.integer(forKey: "itemHeart")))"
                    defaults.set(defaults.integer(forKey: "coinCollect") - 10, forKey: "coinCollect")
                    if defaults.integer(forKey: "coinCollect") > 99999 {
                        coinCollectLabel?.fontSize = fontCoinHigh
                    } else {
                        coinCollectLabel?.fontSize = fontCoinLow
                    }
                    coinCollectLabel?.text = String(defaults.integer(forKey: "coinCollect"))
                    defaults.set(defaults.integer(forKey: "orderHeart") + 1, forKey: "orderHeart")
                    checkDisableBtnCoins()
                } else if defaults.integer(forKey: "coinCollect") < 10 {
                    self.view?.makeToast("Do not have enough coin", duration: 2.0, position: .bottom)
                    handleClickShopItem()
                } else {
                    self.view?.makeToast("exceeds the number of items allowed", duration: 1.5, position: .bottom)
                }
            }
            
            //buy bom price: 40
            if atPoint(location).name == "Bom" {
                if defaults.integer(forKey: "coinCollect") >= 40 && defaults.integer(forKey: "itemBom") < 999 {
                    defaults.set(defaults.integer(forKey: "itemBom") + 1, forKey: "itemBom")
                    quantityItemBom?.text = "x\(String(defaults.integer(forKey: "itemBom")))"
                    defaults.set(defaults.integer(forKey: "coinCollect") - 40, forKey: "coinCollect")
                    if defaults.integer(forKey: "coinCollect") > 99999 {
                        coinCollectLabel?.fontSize = fontCoinHigh
                    } else {
                        coinCollectLabel?.fontSize = fontCoinLow
                    }
                    coinCollectLabel?.text = String(defaults.integer(forKey: "coinCollect"))
                    defaults.set(defaults.integer(forKey: "orderBom") + 1, forKey: "orderBom")
                    checkDisableBtnCoins()
                } else if defaults.integer(forKey: "coinCollect") < 40 {
                    self.view?.makeToast("Do not have enough coin", duration: 2.0, position: .bottom)
                    handleClickShopItem()
                } else {
                    self.view?.makeToast("exceeds the number of items allowed", duration: 1.5, position: .bottom)
                }
            }
            
            //buy coin price: 35
            if atPoint(location).name == "Coin" {
                if defaults.integer(forKey: "coinCollect") >= 35 && defaults.integer(forKey: "itemCoin") < 999 {
                    defaults.set(defaults.integer(forKey: "itemCoin") + 1, forKey: "itemCoin")
                    quantityItemCoin?.text = "x\(String(defaults.integer(forKey: "itemCoin")))"
                    defaults.set(defaults.integer(forKey: "coinCollect") - 35, forKey: "coinCollect")
                    if defaults.integer(forKey: "coinCollect") > 99999 {
                        coinCollectLabel?.fontSize = fontCoinHigh
                    } else {
                        coinCollectLabel?.fontSize = fontCoinLow
                    }
                    coinCollectLabel?.text = String(defaults.integer(forKey: "coinCollect"))
                    defaults.set(defaults.integer(forKey: "orderCoin") + 1, forKey: "orderCoin")
                    checkDisableBtnCoins()
                } else if defaults.integer(forKey: "coinCollect") < 35 {
                    self.view?.makeToast("Do not have enough coin", duration: 2.0, position: .bottom)
                    handleClickShopItem()
                } else {
                    self.view?.makeToast("exceeds the number of items allowed", duration: 1.5, position: .bottom)
                }
            }
            
            //buy slow price: 15
            if atPoint(location).name == "Slow" {
                if defaults.integer(forKey: "coinCollect") >= 15 && defaults.integer(forKey: "itemSlow") < 999 {
                    defaults.set(defaults.integer(forKey: "itemSlow") + 1, forKey: "itemSlow")
                    quantityItemSlow?.text = "x\(String(defaults.integer(forKey: "itemSlow")))"
                    defaults.set(defaults.integer(forKey: "coinCollect") - 15, forKey: "coinCollect")
                    if defaults.integer(forKey: "coinCollect") > 99999 {
                        coinCollectLabel?.fontSize = fontCoinHigh
                    } else {
                        coinCollectLabel?.fontSize = fontCoinLow
                    }
                    coinCollectLabel?.text = String(defaults.integer(forKey: "coinCollect"))
                    defaults.set(defaults.integer(forKey: "orderSlow") + 1, forKey: "orderSlow")
                    checkDisableBtnCoins()
                } else if defaults.integer(forKey: "coinCollect") < 15 {
                    self.view?.makeToast("Do not have enough coin", duration: 2.0, position: .bottom)
                    handleClickShopItem()
                } else {
                    self.view?.makeToast("exceeds the number of items allowed", duration: 1.5, position: .bottom)
                }
            }
            
            //buy protect price: 40
            if atPoint(location).name == "Protect" {
                if defaults.integer(forKey: "coinCollect") >= 40 && defaults.integer(forKey: "itemProtect") < 999 {
                    defaults.set(defaults.integer(forKey: "itemProtect") + 1, forKey: "itemProtect")
                    quantityItemProtect?.text = "x\(String(defaults.integer(forKey: "itemProtect")))"
                    defaults.set(defaults.integer(forKey: "coinCollect") - 40, forKey: "coinCollect")
                    if defaults.integer(forKey: "coinCollect") > 99999 {
                        coinCollectLabel?.fontSize = fontCoinHigh
                    } else {
                        coinCollectLabel?.fontSize = fontCoinLow
                    }
                    coinCollectLabel?.text = String(defaults.integer(forKey: "coinCollect"))
                    defaults.set(defaults.integer(forKey: "orderProtect") + 1, forKey: "orderProtect")
                    checkDisableBtnCoins()
                } else if defaults.integer(forKey: "coinCollect") < 40 {
                    self.view?.makeToast("Do not have enough coin", duration: 2.0, position: .bottom)
                    handleClickShopItem()
                } else {
                    self.view?.makeToast("exceeds the number of items allowed", duration: 1.5, position: .bottom)
                }
            }
            
            //open tab shop item
            if atPoint(location).name == "ShopItem" || atPoint(location).name == "TextShopItem" {
                checkDisableBtnCoins()
                ShopItem?.size = CGSize(width: 190, height: 70)
                ShopItem?.position = CGPoint(x: -200, y: 238)
//                ShopItem?.texture = SKTexture(imageNamed: "bgItemShopActive")
                item?.run(SKAction.unhide())
                
                ShopCoin?.size = CGSize(width: 190, height: 55)
                ShopCoin?.position = CGPoint(x: 0, y: 231)
//                ShopCoin?.texture = SKTexture(imageNamed: "bgCoinShop")
                coin?.run(SKAction.hide())
                
                ShopOrder?.size = CGSize(width: 190, height: 55)
                ShopOrder?.position = CGPoint(x: 200, y: 231)
//                ShopOrder?.texture = SKTexture(imageNamed: "bgOrderShop")
                order?.run(SKAction.hide())
            }
            
            
            // buy coin
            
            if atPoint(location).name == "Coin1" || atPoint(location).name == "Coin2" || atPoint(location).name == "Coin3" || atPoint(location).name == "Coin4" || atPoint(location).name == "Coin5"{
                if atPoint(location).name == "Coin1" {
                    print("buy 500 coin with 0.99$")
                    
                    paymentInfo["text"] = "Purchase 500 coins with 0.99$"
                    paymentInfo["amount"] = 0.99
                    paymentInfo["coin"] = 500
                    paymentInfo["plan"] = 0
                } else if atPoint(location).name == "Coin2" {
                    print("buy 1000 coin with 1.99$")
                    
                    paymentInfo["text"] = "Purchase 1000 coins with 1.99$"
                    paymentInfo["amount"] = 1.99
                    paymentInfo["coin"] = 1000
                    paymentInfo["plan"] = 1
                } else if atPoint(location).name == "Coin3" {
                    print("buy 1700 coin with 2.99$")
                    
                    paymentInfo["text"] = "Purchase 1700 coins with 2.99$"
                    paymentInfo["amount"] = 2.99
                    paymentInfo["coin"] = 1700
                    paymentInfo["plan"] = 2
                } else if atPoint(location).name == "Coin4" {
                    print("buy 10000 coin with 9.99$")
                    
                    paymentInfo["text"] = "Purchase 10000 coins with 9.99$"
                    paymentInfo["amount"] = 9.99
                    paymentInfo["coin"] = 10000
                    paymentInfo["plan"] = 3
                } else if atPoint(location).name == "Coin5" {
                    print("buy 100000 coin with 49.99$")
                    
                    paymentInfo["text"] = "Purchase 100000 coins with 49.99$"
                    paymentInfo["amount"] = 49.99
                    paymentInfo["coin"] = 100000
                    paymentInfo["plan"] = 4
                }
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Payment", bundle: nil)
                let PaymentViewController = storyBoard.instantiateViewController(withIdentifier: "PaymentVC") as! PaymentViewController
                self.view?.window?.rootViewController?.present(PaymentViewController, animated: true, completion: nil)
            }
            
            //open tab shop coin
            if atPoint(location).name == "ShopCoin" || atPoint(location).name == "TextShopCoin" {
                ShopItem?.size = CGSize(width: 190, height: 55)
                ShopItem?.position = CGPoint(x: -200, y: 231)
//                ShopItem?.texture = SKTexture(imageNamed: "bgItemShop")
                item?.run(SKAction.hide())
                
                ShopCoin?.size = CGSize(width: 190, height: 70)
                ShopCoin?.position = CGPoint(x: 0, y: 238)
//                ShopCoin?.texture = SKTexture(imageNamed: "bgCoinShopActive")
                coin?.run(SKAction.unhide())
                
                ShopOrder?.size = CGSize(width: 190, height: 55)
                ShopOrder?.position = CGPoint(x: 200, y: 231)
//                ShopOrder?.texture = SKTexture(imageNamed: "bgOrderShop")
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
//                ShopItem?.texture = SKTexture(imageNamed: "bgItemShop")
                item?.run(SKAction.hide())
                
                ShopCoin?.size = CGSize(width: 190, height: 55)
                ShopCoin?.position = CGPoint(x: 0, y: 231)
//                ShopCoin?.texture = SKTexture(imageNamed: "bgCoinShop")
                coin?.run(SKAction.hide())
                
                ShopOrder?.size = CGSize(width: 190, height: 70)
                ShopOrder?.position = CGPoint(x: 200, y: 238)
//                ShopOrder?.texture = SKTexture(imageNamed: "bgOrderShopActive")
                order?.run(SKAction.unhide())
            }
            
            
        }
    }
    
    // handle click coin tap shop or over buy item
    func handleClickShopItem() {
//        print("len")
        ShopItem?.size = CGSize(width: 190, height: 55)
        ShopItem?.position = CGPoint(x: -200, y: 231)
//        ShopItem?.texture = SKTexture(imageNamed: "bgItemShop")
        item?.run(SKAction.hide())
        
        ShopCoin?.size = CGSize(width: 190, height: 70)
        ShopCoin?.position = CGPoint(x: 0, y: 238)
//        ShopCoin?.texture = SKTexture(imageNamed: "bgCoinShopActive")
        coin?.run(SKAction.unhide())
        
        ShopOrder?.size = CGSize(width: 190, height: 55)
        ShopOrder?.position = CGPoint(x: 200, y: 231)
//        ShopOrder?.texture = SKTexture(imageNamed: "bgOrderShop")
        order?.run(SKAction.hide())
    }
    
    
    func getBestScore() {
        var urlBestScore = "http://103.28.38.10/~tngame/manhtu/bear/api/best-score"
        var parametersBestScore: Parameters? = nil
        if let tokenLogin = defaults.string(forKey: "tokenLogin") {
            urlBestScore = "http://103.28.38.10/~tngame/manhtu/bear/api/user/top-best-score-server"
            parametersBestScore = [
                "token" : tokenLogin,
                "best_score": "\(defaults.integer(forKey: "bestScore"))",
                "flag": defaults.integer(forKey: "flag")
                ] as [String: Any]?
            if defaults.string(forKey: "userType") == "2" {
                print("id priend best score ", defaults.array(forKey: "id_friend")!)
                urlBestScore = "http://103.28.38.10/~tngame/manhtu/bear/api/user/top-best-score-friend"
                parametersBestScore = [
                    "token" : tokenLogin,
                    "best_score": "\(defaults.integer(forKey: "bestScore"))",
                    "flag": defaults.integer(forKey: "flag"),
                    "id_friend": defaults.array(forKey: "id_friend")!
                    ] as [String: Any]?
            }
        }
        print("parametersBestScore: ", parametersBestScore)
        Alamofire.request(urlBestScore, method: .post, parameters: parametersBestScore, encoding: JSONEncoding.default).responseJSON(completionHandler: { (resBestScore) in
            print("resbescore: ", resBestScore)
            self.activityIndicatorView.stopAnimating()
            if let respondBestScore = resBestScore.result.value as! [String: Any]? {
                if (respondBestScore["state"] as? String) ?? "" == "error" {
                    if respondBestScore["token"] as? String != nil {
                        defaults.set(respondBestScore["token"] as! String, forKey: "tokenLogin")
                        self.getBestScore()
                    } else {
                        defaults.removeObject(forKey: "tokenLogin")
                        self.LogoutSocial()
                    }
                    self.view?.makeToast(respondBestScore["message"] as? String, duration: 3.0, position: .bottom)
                } else if (respondBestScore["state"] as? String) ?? "" == "Success" {
                    if let arrBestScore = respondBestScore["data"] as! [[String:Any]]? {
                        self.userNameHighScore = [String](repeating: "", count: 10)
                        self.scoreHighScore = [String](repeating: "", count: 10)
                        for i in 0...arrBestScore.count - 1 {
                            let name = arrBestScore[i]["name"] as! String
                            //                                        print("check email", "\(String(email.prefix(6)))...")
                            if name.count > 6 {
                                self.userNameHighScore[i] = "\(String(name.prefix(6)))..."
                            } else {
                                self.userNameHighScore[i] = "\(String(name))"
                            }
                            let highScore = arrBestScore[i]["best_score"] as! Int
                            //                                        print("check high score", highScore)
                            self.scoreHighScore[i] = String(highScore)
                        }
                    }
                    self.setData()
                    self.BGPopup?.run(SKAction.unhide())
                    self.BGHighScore?.run(SKAction.unhide())
                    self.BGHighScore?.run(SKAction.scale(to: self.scaleHighScore, duration: 0.3))
                }
            }
        })
    }
    
    
    //set username and score
    func setData() {
        usernameNo1?.text = userNameHighScore[0]
        usernameNo1?.fontColor = .black
        usernameNo2?.text = userNameHighScore[1]
        usernameNo2?.fontColor = .black
        usernameNo3?.text = userNameHighScore[2]
        usernameNo3?.fontColor = .black
        usernameNo4?.text = userNameHighScore[3]
        usernameNo4?.fontColor = .black
        usernameNo5?.text = userNameHighScore[4]
        usernameNo5?.fontColor = .black
        usernameNo6?.text = userNameHighScore[5]
        usernameNo6?.fontColor = .black
        usernameNo7?.text = userNameHighScore[6]
        usernameNo7?.fontColor = .black
        usernameNo8?.text = userNameHighScore[7]
        usernameNo8?.fontColor = .black
        usernameNo9?.text = userNameHighScore[8]
        usernameNo9?.fontColor = .black
        usernameNo10?.text = userNameHighScore[9]
        usernameNo10?.fontColor = .black
        
        
        scoreNo1?.text = scoreHighScore[0]
        scoreNo1?.fontColor = .black
        scoreNo2?.text = scoreHighScore[1]
        scoreNo2?.fontColor = .black
        scoreNo3?.text = scoreHighScore[2]
        scoreNo3?.fontColor = .black
        scoreNo4?.text = scoreHighScore[3]
        scoreNo4?.fontColor = .black
        scoreNo5?.text = scoreHighScore[4]
        scoreNo5?.fontColor = .black
        scoreNo6?.text = scoreHighScore[5]
        scoreNo6?.fontColor = .black
        scoreNo7?.text = scoreHighScore[6]
        scoreNo7?.fontColor = .black
        scoreNo8?.text = scoreHighScore[7]
        scoreNo8?.fontColor = .black
        scoreNo9?.text = scoreHighScore[8]
        scoreNo9?.fontColor = .black
        scoreNo10?.text = scoreHighScore[9]
        scoreNo10?.fontColor = .black
        
    }
    
    fileprivate func loginTWClicked() {
        TWTRTwitter.sharedInstance().logIn {(session, error) in
            if session != nil {
                self.editName?.zPosition = 5
                defaults.set("3", forKey: "userType")
                if let s = session {
                    let client = TWTRAPIClient()
                    
                    client.loadUser(withID: s.userID, completion: { (user, error) in
                        print("user twitter: ", user as Any)
                        let emailUser = "\(user!.userID)@tntechs.com.vn"
                        self.dict = ["id": user!.userID as AnyObject, "name": user!.name as AnyObject, "email": emailUser as AnyObject]
                        self.returnUserData()
                    })
                }
            } else {
                print("Failed to login via Twitter: ", error as Any)
            }
        }
    } // end loginTWClicked
    
    
    func loginFBClicked() {
        self.loginManager.logIn(withReadPermissions: ["email", "public_profile", "user_friends"], from: view?.window?.rootViewController) { (loginResult, error) -> Void  in
            if (error == nil) {
                let fbloginresult : FBSDKLoginManagerLoginResult = loginResult!
                
                if(fbloginresult.isCancelled) {
                    print("User press cancel")
                    //Show Cancel alert
                } else if(fbloginresult.grantedPermissions.contains("public_profile") && fbloginresult.grantedPermissions.contains("email") && fbloginresult.grantedPermissions.contains("user_friends")) {
//                    self.textLogin?.text = "Log out"
                    defaults.set("2", forKey: "userType")
                    
                    
                    let requestFriend = FBSDKGraphRequest(graphPath: "/me/friends", parameters: nil)
                    requestFriend?.start(completionHandler: { (connection, result, error) in
                        // get list friend fb
                        var id_friend: Array<String> = []
                        if error == nil {
                            print("Friends are : \(String(describing: result))")
                            let resultdict = result as! NSDictionary
                            print("Result Dict: \(resultdict)")
                            let data : NSArray = resultdict.object(forKey: "data") as! NSArray
                            
                            for i in 0..<data.count {
                                let valueDict : NSDictionary = data[i] as! NSDictionary
                                let id = valueDict.object(forKey: "id") as! String
                                print("the id value is \(id)")
                                id_friend.append("\(id)")
                            }
                            
                            defaults.set(id_friend, forKey: "id_friend")
                        } else {
                            print("Error Getting Friends \(String(describing: error))");
                        }
                        
                    })
                    
//                    print("ids friend: \(defaults.array(forKey: "id_friend"))")
                    
                    self.returnUserData()
                    //fbLoginManager.logOut()
                }
            }
        }
    }
    
    func LogoutSocial() {
        print("log out socical")
        if FBSDKAccessToken.current() != nil {
            self.loginManager.logOut()
            defaults.removeObject(forKey: "nameFB")
        }
        if TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers() {
            TWTRTwitter.sharedInstance().sessionStore.logOutUserID(TWTRTwitter.sharedInstance().sessionStore.session()!.userID)
        }
        defaults.removeObject(forKey: "tokenLogin")
        defaults.removeObject(forKey: "userType")
        
        // need re tesst
        defaults.set(0, forKey: "flag")
        defaults.set(0, forKey: "itemBom")
        defaults.set(0, forKey: "itemSlow")
        defaults.set(0, forKey: "itemProtect")
        defaults.set(0, forKey: "itemCoin")
        defaults.set(0, forKey: "itemHeart")
        defaults.set(0, forKey: "bestScore")
        defaults.set(0, forKey: "coinCollect")
        userInfo = [:]
        self.username?.text = "Username"
        textLogin?.text = "Login"
        self.changePassword?.zPosition = -1
        self.textChangePassword?.zPosition = -1
        editName?.zPosition = -1
    } // end LogoutSocial
    
    
    func handlerLogout() {
        if let _ = defaults.string(forKey: "tokenLogin") {
            let parameters = [
                "itemBom": defaults.integer(forKey: "itemBom"),
                "itemSlow": defaults.integer(forKey: "itemSlow"),
                "itemProtect": defaults.integer(forKey: "itemProtect"),
                "itemCoin": defaults.integer(forKey: "itemCoin"),
                "itemHeart": defaults.integer(forKey: "itemHeart"),
                "best_score": defaults.integer(forKey: "bestScore"),
                "coin": defaults.integer(forKey: "coinCollect"),
                "token": defaults.string(forKey: "tokenLogin")!,
                ] as [String : Any]
            print("param logout: ", parameters)
            Alamofire.request("http://103.28.38.10/~tngame/manhtu/bear/api/user/update-coin-item", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { (respond) in
                print("respond logout: ", respond)
                self.activityIndicatorView.stopAnimating()
                if let responseData = respond.result.value as! [String: Any]? {
                    if (responseData["state"] as? String) ?? "" == "Success" {
                        defaults.set(0, forKey: "flag")
                        defaults.set(0, forKey: "itemBom")
                        defaults.set(0, forKey: "itemSlow")
                        defaults.set(0, forKey: "itemProtect")
                        defaults.set(0, forKey: "itemCoin")
                        defaults.set(0, forKey: "itemHeart")
                        defaults.set(0, forKey: "bestScore")
                        defaults.set(0, forKey: "coinCollect")
                        self.bestScoreLabel?.text = "0"
                        self.coinCollectLabel?.text = String(defaults.integer(forKey: "coinCollect"))
                        self.LogoutSocial()
                        self.showSocialLogin()
                    } else {
                        defaults.set(1, forKey: "flag")
                        if let token = responseData["token"] as? String {
                            defaults.set(token , forKey: "tokenLogin")
                            self.handlerLogout()
                        } else {
                            defaults.removeObject(forKey: "tokenLogin")
                            self.LogoutSocial()
                        }
                        self.view?.makeToast(responseData["message"] as? String, duration: 1.5, position: .bottom)
                    }
                } else {
                    defaults.set(1, forKey: "flag")
                    self.view?.makeToast("Error, please try again!", duration: 1.5, position: .bottom)
                }
            })
        } else { // end if let tokenlogin
            activityIndicatorView.stopAnimating()
        }
    } // end handlerLogout
    
    
    func returnUserData() {
        activityIndicatorView.color = UIColor.black
        self.view?.addSubview(activityIndicatorView)
        activityIndicatorView.frame = (self.view?.frame)!
        activityIndicatorView.center = (self.view?.center)!
        activityIndicatorView.startAnimating()
        
        var parameters: [String: Any] = [:]
        
        if((FBSDKAccessToken.current()) != nil) {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! [String : AnyObject]
                    print(result as Any)
                    print(self.dict)
                    
                    parameters = [
                        "id_social" : self.dict["id"]!,
                        "email" : self.dict["email"] ?? "\(self.dict["id"] as! String)@tntechs.com.vn",
                        "name" : self.dict["name"]!,
                        "password": "\(self.dict["id"] as! String)tntechs!@#",
                        "user_type": 2,
                        "itemBom": defaults.integer(forKey: "itemBom"),
                        "itemSlow": defaults.integer(forKey: "itemSlow"),
                        "itemProtect": defaults.integer(forKey: "itemProtect"),
                        "itemCoin": defaults.integer(forKey: "itemCoin"),
                        "itemHeart": defaults.integer(forKey: "itemHeart"),
                        "best_score": defaults.integer(forKey: "bestScore"),
                        "coin": defaults.integer(forKey: "coinCollect"),
                        
                    ]
                    print("parameters social fb: ", parameters)
                    self.requsetLoginSocialToServer(prams: parameters)
                } // end error
            })
        } else if TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers() {
            print("oke login via twitter")
            print(self.dict)
            parameters = [
                "id_social" : self.dict["id"]!,
                "email" : self.dict["email"]!,
                "name" : self.dict["name"]!,
                "password": "\(self.dict["id"] as! String)tntechs!@#",
                "user_type": 3,
                "itemBom": defaults.integer(forKey: "itemBom"),
                "itemSlow": defaults.integer(forKey: "itemSlow"),
                "itemProtect": defaults.integer(forKey: "itemProtect"),
                "itemCoin": defaults.integer(forKey: "itemCoin"),
                "itemHeart": defaults.integer(forKey: "itemHeart"),
                "best_score": defaults.integer(forKey: "bestScore"),
                "coin": defaults.integer(forKey: "coinCollect"),
                
            ]
            print("parameters social twitter: ", parameters)
            
            self.requsetLoginSocialToServer(prams: parameters)
        } // end if else fb / twitter current login
        
        
    }
    
    func requsetLoginSocialToServer(prams: [String: Any]) {
        if prams.count > 0 {
            // oke send request to server
            Alamofire.request("http://103.28.38.10/~tngame/manhtu/bear/api/login-social", method: .post, parameters: prams, encoding: JSONEncoding.default).responseJSON(completionHandler: { (respond) in
                                print("respond login fb: ", respond)
                if let respondData = respond.result.value as! [String: Any]? {
                    if (respondData["state"] as? String) ?? "" == "error" {
                        self.LogoutSocial()
                        self.view?.makeToast(respondData["message"] as? String, duration: 1.5, position: .bottom)
                    } else if (respondData["state"] as? String) ?? "" == "Success" {
                        
                        print("respond login fb: ", respondData)
                        defaults.set(respondData["token"] as? String, forKey: "tokenLogin")
                        if let dataUser = respondData["data"] as! [String: Any]? {
                            userInfo = dataUser
                            
                            
                            print("dataUser: \(dataUser)")
                            
                            // set coin from server to local
                            defaults.set(dataUser["remain_coin"], forKey: "coinCollect")
                            self.coinCollectLabel?.text = String(defaults.integer(forKey: "coinCollect"))
                            
                            
                            if let dataItems = dataUser["user_item"] {
                                print("data items \(dataItems)")
                                print(type(of: dataItems))
                                
                                for v in (dataItems as? [Any])! {
                                    print("v \(v)")
                                    print(type(of: v))
                                    if let z = v as? [String:AnyObject] {
                                        defaults.set(z["quantity"] as! Int, forKey: z["key"] as! String)
                                    }
                                }
                                
                            } // end dataItems
                            
                            // check and set best score
                            if dataUser["best_score"] as! Int > defaults.integer(forKey: "bestScore") {
                                defaults.set(dataUser["best_score"] as! Int, forKey: "bestScore")
                                self.bestScoreLabel?.text = String(defaults.integer(forKey: "bestScore"))
                            }
                            
                            
                        } // end if dataUser
                        
                        
                        // edit change password button and edit name
                        self.changePassword?.zPosition = -1
                        self.textChangePassword?.zPosition = -1
                        self.editName?.zPosition = 5
                        
                        // set username and text logout
                        self.username?.text = self.dict["name"] as? String
                        self.textLogin?.text = "Log out"
                        
                        // show toast
                        self.view?.makeToast("Hello \(self.dict["name"] as! String)", duration: 1.5, position: .bottom)
                    }
                }
                self.activityIndicatorView.stopAnimating()
            })
        } else {
            self.activityIndicatorView.stopAnimating()
        } // end send request
    } // func requsetLoginSocialToServer
    
    
    func editNameHandler() {
        // update edit name to server
        if let tokenLogin = defaults.string(forKey: "tokenLogin") {
            let parameters: [String : Any] = [
                "token": tokenLogin,
                "name": username?.text! as Any
            ]
            
            Alamofire.request("http://103.28.38.10/~tngame/manhtu/bear/api/user/change-name", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { (respond) in
                print("change name: ", respond)
                if let respondData = respond.result.value as! [String: Any]? {
                    if (respondData["state"] as? String) ?? "" == "error" {
                        if let token = respondData["token"] as? String {
                            defaults.set(token , forKey: "tokenLogin")
                            self.editNameHandler()
                        } else {
                            defaults.removeObject(forKey: "tokenLogin")
                            self.LogoutSocial()
                            // show toast
                            self.view?.makeToast(respondData["message"] as? String, duration: 1.5, position: .bottom)
                        }
                    }
                }
            })
        }
    } // end editname handler
    
    
    func hideSocicalLogin() {
        btnFbLogin?.run(SKAction.hide())
        btnTwitter?.run(SKAction.hide())
        lblConnectWith?.run(SKAction.hide())
    } // func hideSocicalLogin
    
    func showSocialLogin() {
        btnFbLogin?.run(SKAction.unhide())
        btnTwitter?.run(SKAction.unhide())
        lblConnectWith?.run(SKAction.unhide())
    } // func showSocialLogin
    
    
    func checkDisableBtnCoins() {
        let btnBuyHert = childNode(withName: "Heart") as? SKSpriteNode
        let btnBuySlow = childNode(withName: "Slow") as? SKSpriteNode
        let btnBuyX2Coins = childNode(withName: "Coin") as? SKSpriteNode
        let btnBuyBom = childNode(withName: "Bom") as? SKSpriteNode
        let btnBuyProtected = childNode(withName: "Protect") as? SKSpriteNode
        if defaults.integer(forKey: "coinCollect") < 10 {
            // disable heart
            btnBuyHert?.texture = SKTexture(imageNamed: "disableCoin")
            btnBuySlow?.texture = SKTexture(imageNamed: "bgCost")
            btnBuyX2Coins?.texture = SKTexture(imageNamed: "bgCost")
            btnBuyBom?.texture = SKTexture(imageNamed: "bgCost")
            btnBuyProtected?.texture = SKTexture(imageNamed: "bgCost")
        } else if defaults.integer(forKey: "coinCollect") < 15 {
            // disable slow / heart
            btnBuyHert?.texture = SKTexture(imageNamed: "disableCoin")
            btnBuySlow?.texture = SKTexture(imageNamed: "disableCoin")
            btnBuyX2Coins?.texture = SKTexture(imageNamed: "bgCost")
            btnBuyBom?.texture = SKTexture(imageNamed: "bgCost")
            btnBuyProtected?.texture = SKTexture(imageNamed: "bgCost")
        } else if defaults.integer(forKey: "coinCollect") < 35 {
            // disable x2 coins / heart / slow
            btnBuyHert?.texture = SKTexture(imageNamed: "disableCoin")
            btnBuySlow?.texture = SKTexture(imageNamed: "disableCoin")
            btnBuyX2Coins?.texture = SKTexture(imageNamed: "disableCoin")
            btnBuyBom?.texture = SKTexture(imageNamed: "bgCost")
            btnBuyProtected?.texture = SKTexture(imageNamed: "bgCost")
        } else if defaults.integer(forKey: "coinCollect") < 40 {
            // disable all
            btnBuyHert?.texture = SKTexture(imageNamed: "disableCoin")
            btnBuySlow?.texture = SKTexture(imageNamed: "disableCoin")
            btnBuyX2Coins?.texture = SKTexture(imageNamed: "disableCoin")
            btnBuyBom?.texture = SKTexture(imageNamed: "disableCoin")
            btnBuyProtected?.texture = SKTexture(imageNamed: "disableCoin")
        } else {
            // enable all
            btnBuyHert?.texture = SKTexture(imageNamed: "bgCost")
            btnBuySlow?.texture = SKTexture(imageNamed: "bgCost")
            btnBuyX2Coins?.texture = SKTexture(imageNamed: "bgCost")
            btnBuyBom?.texture = SKTexture(imageNamed: "bgCost")
            btnBuyProtected?.texture = SKTexture(imageNamed: "bgCost")
        }
    }
}
