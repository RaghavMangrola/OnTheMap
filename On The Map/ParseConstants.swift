//
//  ParseConstants.swift
//  On The Map
//
//  Created by Raghav Mangrola on 6/2/16.
//  Copyright © 2016 Raghav Mangrola. All rights reserved.
//

extension ParseClient {
  
  struct Constants {
    static let ApiScheme = "https"
    static let ApiHost = "api.parse.com"
    static let ApiPath = "/1"
  }
  
  struct Methods {
    static let StudentLocation = "/classes/StudentLocation"
  }
  
  struct JSONResponseKeys {
    static let StudentLocations = "results"
  }
  
  struct ParameterKeys {
    static let Limit = "limit"
    static let Order = "order"
  }
  
  struct ParameterValues {
    static let Limit = "100"
    static let Order = "-updatedAt"
  }
}