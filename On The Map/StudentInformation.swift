//
//  StudentLocation.swift
//  On The Map
//
//  Created by Raghav Mangrola on 5/28/16.
//  Copyright © 2016 Raghav Mangrola. All rights reserved.
//


struct StudentInformation {
  
  let firstName: String
  let lastName: String
  
  init(dictionary: [String:AnyObject]) {
    firstName = dictionary["firstName"] as! String
    lastName = dictionary["lastName"] as! String
  }
  
  static func studentInformationFromResults(results: [[String:AnyObject]]) -> [StudentInformation] {
    var studentInformation = [StudentInformation]()
    
    for result in results {
      studentInformation.append(StudentInformation(dictionary: result))
    }
    
    return studentInformation
  }
}