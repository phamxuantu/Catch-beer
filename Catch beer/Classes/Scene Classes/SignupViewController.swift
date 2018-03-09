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

    @IBOutlet weak var txtUsername: CustomTextField!
    
    @IBOutlet weak var txtPassword: CustomTextField!
    
    @IBOutlet weak var txtRetypePass: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func signUp(_ sender: Any) {
        if txtUsername.text == "" {
            self.view.makeToast("Please enter email", duration: 3.0, position: .bottom)
            txtPassword.text = ""
            txtRetypePass.text = ""
        } else if txtPassword.text == "" {
            self.view.makeToast("Please enter password", duration: 3.0, position: .bottom)
            txtRetypePass.text = ""
        } else if txtPassword.text!.count < 6 {
            self.view.makeToast("Password at least 6 characters", duration: 3.0, position: .bottom)
            txtPassword.text = ""
            txtRetypePass.text = ""
        } else if txtPassword.text != txtRetypePass.text {
            self.view.makeToast("Password and Retype password must match", duration: 3.0, position: .bottom)
            txtPassword.text = ""
            txtRetypePass.text = ""
        } else {
            let parameters: Parameters = [
                "email" : txtUsername.text!,
                "password" : txtPassword.text!
            ]
            let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            activityIndicatorView.color = UIColor.black
            self.view.addSubview(activityIndicatorView)
            activityIndicatorView.frame = self.view.frame
            activityIndicatorView.center = self.view.center
            activityIndicatorView.startAnimating()
            //        print("check param", parameters)
            Alamofire.request("http://demo.tntechs.com.vn/manhtu/bear/api/register", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                print("check response", response)
                if let responseData = response.result.value as! [String: Any]? {
                    //                    print("k loi")
                    activityIndicatorView.stopAnimating()
                    if (responseData["message"] as? String) ?? "" == "Successfully" {
//                        self.view.makeToast("Sign up successful", duration: 3.0, position: .bottom)
                        MainMenuScene.sharedInstance.textLogin?.text = "Log out"
//                        MainMenuScene().view?.makeToast("Sign up successful", duration: 3.0, position: .bottom)
                        MainMenuScene.sharedInstance.view?.makeToast("Sign up successful", duration: 3.0, position: .bottom)
                        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                        self.txtUsername.text = ""
                        self.txtPassword.text = ""
                        self.txtRetypePass.text = ""
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

}
