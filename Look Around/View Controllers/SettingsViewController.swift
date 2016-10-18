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

    
    @IBOutlet weak var lblResultLimit: UILabel!
    @IBOutlet weak var btnSection: UIButton!
    @IBOutlet weak var sliderLimit: UISlider!
    let locationManager = CLLocationManager()
    let resultSegue = "ShowResultSegue"
    
    var deviceCoordinates: CLLocationCoordinate2D? = nil
    var venues: [VenueModel]!
    var section: ForsquareSection = .Food
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func configureView() {
        super.configureView()
        
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        btnSection.setTitle(section.rawValue.capitalizedString, forState: .Normal)
        
        lblResultLimit.text = "\(Int(sliderLimit.value))"
    }
    
    @IBAction func sectionChangedWithSegue(segue: UIStoryboardSegue){
    
        let selectSectionVC = segue.sourceViewController as! SelectSectionViewController
        self.section = selectSectionVC.selectedSection
        self.btnSection.setTitle(self.section.rawValue.presentableString(), forState: .Normal)
    }
    
    @IBAction func limitChanged(sender: UISlider) {
        lblResultLimit.text = "\(Int(sender.value))"
    }
    
    
    @IBAction func tappedShowResult() {
        self.deviceCoordinates = locationManager.location?.coordinate
        
        let limit = Int(sliderLimit.value)
        self.displayActivityIndicator("Connecting to Forsquare...")
        ForsquareService.sharedInstance.getNearbyVenues(deviceCoordinates?.latitude,
                                                        long: deviceCoordinates?.longitude,
                                                        section: section,
                                                        limit: limit,
                                                        success: { venues in
            self.hideActivityIndicator()
            self.venues = venues
            self.performSegueWithIdentifier(self.resultSegue, sender: self)
            
        }) { (error) in
            self.hideActivityIndicator()
            self.displayErrorMessage(error.localizedDescription)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == resultSegue {
            let resultVC = segue.destinationViewController as! ResultContainerViewController
            resultVC.venues = venues
            resultVC.section = section
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
