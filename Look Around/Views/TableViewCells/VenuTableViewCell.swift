//
//  VenuCellTableViewCell.swift
//  Look Around
//
//  Created by Ahmed Abdurrahman on 10/18/16.
//  Copyright © 2016 OpenSooq. All rights reserved.
//

import UIKit
import DynamicColor

class VenuTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblVenueName: UILabel!
    @IBOutlet weak var lblVenueAddress: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    
    @IBOutlet weak var lblRatingSignals: UILabel!
    var venueModel: VenueModel? {
        didSet {
            
            if let venue = venueModel {
                lblVenueName.text = venue.name
                if let location = venue.location {
                    
                    
                    lblVenueAddress.text = "Nearby"
                    
                    if let address = location.address {
                        lblVenueAddress.text = address
                    } else if let city = location.city{
                        lblVenueAddress.text = city
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
                
                    lblRatingSignals.text = "\(signals) ratings"
                }
            }
        }
    }
}
