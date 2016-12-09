//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Ryan Anderson on 12/7/16.
//  Copyright © 2016 mranderson. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    var mapView: MKMapView!
    var zoomButton: UIButton!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        mapView = MKMapView()
        mapView.showsUserLocation = true
        view = mapView

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
                
        let segmentedControl = UISegmentedControl(items: ["Standard","Hybrid","Satellite"])
        segmentedControl.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let margins = view.layoutMarginsGuide
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged(segControl:)), for: .valueChanged)
        
        let zoomIcon = UIImage(named: "ZoomIcon")
        zoomButton = UIButton(type: .custom) as UIButton
//        zoomButton.setTitle("", for: .normal)
//        zoomButton.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        zoomButton.setImage(zoomIcon, for: .normal)
        zoomButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(zoomButton)
        
        let zbBottomConstraint = zoomButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -8)
        let zbTrailingConstraint = zoomButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        zbBottomConstraint.isActive = true
        zbTrailingConstraint.isActive = true
        
        zoomButton.addTarget(self, action: #selector(zoomToLocation(button:)), for: .touchUpInside)
    }

//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        switch status {
//        case .denied:
//            print("location denied")
//        case .authorizedWhenInUse:
//            print("location when in use")
//        case .notDetermined:
//            manager.requestWhenInUseAuthorization()
//            print("location not determined")
//        default:
//            break
//        }
//    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        locationManager?.stopUpdatingLocation()
//        locationManager?.store(location: locations, callback: { (stored) in
//        })
//    }

    func mapTypeChanged(segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
            break
        case 1:
            mapView.mapType = .hybrid
            break
        case 2:
            mapView.mapType = .satellite
            break
        default:
            break
        }
    }
    
    func zoomToLocation(button: UIButton) {
        let location = (mapView.userLocation.location?.coordinate)!

//        let lat: CLLocationDegrees = location.latitude
//        let lng: CLLocationDegrees = location.longitude
//        print("\(lat), \(lng)")
//        mapView.setCenter(location, animated: true)

        let latDelta:CLLocationDegrees = 0.5
        let lonDelta:CLLocationDegrees = 0.5
        let span = MKCoordinateSpanMake(latDelta, lonDelta)
        let region = MKCoordinateRegionMake(location, span)

        mapView.setRegion(region, animated: true)
    }
    
}
