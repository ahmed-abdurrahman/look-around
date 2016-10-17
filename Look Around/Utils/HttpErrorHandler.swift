//
//  HttpErrorHandler.swift
//  Look Around
//
//  Created by Ahmed Abdurrahman on 10/17/16.
//  Copyright © 2016 OpenSooq. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

class HttpErrorHandler {
    
    static let generalErrorUserInfo = [NSLocalizedDescriptionKey: NSLocalizedString("Oops, something went wrong, check your network and try again later.", comment: "General networking error message")]
    
    static func checkResponseForErrors(response: Response<AnyObject, NSError>) -> NSError? {
        
        if let statusCode = response.response?.statusCode {
            switch statusCode {
                
                // Alamofire return a nil response body incase of requet failure after validation.
            // So we skipe validation and check for the code manually.
            case 200..<300:
                // Success
                return nil
            default:
                if let value = response.result.value {
                    let json = JSON(value)
                    if  let jsonErrorMessage = json["meta"]["errorDetail"].string, code = json["meta"]["code"].int {
                        
                        let message = jsonErrorMessage
                        
                        return NSError(domain: "", code: code, userInfo: [NSLocalizedDescriptionKey: message])
                    }
                }
            }
        }
        
        return NSError(domain: "", code: -1001, userInfo: generalErrorUserInfo)
    }

}
