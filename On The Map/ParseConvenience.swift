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
}