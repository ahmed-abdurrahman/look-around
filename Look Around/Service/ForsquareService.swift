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
    
    func getNearbyVenues(success: (venues: [VenueModel]) -> Void, fail: (error: NSError) -> Void) {
    
        let url = UrlBuilderUtil.exploreUrl
        let params: [String: AnyObject] = [
            "client_id": Keys.forsquareClientId,
            "client_secret": Keys.forsquareClientSecret,
            "near": "Chicago, IL",
            "section": "topPicks",
            "v":"20161017"
        ]
        
        Alamofire.request(.GET, url, parameters: params).responseJSON { (response) in
            if let error = HttpErrorHandler.checkResponseForErrors(response) {
                print(#function, ": ", error.localizedDescription)
                fail(error: error)
            } else if let value = response.result.value {
                    let json = JSON(value)
//                    print(json)
                    
                    
                if let itemsArray = json["response"]["groups"].array {
                    let venuesJSON = itemsArray[0]["items"]
                   
                    let venues = venuesJSON.arrayValue.map { Mapper<VenueModel>().map($0["venue"].object)! }
                    
                    success(venues: venues)
                    return
                }
            }
            
            fail(error: NSError(domain: "", code: -1001, userInfo: HttpErrorHandler.generalErrorUserInfo))
            }
    }
}
