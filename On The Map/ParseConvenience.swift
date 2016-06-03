//
//  ParseConvenience.swift
//  On The Map
//
//  Created by Raghav Mangrola on 6/2/16.
//  Copyright © 2016 Raghav Mangrola. All rights reserved.
//

import Foundation

extension ParseClient {
  func getStudentInformation(completionHandleForStudentInformation: (success: Bool, error: NSError?) -> Void) {
    let parameters = [
      ParseClient.ParameterKeys.Limit: ParseClient.ParameterValues.Limit,
      ParseClient.ParameterKeys.Order: ParseClient.ParameterValues.Order
    ]
    
    taskForGetMethod(Methods.StudentLocation, parameters: parameters) { (results, error) in
      if let error = error {
        print(error)
        completionHandleForStudentInformation(success: false, error: error)
      } else {
        if let results = results[ParseClient.JSONResponseKeys.StudentLocations] as? [[String:AnyObject]] {
          StudentsInformation.sharedInstance.studentsInformation = StudentInformation.studentInformationFromResults(results)
          completionHandleForStudentInformation(success: true, error: nil)
        } else {
          completionHandleForStudentInformation(success: false, error: NSError(domain: "getStudentInformation parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getFavoriteMovies"]))
        }
      }
    }
  }
  
  func postStudentInformation(mapString: String, mediaURL: String, latitude: Double, longitude: Double, completionHandlerForStudentInformation: (result: String?, error: NSError?) -> Void) {
    
    let userInfo = UClient.sharedInstance
    
    let parameters = [String:AnyObject]()
    let jsonBody = "{\"uniqueKey\": \"\(userInfo.userID!)\", \"firstName\": \"\(userInfo.firstName!)\", \"lastName\": \"\(userInfo.lastName!)\",\"mapString\": \"\(mapString)\", \"mediaURL\": \"\(mediaURL)\",\"latitude\": \(latitude), \"longitude\": \(longitude)}"
    
    print(jsonBody)
    
    taskForPOSTMethod(Methods.StudentLocation, parameters: parameters, jsonBody: jsonBody) { (results, error) in
      
      if let error = error {
        print(error)
        completionHandlerForStudentInformation(result: nil, error: error)
      } else {
        if let results = results["objectId"] as? String {
          completionHandlerForStudentInformation(result: results, error: nil)
        } else {
          completionHandlerForStudentInformation(result: nil, error: NSError(domain: "postStudentInformation", code: 0, userInfo: [NSLocalizedDescriptionKey : "Could not parse postStudentInformation"]))
        }
      }
    }
  }
}