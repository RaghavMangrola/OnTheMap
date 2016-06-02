//
//  GCDBlackBox.swift
//  On The Map
//
//  Created by Raghav Mangrola on 5/28/16.
//  Copyright © 2016 Raghav Mangrola. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(updates: () -> Void) {
  dispatch_async(dispatch_get_main_queue()) {
    updates()
  }
}