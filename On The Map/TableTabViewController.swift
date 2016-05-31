//
//  TableTabViewController.swift
//  On The Map
//
//  Created by Raghav Mangrola on 5/28/16.
//  Copyright © 2016 Raghav Mangrola. All rights reserved.
//

import UIKit

class TableTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  var studentLocations: [StudentInformation] = [StudentInformation]()
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    ParseClient.sharedInstance().getStudentInformation { (results) in
      if let studentLocations = results {
        self.studentLocations = studentLocations
        performUIUpdatesOnMain {
          self.tableView.reloadData()
        }
      }
    }
  }
  
  // MARK: UITableViewDataSource Methods
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("studentInfo", forIndexPath: indexPath)
    cell.textLabel?.text = ("\(studentLocations[indexPath.row].firstName) \(studentLocations[indexPath.row].lastName)")
    cell.imageView?.image = UIImage(named: "pin")
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return studentLocations.count
  }
  
  // MARK: UITableViewDelegate Methods
}
