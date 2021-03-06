//
//  ForgotPasswordViewController.swift
//  Catch beer
//
//  Created by phuongpro Imac on 3/9/18.
//  Copyright © 2018 TnTechs. All rights reserved.
//

import UIKit
import Toast_Swift
import Alamofire

class ForgotPasswordViewController: UIViewController {

    let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
  @IBOutlet weak var txtEmail: CustomTextField!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // create loading view
    activityIndicatorView.color = UIColor.black
    self.view.addSubview(activityIndicatorView)
    activityIndicatorView.frame = self.view.frame
    activityIndicatorView.center = self.view.center
    
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    view.addGestureRecognizer(tap)

  }

  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
    
    @IBAction func btnClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
  @IBAction func btn_Enter(_ sender: Any) {
    print("text email: ", txtEmail.text ?? "nothing!")
    
    activityIndicatorView.startAnimating()
    
    
    if txtEmail.text == "" {
        self.view.makeToast("Please enter your email", duration: 3.0, position: .bottom)
    } else if isValidEmail(testStr: txtEmail.text!) == false {
        self.view.makeToast("Email not correct", duration: 3.0, position: .bottom)
    } else {
        // create param
        handlerForgotPassword()
    }
  }
    
    
    func handlerForgotPassword() {
        
        let parameters: Parameters = [
            "email" : txtEmail.text!,
            ]
        Alamofire.request("http://103.28.38.10/~tngame/manhtu/bear/api/forgot-password", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { (respond) in
            print("return respond reset password: ", respond)
            
            self.activityIndicatorView.stopAnimating()
            if let respondData = respond.result.value as! [String: Any]? {
                if (respondData["state"] as? String) ?? "" == "error" {
                    if let token = respondData["token"] as? String {
                        defaults.set(token , forKey: "tokenLogin")
                        self.handlerForgotPassword()
                    } else {
                        defaults.removeObject(forKey: "tokenLogin")
                        MainMenuScene.sharedInstance.LogoutSocial()
                        // show toast
                        self.view?.makeToast(respondData["message"] as? String, duration: 1.5, position: .bottom)
                    }
                } else if (respondData["state"] as? String) ?? "" == "Success" {
                    let alert = UIAlertController(title: "Success", message: "Please check your email to reset password", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        })
    }// end handlerForgotPassword
    
}




func isValidEmail(testStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}
