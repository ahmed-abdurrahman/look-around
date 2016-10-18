//
//  VenueModel.swift
//  Look Around
//
//  Created by Ahmed Abdurrahman on 10/18/16.
//  Copyright © 2016 OpenSooq. All rights reserved.
//

import Foundation
import ObjectMapper

class VenueModel: NSObject, Mappable {
    
    var id: String?
    var name: String?
    var rating: Float?
    var url: String?
    var ratingColor: String?
    var location: LocationModel?
    
    override init(){
        super.init()
    }
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map){
        id <- map["id"]
        name <- map["name"]

        rating <- map["rating"]
        ratingColor <- map["ratingColor"]
        url <- map["url"]
        location <- map["location"]
    }
}
