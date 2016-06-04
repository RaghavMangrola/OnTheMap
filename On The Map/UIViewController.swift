//
//  UIViewController.swift
//  On The Map
//
//  Created by Raghav Mangrola on 6/3/16.
//  Copyright © 2016 Raghav Mangrola. All rights reserved.
//
// http://stackoverflow.com/a/27079103/2669296

import Foundation
import UIKit

extension UIViewController {
  
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
  }
  
  func dismissKeyboard() {
    view.endEditing(true)
  }
  
  func displayError(error: NSError) {
    dispatch_async(dispatch_get_main_queue()) {
      let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
      let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
      alert.addAction(action)
      self.presentViewController(alert, animated: true, completion: nil)
    }
  }
}