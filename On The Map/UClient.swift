//
//  UClient.swift
//  On The Map
//
//  Created by Raghav Mangrola on 5/26/16.
//  Copyright © 2016 Raghav Mangrola. All rights reserved.
//

import Foundation
import UIKit

class UClient : NSObject {
  // shared sessions
  var session = NSURLSession.sharedSession()
  // authentication state
  var sessionID: String? = nil
  
  let loginVC = LoginViewController()
  
  func getSessionID(username username: String, password: String) {

    let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
    request.HTTPMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.HTTPBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".dataUsingEncoding(NSUTF8StringEncoding)
    
    let session = NSURLSession.sharedSession()
    
    let task = session.dataTaskWithRequest(request) { (data, response, error) in
      
      func displayError(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        // TODO: Highlight empty text field so user can visually see what's missing.
        self.loginVC.presentViewController(alert, animated: true, completion: nil)
      }
      
      guard (error == nil) else {
        displayError("There was an error with your request")
        print(error)
        return
      }
      
      guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
        displayError("Your request returned a status code other than 2xx!")
        return
      }
      
      guard let data = data else {
        displayError("No data was returned by the request!")
        return
      }
      
      let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5))
      
      let parsedResult: AnyObject!
      do {
        parsedResult = try NSJSONSerialization.JSONObjectWithData(newData, options: .AllowFragments)
      } catch {
        displayError("Could not parse the data as JSON")
        print(newData)
        return
      }
      
      guard let sessionID = parsedResult["session"] as? [String:AnyObject] else {
        displayError("Could not parse session")
        return
      }
      
      self.sessionID = sessionID["id"] as? String
      print(sessionID["id"] as? String)
    }
    
    task.resume()
  }
  
  // Mark: Shared Instance
  class func sharedInstance() -> UClient {
    struct Singleton {
      static var sharedInstance = UClient()
    }
    return Singleton.sharedInstance
  }

}

