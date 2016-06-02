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
  
  func getStudentInformation(completionHandleForStudentInformation: (success: Bool) -> Void) {
    let request = NSMutableURLRequest(URL: NSURL(string: "https://api.parse.com/1/classes/StudentLocation")!)
    request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
    request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
    
    let task = session.dataTaskWithRequest(request) { (data, response, error) in
      
      guard (error == nil) else {
        print(error)
        return
      }
      
      guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode <= 200 && statusCode <= 299 else {
        print("Your request returned a status code other than 2xx!")
        return
      }
      
      guard let data = data else {
        print("No data was returned by the request!")
        return
      }
      
      let parsedResult: AnyObject!
      do {
        parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
      } catch {
        print("Could not parse the data as JSON")
        return
      }
      
      guard let results = parsedResult["results"] as? [[String:AnyObject]] else {
        print("Could not parse results")
        return
      }
      
      StudentsInformation.sharedInstance.studentsInformation = StudentInformation.studentInformationFromResults(results)
      completionHandleForStudentInformation(success: true)
    }
    task.resume()
  }

}