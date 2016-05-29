//
//  StudentLocation.swift
//  On The Map
//
//  Created by Raghav Mangrola on 5/28/16.
//  Copyright © 2016 Raghav Mangrola. All rights reserved.
//


struct StudentLocation {
  
  let firstName: String
  let lastName: String
  
  init(dictionary: [String:AnyObject]) {
    firstName = dictionary["firstName"] as! String
    lastName = dictionary["lastName"] as! String
  }
  
  static func studentLocationsFromResults(results: [[String:AnyObject]]) -> [StudentLocation] {
    var studentLocations = [StudentLocation]()
    
    for result in results {
      studentLocations.append(StudentLocation(dictionary: result))
    }
    
    return studentLocations
  }
}