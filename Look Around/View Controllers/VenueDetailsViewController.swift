//
//  VenueDetailsViewController.swift
//  Look Around
//
//  Created by Ahmed Abdurrahman on 10/18/16.
//  Copyright © 2016 OpenSooq. All rights reserved.
//

import UIKit
import GoogleMaps
import DynamicColor
import SDWebImage

class VenueDetailsViewController: BaseViewController {

    @IBOutlet weak var imgCategoryBackground: UIImageView!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var imgCategory: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblRatingsCount: UILabel!
    
    @IBOutlet weak var lblAddress: UILabel!
    
    var venue: VenueModel!
    var map: GMSMapView!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        map.frame = mapView.bounds
    }
    
    override func configureView() {
        lblName.text = venue.name
        
        
        if let location = venue.location {
            let loc = CLLocationCoordinate2D(latitude: location.lat!, longitude: location.long!)
            displayMap(loc)

            
            lblAddress.text = "Nearby"
            
            if let formattedAddress = location.formattedAddress {
                var address = ""
                for addressLine in formattedAddress {
                    address += addressLine + "\n"
                }
                
                lblAddress.text = address
                
            }
        }
        
        if let cats = venue.categories where cats.count > 0 {
            let category = cats[0]
            lblInfo.text = category.name
            
            if let icon = category.icon {
                let catIconUrl = icon.prefix!.stringByReplacingOccurrencesOfString("\\", withString: "")
                    + "100"
                    + icon.suffix!.stringByReplacingOccurrencesOfString("\\", withString: "")
                
                imgCategory.sd_setImageWithURL(NSURL(string: catIconUrl))
                imgCategoryBackground.sd_setImageWithURL(NSURL(string: catIconUrl))
            }
        }
    
        lblRating.layer.cornerRadius = 8
        lblRating.clipsToBounds = true
        if let rating = venue.rating {
            lblRating.text = "\(rating)"
            lblRating.backgroundColor = UIColor(hexString: venue.ratingColor!)
        } else {
            lblRating.text = "-"
            lblRating.backgroundColor = UIColor.lightGrayColor()
        }
        
        if let signals = venue.ratingSignals {
            
            lblRatingsCount.text = "\(signals) ratings"
        }
        
        
    }
    
    func displayMap(location: CLLocationCoordinate2D) {
        let camera = GMSCameraPosition.cameraWithLatitude(location.latitude,
                                                          longitude: location.longitude, zoom: 15)
        map = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        
        map.settings.compassButton = true
        map.settings.myLocationButton = true
        
        self.mapView.addSubview(map)
        
        self.addVenueMarker(location)
    }
    
    
    func addVenueMarker(position: CLLocationCoordinate2D){
       
        let marker = GMSMarker(position: position)
        marker.title = venue.name!
        marker.userData = venue
        if let address = venue.location?.address {
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
