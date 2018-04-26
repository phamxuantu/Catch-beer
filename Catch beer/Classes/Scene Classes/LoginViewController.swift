//
//  LoginViewController.swift
//  Catch beer
//
//  Created by Xuan Tu on 2/27/18.
//  Copyright © 2018 TnTechs. All rights reserved.
//

import UIKit
import Alamofire
import Toast_Swift

var userInfo : [String : Any] = [:]
//defaults.set("Some String Value", forKey: defaultsKeys.keyOne)
//defaults.set("Another String Value", forKey: defaultsKeys.keyTwo)

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var textFieldsUsername: UITextField!
    @IBOutlet weak var textFieldsPassword: UITextField!
    static var loginShare = LoginViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = defaults.string(forKey: "tokenLogin") {
            dismiss(animated: true, completion: nil)
            return
        }
        LoginViewController.loginShare = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func login(_ sender: Any) {
        dismissKeyboard()
//      print("user name: ", textFieldsUsername!.text , "passs: ", textFieldsPassword!.text )
      
      if textFieldsUsername.text == "" {
        self.view.makeToast("Please enter username", duration: 3.0, position: .bottom)
        textFieldsPassword.text = ""
      } else if textFieldsPassword.text == "" {
        self.view.makeToast("Please enter password", duration: 3.0, position: .bottom)
      } else {
        // create loading view
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicatorView.color = UIColor.black
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.frame = self.view.frame
        activityIndicatorView.center = self.view.center
        activityIndicatorView.startAnimating()
        
        // create param
        let parameters: Parameters = [
            "email" : textFieldsUsername.text!,
            "password" : textFieldsPassword.text!,
            "itemBom": defaults.integer(forKey: "itemBom"),
            "itemSlow": defaults.integer(forKey: "itemSlow"),
            "itemProtect": defaults.integer(forKey: "itemProtect"),
            "itemCoin": defaults.integer(forKey: "itemCoin"),
            "itemHeart": defaults.integer(forKey: "itemHeart"),
            "best_score": defaults.integer(forKey: "bestScore"),
            "coin": defaults.integer(forKey: "coinCollect"),
            "user_type": 1
        ]
        
        // request using alamofire
        Alamofire.request("http://103.28.38.10/~tngame/manhtu/bear/api/login", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { (respon) in
            print("respond: ", respon)
            if let respondData = respon.result.value as! [String: Any]? {
                activityIndicatorView.stopAnimating()
                if (respondData["state"] as? String) ?? "" == "error" {
//                    print(respondData["message"])
                    self.view.makeToast(respondData["message"] as? String, duration: 3.0, position: .bottom)
                } else if (respondData["state"] as? String) ?? "" == "Success"{
//                    print("token: ", respondData["token"] as? String)
                    self.view.makeToast(respondData["message"] as? String, duration: 3.0, position: .bottom)
//                    print("default: ", defaults.integer(forKey: "bestScore"))
                    // save tokenLogin to local
                    defaults.set(respondData["token"] as! String, forKey: "tokenLogin")
                    
                    if let dataUser = respondData["data"] as! [String: Any]? {
                        
                        // set lobal variable userInfo
                        userInfo = dataUser
                        
                        print("dataUser: \(dataUser)")
                        
                        // set coin from server to local
                        defaults.set(dataUser["remain_coin"], forKey: "coinCollect")
                        MainMenuScene.sharedInstance.coinCollectLabel?.text = String(defaults.integer(forKey: "coinCollect"))
                        
                        
                        // set name
                        if dataUser["name"] as? String != nil {
                            MainMenuScene.sharedInstance.username?.text = dataUser["name"] as? String
                        } else {
                            MainMenuScene.sharedInstance.username?.text = dataUser["email"] as? String
                        }
                        
//                        print("data items: \(dataUser["user_item"])")
                        
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
                            
                        }
                        
                        // check and set best score
                        if dataUser["best_score"] as! Int > defaults.integer(forKey: "bestScore") {
                            defaults.set(dataUser["best_score"] as! Int, forKey: "bestScore")
                            MainMenuScene.sharedInstance.bestScoreLabel?.text = String(defaults.integer(forKey: "bestScore"))
                        }
                        
                        MainMenuScene.sharedInstance.changePassword?.zPosition = 5
                        MainMenuScene.sharedInstance.textChangePassword?.zPosition = 6
                        MainMenuScene.sharedInstance.editName?.zPosition = 5
                    }
                    MainMenuScene.sharedInstance.textLogin?.text = "Log out"
                    MainMenuScene.sharedInstance.hideSocicalLogin()
                    defaults.set("1", forKey: "userType")
                    self.dismiss(animated: true, completion: nil)
                }
            }
        })
      }
      
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
      print("dksjds")
    }
    
    @IBAction func signup(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Signup", bundle: nil)
        let signupViewController = storyBoard.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        self.present(signupViewController, animated: true, completion: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
