//
//  ParseClient.swift
//  On The Map
//
//  Created by Raghav Mangrola on 5/28/16.
//  Copyright © 2016 Raghav Mangrola. All rights reserved.
//

import Foundation

class ParseClient {
  
  var session = NSURLSession.sharedSession()
  static let sharedInstance = ParseClient()
  
  func taskForGetMethod(method: String, parameters: [String:AnyObject], completionHandlerForGET: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
    
    var parameters = parameters
    
    let request = NSMutableURLRequest(URL: parseURLFromParameters(parameters, withPathExtension: method))
    request.addValue(APIKeys.Parse, forHTTPHeaderField: "X-Parse-Application-Id")
    request.addValue(APIKeys.REST, forHTTPHeaderField: "X-Parse-REST-API-Key")
    
    
    
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
        sendError("Error connecting to server")
        return
      }
      
      guard let data = data else {
        sendError("No data was returned by the request!")
        return
      }
      
      self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForGET)
      
    }
    
    task.resume()
    
    return task
  }
  
  func taskForPOSTMethod(method: String, parameters: [String:AnyObject], jsonBody: String, completionHandlerForPOST: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
    
    var parameters = parameters
    
    let request = NSMutableURLRequest(URL: parseURLFromParameters(parameters, withPathExtension: method))
    request.HTTPMethod = "POST"
    request.addValue(APIKeys.Parse, forHTTPHeaderField: "X-Parse-Application-Id")
    request.addValue(APIKeys.REST, forHTTPHeaderField: "X-Parse-REST-API-Key")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.HTTPBody = jsonBody.dataUsingEncoding(NSUTF8StringEncoding)
    
    let task = session.dataTaskWithRequest(request) { data, response, error in
      
      func sendError(error: String) {
        let userInfo = [NSLocalizedDescriptionKey : error]
        completionHandlerForPOST(result: nil, error: NSError(domain: "taskForPOSTMethod", code: 1, userInfo: userInfo))
      }
      
      guard (error == nil) else {
        sendError("There was an error with your request: \(error)")
        return
      }

      guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
        sendError("Your request returned a status code other than 2xx! \(response)")
        return
      }

      guard let data = data else {
        sendError("No data was returned by the request!")
        return
      }

      self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForPOST)
    }
    task.resume()
    return task
  }
  
  private func parseURLFromParameters(parameters: [String:AnyObject], withPathExtension: String? = nil) -> NSURL {
    let components = NSURLComponents()
    components.scheme = ParseClient.Constants.ApiScheme
    components.host = ParseClient.Constants.ApiHost
    components.path = ParseClient.Constants.ApiPath + (withPathExtension ?? "")
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