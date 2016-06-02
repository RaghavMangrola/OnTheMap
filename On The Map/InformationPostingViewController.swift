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

class InformationPostingViewController: UIViewController, MKMapViewDelegate {

  @IBOutlet weak var studyingLabel: UILabel!
  @IBOutlet weak var locationTextField: UITextField!
  @IBOutlet weak var findOnMapButton: UIButton!
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var urlSubmissionLabel: UITextField!
  @IBOutlet weak var submitButton: UIButton!
  
  
  
  
  @IBAction func cancelButtonPressed(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func findOnMapButtonPressed(sender: AnyObject) {
    let geocoder = CLGeocoder()
    
    geocoder.geocodeAddressString(locationTextField.text!) { (placemark, error) in
      let coordinate = placemark?.first?.location?.coordinate
      self.configureMapView(coordinate!)
      self.configureUI()
    }
  }
  
  @IBAction func submitButtonPressed(sender: AnyObject) {
    
  }
  
  func configureUI() {
    studyingLabel.hidden = true
    locationTextField.hidden = true
    findOnMapButton.hidden = true
    mapView.hidden = false
    urlSubmissionLabel.hidden = false
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
  
  
}
