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
  @IBAction func logoutButtonPressed(sender: AnyObject) {
    UClient.sharedInstance.deleteSession() { (success, error) in
      if success {
        UClient.sharedInstance.logout(self)
      } else {
        self.displayError(error!)
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.reloadData()
  }

  // MARK: UITableViewDataSource Methods
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("studentInfo", forIndexPath: indexPath)
    cell.textLabel?.text = ("\(studentsInformationInstance.studentsInformation[indexPath.row].firstName) \(studentsInformationInstance.studentsInformation[indexPath.row].lastName)  \(studentsInformationInstance.studentsInformation[indexPath.row].mediaURL)")
    cell.imageView?.image = UIImage(named: "pin")
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return studentsInformationInstance.studentsInformation.count
    
  }
  
  // MARK: UITableViewDelegate Methods
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let app = UIApplication.sharedApplication()
    let toOpen = studentsInformationInstance.studentsInformation[indexPath.row].mediaURL
    app.openURL(NSURL(string: toOpen)!)
  }
  
  func displayError(error: NSError) {
    dispatch_async(dispatch_get_main_queue()) {
      let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
      let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
      alert.addAction(action)
      self.presentViewController(alert, animated: true, completion: nil)
    }
  }
}
