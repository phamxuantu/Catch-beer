//
//  ChangePasswordViewController.swift
//  Catch beer
//
//  Created by phuongpro Imac on 3/12/18.
//  Copyright © 2018 TnTechs. All rights reserved.
//

import UIKit
import Alamofire
import Toast_Swift

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var txtOldPassword: CustomTextField!
    
    @IBOutlet weak var txtNewPassword: CustomTextField!
    
    @IBOutlet weak var txtRetypePassword: CustomTextField!
    
   
    @IBOutlet weak var imageEyeOldPass: UIImageView!
    
    @IBOutlet weak var imageEyeRePass: UIImageView!
    @IBOutlet weak var imageEyeNewPass: UIImageView!
    
    var hidetext1: Bool = true
    var hidetext2: Bool = true
    var hidetext3: Bool = true
    
    let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // create loading view
        activityIndicatorView.color = UIColor.black
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.frame = self.view.frame
        activityIndicatorView.center = self.view.center

        // Do any additional setup after loading the view.
        
        let tapGestureRecognizerImageOldPass = UITapGestureRecognizer(target: self, action: #selector(imageTappedEyeOldPass(tapGestureRecognizer:)))
        
        let tapGestureRecognizerImageNewPass = UITapGestureRecognizer(target: self, action: #selector(imageTappedEyeNewPass(tapGestureRecognizer:)))
        
        let tapGestureRecognizerImageRetypePass = UITapGestureRecognizer(target: self, action: #selector(imageTappedEyeRetypeNewPass(tapGestureRecognizer:)))
        
        imageEyeOldPass.isUserInteractionEnabled = true
        imageEyeOldPass.addGestureRecognizer(tapGestureRecognizerImageOldPass)
        
        imageEyeNewPass.isUserInteractionEnabled = true
        imageEyeNewPass.addGestureRecognizer(tapGestureRecognizerImageNewPass)
        
        
        imageEyeRePass.isUserInteractionEnabled = true
        imageEyeRePass.addGestureRecognizer(tapGestureRecognizerImageRetypePass)
    }

    @objc func imageTappedEyeOldPass(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        hidetext1 = !hidetext1
        if hidetext1 {
            tappedImage.image = UIImage(named: "eyeClose")
        } else {
            //eyeOpen
            tappedImage.image = UIImage(named: "eyeOpen")
        }
        
        txtOldPassword.isSecureTextEntry = hidetext1
    }
    
    @objc func imageTappedEyeNewPass(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        hidetext2 = !hidetext2
        if hidetext2 {
            tappedImage.image = UIImage(named: "eyeClose")
        } else {
            tappedImage.image = UIImage(named: "eyeOpen")
        }
        
        txtNewPassword.isSecureTextEntry = hidetext2
    }
    
    @objc func imageTappedEyeRetypeNewPass(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        hidetext3 = !hidetext3
        if hidetext3 {
            tappedImage.image = UIImage(named: "eyeClose")
        } else {
            tappedImage.image = UIImage(named: "eyeOpen")
        }
        
        txtRetypePassword.isSecureTextEntry = hidetext3
    }
    
    
    @IBAction func btn_ChangePass(_ sender: Any) {
        print("sender: ", sender)
        
//        activityIndicatorView.startAnimating()
        
        if txtOldPassword.text == "" {
            self.view.makeToast("Please enter old password", duration: 3.0, position: .bottom)
            txtNewPassword.text = ""
            txtRetypePassword.text = ""
        } else if txtNewPassword.text == "" {
            self.view.makeToast("Please enter new password", duration: 3.0, position: .bottom)
            
            txtOldPassword.text = ""
            txtRetypePassword.text = ""
        } else if txtRetypePassword.text == "" {
            self.view.makeToast("Please enter retype password", duration: 3.0, position: .bottom)
            
            txtOldPassword.text = ""
            txtNewPassword.text = ""
        } else if txtRetypePassword.text != txtNewPassword.text {
            self.view.makeToast("Password and Retype password must match", duration: 3.0, position: .bottom)
            
            txtOldPassword.text = ""
            txtNewPassword.text = ""
            txtRetypePassword.text = ""
        } else {
            activityIndicatorView.startAnimating()
            
            if let tokenLogin = defaults.string(forKey: "tokenLogin") {
                print("token login for change pass: ", tokenLogin)
                // create param
                let parameters: Parameters = [
                    "token" : tokenLogin,
                    "password" : txtOldPassword.text!,
                    "new_password" : txtNewPassword.text!
                ]
                
                print("params: ", parameters)
                
                // request using alamofire
                Alamofire.request("http://103.28.38.10/~tngame/manhtu/bear/api/user/change-pass", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { (respond) in
                    print("respond change pass: ", respond)
                    if let respondData = respond.result.value as! [String: Any]? {
                        if (respondData["state"] as? String) ?? "" == "error" {
                            // error
                            // check have new token login
                            if (respondData["token"] as? String) != nil {
                                // save tokenLogin to local
                                defaults.set(respondData["token"] as! String, forKey: "tokenLogin")
                                let params: Parameters = [
                                    "token" : respondData["token"] as! String,
                                    "password" : self.txtOldPassword.text!,
                                    "new_password" : self.txtNewPassword.text!
                                ]
                                Alamofire.request("http://103.28.38.10/~tngame/manhtu/bear/api/user/change-pass", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON(completionHandler: { (res) in
                                    if let respondData2 = res.result.value as! [String: Any]? {
                                        self.view.makeToast(respondData2["message"] as? String, duration: 1.5, position: .bottom)
                                    }
                                })
                            } else {
                                // show error
                                self.view.makeToast(respondData["message"] as? String, duration: 1.5, position: .bottom)
                                print(respondData["message"] ?? "null message")
                            }
                        } else if (respondData["state"] as? String) ?? "" == "Success" {
                            // success
                            self.view.makeToast(respondData["message"] as? String, duration: 1.5, position: .bottom)
                        }
                    }
                    self.activityIndicatorView.stopAnimating()
                })
            } else {
                //expired token
                // token login null
                let alert = UIAlertController(title: "Error", message: "You are not logged, go to login?", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "Oke", style: UIAlertActionStyle.default, handler: nil))
                activityIndicatorView.stopAnimating()
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        
    }
    
    
    @IBAction func btnCloseScene(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
