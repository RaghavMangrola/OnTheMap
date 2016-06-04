//
//  InformationPostingViewController.swift
//  On The Map
//
//  Created by Raghav Mangrola on 6/1/16.
//  Copyright © 2016 Raghav Mangrola. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class InformationPostingViewController: UIViewController, MKMapViewDelegate, UITextFieldDelegate {
  
  let userInfo = UClient.sharedInstance
  var coordinate: CLLocationCoordinate2D? = nil
  
  @IBOutlet weak var studyingLabel: UILabel!
  @IBOutlet weak var locationTextField: UITextField!
  @IBOutlet weak var findOnMapButton: UIButton!
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var urlSubmissionTextField: UITextField!
  @IBOutlet weak var submitButton: UIButton!
  
  @IBAction func cancelButtonPressed(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func findOnMapButtonPressed(sender: AnyObject) {
    let activitiyIndicator = UIActivityIndicatorView()
    activitiyIndicator.frame = CGRectMake(0, 0, 40, 40)
    activitiyIndicator.activityIndicatorViewStyle = .Gray
    activitiyIndicator.center = CGPointMake(view.bounds.width / 2, view.bounds.height / 2)
    view.addSubview(activitiyIndicator)
    activitiyIndicator.startAnimating()
    let geocoder = CLGeocoder()
    
    geocoder.geocodeAddressString(locationTextField.text!) { (placemark, error) in
      if (error != nil) {
        activitiyIndicator.stopAnimating()
        activitiyIndicator.removeFromSuperview()
        self.displayError(NSError(domain: "geocoder", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to Geocode"]))
      } else {
        activitiyIndicator.stopAnimating()
        activitiyIndicator.removeFromSuperview()
        self.coordinate = placemark?.first?.location?.coordinate
        self.configureMapView(self.coordinate!)
        self.configureUI()
      }
    }
  }
  
  @IBAction func submitButtonPressed(sender: AnyObject) {
    ParseClient.sharedInstance.postStudentInformation(locationTextField.text!, mediaURL: urlSubmissionTextField.text!, latitude: (coordinate?.latitude)!, longitude: (coordinate?.longitude)!) { (result, error) in
      if (error != nil) {
        self.displayError(NSError(domain: "postStudentInformation", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to post student info"]))
      } else {
        self.dismissViewControllerAnimated(true, completion: nil)
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    locationTextField.delegate = self
    urlSubmissionTextField.delegate = self
    hideKeyboardWhenTappedAround()
  }
  
  func configureUI() {
    studyingLabel.hidden = true
    locationTextField.hidden = true
    findOnMapButton.hidden = true
    mapView.hidden = false
    urlSubmissionTextField.hidden = false
    submitButton.hidden = false
  }
  
  func configureMapView(coordinate: CLLocationCoordinate2D) {
    let annotation = MKPointAnnotation()
    annotation.coordinate = coordinate
    let camera = MKMapCamera()
    camera.centerCoordinate = coordinate
    self.mapView.setCenterCoordinate(coordinate, animated: true)
    self.mapView.addAnnotation(annotation)
    self.mapView.setCamera(camera, animated: true)
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
