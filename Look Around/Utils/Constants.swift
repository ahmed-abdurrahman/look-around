//
//  Constants.swift
//  Look Around
//
//  Created by Ahmed Abdurrahman on 10/17/16.
//  Copyright © 2016 OpenSooq. All rights reserved.
//

import Foundation

struct Keys {

    static let forsquareClientId = "G405S3D4ORXT1Y0PJZFVUUOFARTAYE003WLO3XTSERVF12PT"
    static let forsquareClientSecret = "3UTFUB3AJ42SCZK4KA23P4IUNRVKNHHRC223INROFXOU2O1J"
}

enum ForsquareSection: String {
    case Food = "food"
    case Drinks = "drinks"
    case Coffee = "coffee"
    case Shops = "shops"
    case Arts = "arts"
    case Outdoors = "outdoors"
    case Sights = "sights"
    case Trending = "trending"
    case Specials = "specials"
    case TopPicks = "topPicks"
    
    static let allValues = [Food, Drinks, Coffee, Shops, Arts, Outdoors, Sights, Trending, Specials, TopPicks]
}
