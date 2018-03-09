//
//  LoginViewController.swift
//  Catch beer
//
//  Created by Xuan Tu on 2/27/18.
//  Copyright © 2018 TnTechs. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var textFieldsUsername: UITextField?
    @IBOutlet weak var textFieldsPassword: UITextField?
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
        
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
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
