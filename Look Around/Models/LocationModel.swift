//
//  LocationModel.swift
//  Look Around
//
//  Created by Ahmed Abdurrahman on 10/18/16.
//  Copyright © 2016 OpenSooq. All rights reserved.
//

import Foundation
import ObjectMapper


class LocationModel: NSObject, Mappable {

    var address: String?
    var city: String?
    var country: String?
    var lat: Double?
    var long: Double?
    
    override init(){
        super.init()
    }
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map){
        address <- map["address"]
        city <- map["city"]
        country <- map["country"]
        lat <- map["lat"]
        long <- map["long"]
    }
}
