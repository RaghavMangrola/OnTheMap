//
//  TableTabViewController.swift
//  On The Map
//
//  Created by Raghav Mangrola on 5/28/16.
//  Copyright © 2016 Raghav Mangrola. All rights reserved.
//

import UIKit

class TableTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  let studentsInformationInstance = StudentsInformation.sharedInstance

  
  @IBOutlet weak var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    studentsInformationInstance.studentsInformation.sortInPlace() {
      $0.updatedAt > $1.updatedAt
    }
    tableView.reloadData()
  }

  // MARK: UITableViewDataSource Methods
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("studentInfo", forIndexPath: indexPath)
    cell.textLabel?.text = ("\(studentsInformationInstance.studentsInformation[indexPath.row].firstName) \(studentsInformationInstance.studentsInformation[indexPath.row].lastName)")
    cell.imageView?.image = UIImage(named: "pin")
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return studentsInformationInstance.studentsInformation.count
    
  }
  
  // MARK: UITableViewDelegate Methods
}
