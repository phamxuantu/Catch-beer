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

  @IBOutlet weak var txtEmail: CustomTextField!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    view.addGestureRecognizer(tap)

  }

  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
    

  @IBAction func btn_Enter(_ sender: Any) {
    print("text email: ", txtEmail.text ?? "nothing!")
  }
}
