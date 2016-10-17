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
    
    func getNearbyVenues(success: () -> Void, fail: (error: NSError) -> Void) {
    
        let url = UrlBuilderUtil.exploreUrl
        let params: [String: AnyObject] = [
            "client_id": Keys.forsquareClientId,
            "client_secret": Keys.forsquareClientSecret,
            "near": "Chicago, IL",
            "section": "topPicks",
//            "v":"20161017"
        ]
        
        Alamofire.request(.GET, url, parameters: params).responseJSON { (response) in
            if let error = HttpErrorHandler.checkResponseForErrors(response) {
                print(#function, ": ", error.localizedDescription)
                fail(error: error)
            } else {
                
                if let value = response.result.value {
                    let json = JSON(value)
                    print(json)
//                    let responseModel = Mapper<FAQResponseModel>().map(json.object)!
                    
                    
//                    success(faqModel: responseModel)
                }
            }
        }
    }
}
