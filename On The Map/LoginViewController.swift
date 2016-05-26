//
//  LoginViewController.swift
//  On The Map
//
//  Created by Raghav Mangrola on 5/25/16.
//  Copyright © 2016 Raghav Mangrola. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet var loginTextFields: [UITextField]!
  

  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  func configureUI() {
    self.view.backgroundColor = UIColor.orangeColor()
    setupTextFields()
  }
  
  func setupTextFields() {
    for textField in loginTextFields {
      textField.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.75)
      textField.textColor = UIColor.whiteColor()
    }
  }
  
}

