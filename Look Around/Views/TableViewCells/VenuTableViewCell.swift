//
//  VenuCellTableViewCell.swift
//  Look Around
//
//  Created by Ahmed Abdurrahman on 10/18/16.
//  Copyright © 2016 OpenSooq. All rights reserved.
//

import UIKit
import DynamicColor
import SDWebImage

class VenuTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imgCategory: UIImageView!
    @IBOutlet weak var lblVenueName: UILabel!
    @IBOutlet weak var lblVenueAddress: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    
    @IBOutlet weak var lblRatingSignals: UILabel!
    var venueModel: VenueModel? {
        didSet {
            
            if let venue = venueModel {
                lblVenueName.text = venue.name
                
                lblRating.layer.cornerRadius = 8
                lblRating.clipsToBounds = true
                if let rating = venue.rating {
                    lblRating.text = "\(rating)"
                    lblRating.backgroundColor = UIColor(hexString: venue.ratingColor!)
                } else {
                    lblRating.text = "-"
                    lblRating.backgroundColor = UIColor.lightGrayColor()
                }
                
                if let cats = venue.categories where cats.count > 0 {
                    let category = cats[0]
                    lblVenueAddress.text = category.name
                    
                    if let icon = category.icon {
                        let catIconUrl = icon.prefix!.stringByReplacingOccurrencesOfString("\\", withString: "")
                            + "100"
                            + icon.suffix!.stringByReplacingOccurrencesOfString("\\", withString: "")
                        
                        imgCategory.sd_setImageWithURL(NSURL(string: catIconUrl))
                    }
                } else {
                    lblVenueAddress.text = ""
                }
                
                
                if let signals = venue.ratingSignals {
                
                    lblRatingSignals.text = "\(signals) ratings"
                }
            }
        }
    }
}
