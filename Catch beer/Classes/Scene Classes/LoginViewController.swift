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
let defaults = UserDefaults.standard
//defaults.set("Some String Value", forKey: defaultsKeys.keyOne)
//defaults.set("Another String Value", forKey: defaultsKeys.keyTwo)

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var textFieldsUsername: UITextField!
    @IBOutlet weak var textFieldsPassword: UITextField!
    static var loginShare = LoginViewController()
    
    override func viewDidLoad() {
        LoginViewController.loginShare = self
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func login(_ sender: Any) {
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
            "password" : textFieldsPassword.text!
        ]
        
        // request using alamofire
        Alamofire.request("http://demo.tntechs.com.vn/manhtu/bear/api/login", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { (respon) in
//            activityIndicatorView.stopAnimating()
//            print("respond: ", respon)
            if let respondData = respon.result.value as! [String: Any]? {
                if (respondData["state"] as? String) ?? "" == "error" {
//                    print(respondData["message"])
                    self.view.makeToast(respondData["message"] as? String, duration: 3.0, position: .bottom)
                    activityIndicatorView.stopAnimating()
                } else if (respondData["state"] as? String) ?? "" == "Success"{
//                    print("token: ", respondData["token"] as? String)
                    self.view.makeToast(respondData["message"] as? String, duration: 3.0, position: .bottom)
//                    print("default: ", defaults.integer(forKey: "bestScore"))
                    // save tokenLogin to local
                    defaults.set(respondData["token"] as! String, forKey: "tokenLogin")
                    
                    // get infoUser
                    let parametersUserInfo: Parameters = [
                        "token" : respondData["token"] as! String,
                    ]
                    print("token: ", parametersUserInfo)
                    //get info user
                    Alamofire.request("http://demo.tntechs.com.vn/manhtu/bear/api/user/info", method: .post, parameters: parametersUserInfo, encoding: JSONEncoding.default).responseJSON(completionHandler: { (resUserInfo) in
//                        activityIndicatorView.stopAnimating()
                        print("userInfo: ", resUserInfo)
                        if let respondInfoUser = resUserInfo.result.value as! [String: Any]? {
                            if (respondInfoUser["state"] as? String) ?? "" == "error" {
                                self.view.makeToast(respondInfoUser["message"] as? String, duration: 3.0, position: .bottom)
                            } else if (respondInfoUser["state"] as? String) ?? "" == "Success" {
                                userInfo = respondInfoUser["result"] as! [String : Any]
                                MainMenuScene.sharedInstance.username?.text = userInfo["email"] as? String
                                MainMenuScene.sharedInstance.textLogin?.text = "Log out"
                                self.dismiss(animated: true, completion: nil)
                            }
                        }
                    })
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
