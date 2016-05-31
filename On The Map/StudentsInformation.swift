//
//  StudentsInformation.swift
//  On The Map
//
//  Created by Raghav Mangrola on 5/31/16.
//  Copyright © 2016 Raghav Mangrola. All rights reserved.
//

class StudentsInformation {
  
  var studentsInformation: [StudentInformation]?
  
  class func sharedInstance() -> StudentsInformation {
    struct Singleton {
      static var sharedInstance = StudentsInformation()
    }
    return Singleton.sharedInstance
  }
}