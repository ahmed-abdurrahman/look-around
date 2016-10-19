//
//  ForsquareService.swift
//  Look Around
//
//  Created by Ahmed Abdurrahman on 10/17/16.
//  Copyright © 2016 OpenSooq. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

class ForsquareService {

    // Singleton shared instance
    static let sharedInstance = ForsquareService()
    
    func getNearbyVenues(lat: Double?, long: Double?, limit: Int = 10, section: ForsquareSection = .Food, success: (venues: [VenueModel]) -> Void, fail: (error: NSError) -> Void) {
    
        let url = UrlBuilderUtil.exploreUrl
        var params: [String: AnyObject] = [
            "client_id": Keys.forsquareClientId,
            "client_secret": Keys.forsquareClientSecret,
            "section": section.rawValue,
            "v":"20161010",
            "limit": limit,
            "venuePhotos": 1
        ]
        
        if let lat = lat,
            long = long {
            params["ll"] = "\(lat),\(long)"
        } else {
            params["near"] = "Amman, Jordan"
        }
        
        
        Alamofire.request(.GET, url, parameters: params).responseJSON { (response) in
            if let error = HttpErrorHandler.checkResponseForErrors(response) {
                print(#function, ": ", error.localizedDescription)
                fail(error: error)
            } else if let value = response.result.value {
                    let json = JSON(value)

                    
                    
                if let itemsArray = json["response"]["groups"].array {
                    let venuesJSON = itemsArray[0]["items"]
                    print(venuesJSON)
                    let venues = venuesJSON.arrayValue.map { Mapper<VenueModel>().map($0["venue"].object)! }
                    
                    success(venues: venues)
                    return
                }
            }
            
            fail(error: NSError(domain: "", code: -1001, userInfo: HttpErrorHandler.generalErrorUserInfo))
            }
    }
}
