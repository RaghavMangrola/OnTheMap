//
//  StudentLocation.swift
//  On The Map
//
//  Created by Raghav Mangrola on 5/28/16.
//  Copyright © 2016 Raghav Mangrola. All rights reserved.
//

import Foundation

struct StudentInformation {
  
  let firstName: String
  let lastName: String
  let mapString: String
  let mediaURL: String
  let latitude: Double
  let longitude: Double
  let createdAt: String
  let updatedAt: String
  
  init(dictionary: [String:AnyObject]) {
    firstName = dictionary["firstName"] as! String
    lastName = dictionary["lastName"] as! String
    mapString = dictionary["mapString"] as! String
    mediaURL = dictionary["mediaURL"] as! String
    latitude = dictionary["latitude"] as! Double
    longitude = dictionary["longitude"] as! Double
    createdAt = dictionary["createdAt"] as! String
    updatedAt = dictionary["updatedAt"] as! String
  }
  
  static func studentInformationFromResults(results: [[String:AnyObject]]) -> [StudentInformation] {
    var studentInformation = [StudentInformation]()
    
    for result in results {
      studentInformation.append(StudentInformation(dictionary: result))
    }
    
    return studentInformation
  }
}