//
//  UConvenience.swift
//  On The Map
//
//  Created by Raghav Mangrola on 6/2/16.
//  Copyright © 2016 Raghav Mangrola. All rights reserved.
//

import Foundation
import UIKit


extension UClient {
  
    let username = "raghav.mangrola@gmail.com"
    let password = "i2flyt0hir3us7dazt4a"
  func authenticate(username: String, password: String,completionHandlerForAuthentication: (success: Bool, error: NSError?) -> Void ) {
    let parameters = [String:AnyObject]()

    let jsonBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}"
    
    
    taskForPOSTMethod(Methods.CreateSession, parameters: parameters, jsonBody: jsonBody) { (results, error) in
      if let error = error {
        completionHandlerForAuthentication(success: false, error: error)
      } else {
        if let sessionInfo = results["session"] as? [String:AnyObject], userInfo = results["account"] as? [String:AnyObject] {
          
          self.sessionID = sessionInfo["id"] as? String
          self.userID = userInfo["key"] as? String
          
          
          completionHandlerForAuthentication(success: true, error: nil)
        } else {
          completionHandlerForAuthentication(success: false, error: NSError(domain: "authenticate", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to parse info"]))
        }
      }
    }
  }
  
  func getPublicData(userId: String, completionHandlerForGetPublicData: (success: Bool, error: NSError?) -> Void) {
    let parameters = [String: AnyObject]()
    let method = "/users/\(self.userID!)"
    taskForGetMethod(method, parameters: parameters) { (results, error) in
      if let error = error{
        completionHandlerForGetPublicData(success: false, error: error)
      } else {
        if let userInfo = results["user"] as? [String:AnyObject], firstName = userInfo["first_name"] as? String, lastName = userInfo["last_name"] as? String {
          self.firstName = firstName
          self.lastName = lastName
          completionHandlerForGetPublicData(success: true, error: nil)
        } else {
          completionHandlerForGetPublicData(success: false, error: NSError(domain: "getPublicData", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to parse info"]))
        }
      }
    }
  }
  
  func deleteSession(completionHandlerForDeleteSession: (success: Bool, error: NSError?) -> Void) {
    let parameters = [String: AnyObject]()
    taskForDELETEMethod(Methods.CreateSession, parameters: parameters)  { (results, error) in
      if let error = error {
        completionHandlerForDeleteSession(success: false, error: error)
      } else {
        if (results["session"] as? [String:AnyObject]) != nil {
          self.sessionID = nil
          self.userID = nil
          self.firstName = nil
          self.lastName = nil
          StudentsInformation.sharedInstance.studentsInformation = []
          completionHandlerForDeleteSession(success: true, error: nil)
        } else {
          completionHandlerForDeleteSession(success: false, error: NSError(domain: "logout", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to parse info"]))
        }
        
      }
    }
  }
  
  func logout(hostViewController: UIViewController) {
    dispatch_async(dispatch_get_main_queue()) {
      let controller = hostViewController.storyboard!.instantiateViewControllerWithIdentifier("loginVC")
      hostViewController.presentViewController(controller, animated: true, completion: nil)
    }
  }
}