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
  
  @IBAction func loginButtonPressed(sender: AnyObject) {
    if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
      displayError("Please make sure you enter in both fields.")
    } else {
      UClient.sharedInstance().getSessionID(username: emailTextField.text!, password: passwordTextField.text!) { (success, error) in
        if success {
          print(UClient.sharedInstance().sessionID)
        } else {
          self.displayError(error!)
        }
      }
    }
  }
  

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
  
  func displayError(error: String) {
    let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.Alert)
    let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
    alert.addAction(action)
    // TODO: Highlight empty text field so user can visually see what's missing.
    self.presentViewController(alert, animated: true, completion: nil)
  }
  
  
  
}

