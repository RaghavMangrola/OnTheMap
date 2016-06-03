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
  static let sharedInstance = UClient()
  // authentication state
  var sessionID: String? = nil
  var userID: String? = nil
  var firstName: String? = nil
  var lastName: String? = nil
  let loginVC = LoginViewController()
  
  func taskForPOSTMethod(method: String, parameters: [String:AnyObject], jsonBody: String, completionHandlerForPOST: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
    
    var parameters = parameters
    
    let request = NSMutableURLRequest(URL: udacityURLFromParameters(parameters, withPathExtension: method))
    request.HTTPMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.HTTPBody = jsonBody.dataUsingEncoding(NSUTF8StringEncoding)
    
    let task = session.dataTaskWithRequest(request) { (data,response, error) in
      func sendError(error: String) {
        let userInfo = [NSLocalizedDescriptionKey : error]
        completionHandlerForPOST(result: nil, error: NSError(domain: "getSessionID", code: 1, userInfo: userInfo))
      }
      
      guard (error == nil) else {
        sendError("There was an error with your request")
        print(error)
        return
      }
      
      guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
        sendError("Incorrect Username or Password!")
        return
      }
      
      guard let data = data else {
        sendError("No data was returned by the request!")
        return
      }
      
      let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5))
      
      self.convertDataWithCompletionHandler(newData, completionHandlerForConvertData: completionHandlerForPOST)
    }
    task.resume()
    return task
  }
  
  func taskForGetMethod(method: String, parameters: [String:AnyObject], completionHandlerForGET: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
    
    var parameters = parameters
    
    let request = NSMutableURLRequest(URL: udacityURLFromParameters(parameters, withPathExtension: method))

    let task = session.dataTaskWithRequest(request) { (data, response, error) in
      
      func sendError(error: String) {
        let userInfo = [NSLocalizedDescriptionKey: error]
        completionHandlerForGET(result: nil, error: NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
      }
      
      guard (error == nil) else {
        sendError("There was an error with your request: \(error)")
        return
      }
      
      guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
        sendError("Your request returned a status code other than 2xx!")
        return
      }
      
      guard let data = data else {
        sendError("No data was returned by the request!")
        return
      }
      
      let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5))

      
      self.convertDataWithCompletionHandler(newData, completionHandlerForConvertData: completionHandlerForGET)
      
    }
    
    task.resume()
    
    return task
  }

  

  
  private func udacityURLFromParameters(parameters: [String:AnyObject], withPathExtension: String? = nil) -> NSURL {
    let components = NSURLComponents()
    components.scheme = UClient.Constants.ApiScheme
    components.host = UClient.Constants.ApiHost
    components.path = UClient.Constants.ApiPath + (withPathExtension ?? "")
    components.queryItems = [NSURLQueryItem]()
    
    for (key, value) in parameters {
      let queryItem = NSURLQueryItem(name: key, value: "\(value)")
      components.queryItems!.append(queryItem)
    }
    
    return components.URL!
  }
  
  private func convertDataWithCompletionHandler(data: NSData, completionHandlerForConvertData: (result: AnyObject!, error: NSError?) -> Void) {
    
    var parsedResult: AnyObject!
    do {
      parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
    } catch {
      let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
      completionHandlerForConvertData(result: nil, error: NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
    }
    completionHandlerForConvertData(result: parsedResult, error: nil)
  }
}

