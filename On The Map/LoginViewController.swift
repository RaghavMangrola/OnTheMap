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
      displayError(NSError(domain: "loginButton", code: 0, userInfo: [NSLocalizedDescriptionKey : "Please make sure you enter in both fields"]))
    } else {
      UClient.sharedInstance.authenticate(emailTextField.text!, password: passwordTextField.text!) { (success, error) in
        if success {
          UClient.sharedInstance.getPublicData(UClient.sharedInstance.userID!) { (success, error) in
            if success {
              self.completeLogin()
            } else {
              self.displayError(error!)
            }
          }
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
  
  private func configureUI() {
    self.view.backgroundColor = UIColor.orangeColor()
    setupTextFields()
  }
  
  private func setupTextFields() {
    for textField in loginTextFields {
      textField.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.75)
      textField.textColor = UIColor.whiteColor()
    }
  }
  
  func displayError(error: NSError) {
    dispatch_async(dispatch_get_main_queue()) {
      let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
      let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
      alert.addAction(action)
      // TODO: Highlight empty text field so user can visually see what's missing.
      self.presentViewController(alert, animated: true, completion: nil)
    }
  }
  
  private func completeLogin() {
    dispatch_async(dispatch_get_main_queue()) {
      let controller = self.storyboard?.instantiateViewControllerWithIdentifier("mapAndTableTabBarController") as! UITabBarController
      self.presentViewController(controller, animated: true, completion: nil)
    }
  }
}

