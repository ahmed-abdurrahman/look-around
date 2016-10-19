//
//  MapViewController.swift
//  Look Around
//
//  Created by Ahmed Abdurrahman on 10/17/16.
//  Copyright © 2016 OpenSooq. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import DynamicColor

class MapViewController: BaseViewController {

    @IBOutlet weak var mapView: UIView!
    let detailsSegue = "MapToDetailsSegue"
    
    var location: CLLocationCoordinate2D!
    var venues = [VenueModel]()
    var map: GMSMapView!
    var selectedVenue: VenueModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func configureView() {
        super.configureView()
        
        displayMap()
    }
 
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        map.frame = mapView.bounds
    }
    
    func displayMap() {
        let camera = GMSCameraPosition.cameraWithLatitude(location.latitude,
                                                          longitude: location.longitude, zoom: 13)
        map = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        
        map.settings.compassButton = true
        map.settings.myLocationButton = true
        map.delegate = self
        
        self.mapView.addSubview(map)
        
        self.addVenuesMarkers()
    }
    
    func addVenuesMarkers(){
        for venue in venues {
            
            if let location = venue.location {
                let position = CLLocationCoordinate2DMake(location.lat!, location.long!)
                let marker = GMSMarker(position: position)
                marker.title = venue.name!
                marker.userData = venue
                if let address = location.address {
                    marker.snippet = address
                    if let rating = venue.rating {
                        marker.snippet = marker.snippet! + " - rating \(rating)"
                    }
                    
                }
                
                if let ratingColor = venue.ratingColor {
                    marker.icon = GMSMarker.markerImageWithColor(UIColor(hexString: ratingColor))
                }
                
                marker.map = self.map
            }
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == detailsSegue {
            let detailsVC = segue.destinationViewController as! VenueDetailsViewController
            detailsVC.venue = selectedVenue
        }
    }

}


extension MapViewController: GMSMapViewDelegate {

    func mapView(mapView: GMSMapView, didTapInfoWindowOfMarker marker: GMSMarker) {
        selectedVenue = marker.userData as! VenueModel
        self.performSegueWithIdentifier(detailsSegue, sender: self)
    }
    
}
