//
//  SignupViewController.swift
//  Catch beer
//
//  Created by Xuan Tu on 2/27/18.
//  Copyright © 2018 TnTechs. All rights reserved.
//

import UIKit
import Alamofire
import Toast_Swift

class SignupViewController: UIViewController {

    @IBOutlet weak var txtEmail: CustomTextField!
    
    @IBOutlet weak var txtUsername: CustomTextField!
    
    @IBOutlet weak var txtPassword: CustomTextField!
    
    @IBOutlet weak var txtRetypePass: CustomTextField!
    
    var hideText: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func signUp(_ sender: Any) {
        if txtEmail.text == "" {
            self.view.makeToast("Please enter email", duration: 1.5, position: .bottom)
            txtPassword.text = ""
            txtRetypePass.text = ""
            txtUsername.text = ""
        } else if txtUsername.text == "" {
            self.view.makeToast("Please enter your name", duration: 1.5, position: .bottom)
            txtPassword.text = ""
            txtRetypePass.text = ""
            txtEmail.text = ""
        } else if txtPassword.text == "" {
            self.view.makeToast("Please enter password", duration: 1.5, position: .bottom)
            txtRetypePass.text = ""
        } else if txtPassword.text!.count < 6 {
            self.view.makeToast("Password at least 6 characters", duration: 1.5, position: .bottom)
            txtPassword.text = ""
            txtRetypePass.text = ""
        } else if txtPassword.text != txtRetypePass.text {
            self.view.makeToast("Password and Retype password must match", duration: 1.5, position: .bottom)
            txtPassword.text = ""
            txtRetypePass.text = ""
        } else {
            let parameters: Parameters = [
                "email" : txtEmail.text!,
                "name": txtUsername.text!,
                "password" : txtPassword.text!
            ]
            let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            activityIndicatorView.color = UIColor.black
            self.view.addSubview(activityIndicatorView)
            activityIndicatorView.frame = self.view.frame
            activityIndicatorView.center = self.view.center
            activityIndicatorView.startAnimating()
            //        print("check param", parameters)
            Alamofire.request("http://103.28.38.10/~tngame/manhtu/bear/api/register", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                print("check response", response)
                if let responseData = response.result.value as! [String: Any]? {
                    //                    print("k loi")
                    activityIndicatorView.stopAnimating()
                    if (responseData["message"] as? String) ?? "" == "Successfully" {
                        MainMenuScene.sharedInstance.view?.makeToast("Sign up successful", duration: 3.0, position: .bottom)

                        self.dismiss(animated: true, completion: nil)
//                        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                        self.txtUsername.text = ""
                        self.txtPassword.text = ""
                        self.txtRetypePass.text = ""
                        self.txtEmail.text = ""
                    } else {
                        self.view.makeToast((responseData["message"] as? String) ?? "", duration: 3.0, position: .bottom)
                        self.txtPassword.text = ""
                        self.txtRetypePass.text = ""
                    }
                } else {
                    print("loi")
                }
            }
        }
    }
    
    @IBAction func signIn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnHideOrShowText(_ sender: UIButton) {
        hideText = !hideText
        if hideText == true {
            sender.setImage(UIImage(named: "eyeClose"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "eyeOpen"), for: .normal)
        }
        if sender.tag == 1 {
            txtPassword.isSecureTextEntry = hideText
        }
        
        if sender.tag == 2 {
            txtRetypePass.isSecureTextEntry = hideText
        }
    }
}
