//
//  StudentsInformation.swift
//  On The Map
//
//  Created by Raghav Mangrola on 5/31/16.
//  Copyright © 2016 Raghav Mangrola. All rights reserved.
//

class StudentsInformation {
  // http://stackoverflow.com/questions/24024549/using-a-dispatch-once-singleton-model-in-swift/24147830#24147830
  static let sharedInstance = StudentsInformation()
  var studentsInformation = [StudentInformation]()
}