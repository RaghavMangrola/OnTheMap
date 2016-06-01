//
//  MapTabViewController.swift
//  On The Map
//
//  Created by Raghav Mangrola on 5/28/16.
//  Copyright © 2016 Raghav Mangrola. All rights reserved.
//

import UIKit
import MapKit

class MapTabViewController: UIViewController, MKMapViewDelegate {
  
  let studentsInformation = StudentsInformation.sharedInstance
  var annotations = [MKPointAnnotation]()
  
  @IBOutlet weak var mapView: MKMapView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print(view.subviews)
    downloadData()
  }
  
  func downloadData() {
    let activitiyIndicator = UIActivityIndicatorView()
    activitiyIndicator.frame = CGRectMake(0, 0, 40, 40)
    activitiyIndicator.activityIndicatorViewStyle = .WhiteLarge
    activitiyIndicator.center = CGPointMake(view.bounds.width / 2, view.bounds.height / 2)
    view.addSubview(activitiyIndicator)
    activitiyIndicator.startAnimating()

    ParseClient.sharedInstance.getStudentInformation() { (success) in
      if success {
        dispatch_async(dispatch_get_main_queue()) {
          activitiyIndicator.stopAnimating()
          activitiyIndicator.removeFromSuperview()
          self.setupAnnotations()
          print(self.view.subviews)
        }
      }
    }
  }
  
  func setupAnnotations() {
    for studentInformation in studentsInformation.studentsInformation {
      let latitude = CLLocationDegrees(studentInformation.latitude)
      let longitude = CLLocationDegrees(studentInformation.longitude)
      let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
      
      let firstName = studentInformation.firstName
      let lastName = studentInformation.lastName
      let mediaURL = studentInformation.mediaURL
      
      let annotation = MKPointAnnotation()
      annotation.coordinate = coordinate
      annotation.title = "\(firstName) \(lastName)"
      annotation.subtitle = mediaURL
      
      annotations.append(annotation)
    }
     mapView.addAnnotations(annotations)
  }
  
  // MARK: MKMapViewDelegate
  
  func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
    let reuseId = "pin"
    
    var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
    
    if pinView == nil {
      pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
      pinView!.canShowCallout = true
      pinView!.pinTintColor = UIColor.redColor()
      pinView!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
    } else {
      pinView!.annotation = annotation
    }
    
    return pinView
  }
}
