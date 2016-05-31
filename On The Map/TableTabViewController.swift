//
//  TableTabViewController.swift
//  On The Map
//
//  Created by Raghav Mangrola on 5/28/16.
//  Copyright © 2016 Raghav Mangrola. All rights reserved.
//

import UIKit

class TableTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  let studentsInformation = StudentsInformation.sharedInstance
  
  @IBOutlet weak var tableView: UITableView!
  

  // MARK: UITableViewDataSource Methods
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("studentInfo", forIndexPath: indexPath)
    cell.textLabel?.text = ("\(studentsInformation.studentsInformation[indexPath.row].firstName) \(studentsInformation.studentsInformation[indexPath.row].lastName)")
    cell.imageView?.image = UIImage(named: "pin")
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return studentsInformation.studentsInformation.count
    
  }
  
  // MARK: UITableViewDelegate Methods
}
