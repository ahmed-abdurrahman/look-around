//
//  SettingsViewController.swift
//  Look Around
//
//  Created by Ahmed Abdurrahman on 10/17/16.
//  Copyright © 2016 OpenSooq. All rights reserved.
//

import UIKit
import CoreLocation

class SettingsViewController: BaseViewController {

    let locationManager = CLLocationManager()
    var deviceCoordinates: CLLocationCoordinate2D? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.deviceCoordinates = locationManager.location?.coordinate
        
        
        self.displayActivityIndicator("Connecting with Forsquare...")
        ForsquareService.sharedInstance.getNearbyVenues(deviceCoordinates?.latitude, long: deviceCoordinates?.longitude, success: { venues in
            self.hideActivityIndicator()
            for v in venues {
                print(">>>> \(v.name!) : \(v.id!)")
            }
            
            }) { (error) in
                self.hideActivityIndicator()
                self.displayErrorMessage(error.localizedDescription)
        }
    }

}

extension SettingsViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status == .AuthorizedWhenInUse {
            // 4
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = manager.location  else {return}
        self.deviceCoordinates = location.coordinate
        self.locationManager.stopUpdatingLocation()
        
        print("Device Coordinates: \(deviceCoordinates?.latitude), \(deviceCoordinates?.longitude)")
    }
    
}
