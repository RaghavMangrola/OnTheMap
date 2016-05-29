//
//  UClient.swift
//  On The Map
//
//  Created by Raghav Mangrola on 5/26/16.
//  Copyright © 2016 Raghav Mangrola. All rights reserved.
//

import Foundation
import UIKit

class UClient: NSObject {
  // shared sessions
  var session = NSURLSession.sharedSession()
  // authentication state
  var sessionID: String? = nil
  
  let loginVC = LoginViewController()
  
  func getSessionID(username username: String, password: String, completionHandlerForSessionID: (success: Bool, errorString: String?) -> Void) {

    let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
    request.HTTPMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.HTTPBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".dataUsingEncoding(NSUTF8StringEncoding)
    
    let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
      guard (error == nil) else {
        self.loginVC.displayError("There was an error with your request")
        print(error)
        return
      }
      
      guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
        self.loginVC.displayError("Your request returned a status code other than 2xx!")
        return
      }
      
      guard let data = data else {
        self.loginVC.displayError("No data was returned by the request!")
        return
      }
      
      let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5))
      
      let parsedResult: AnyObject!
      do {
        parsedResult = try NSJSONSerialization.JSONObjectWithData(newData, options: .AllowFragments)
      } catch {
        self.loginVC.displayError("Could not parse the data as JSON")
        print(newData)
        return
      }
      
      guard let sessionID = parsedResult["session"] as? [String:AnyObject] else {
        self.loginVC.displayError("Could not parse session")
        return
      }
      
      self.sessionID = sessionID["id"] as? String
      completionHandlerForSessionID(success: true, errorString: nil)
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

