//
//  ContactModel.swift
//  Look Around
//
//  Created by Ahmed Abdurrahman on 10/19/16.
//  Copyright © 2016 OpenSooq. All rights reserved.
//

import ObjectMapper

class ContactModel: NSObject, Mappable {
    
    var phone: String?
    var formattedPhone: String?
    
    override init(){
        super.init()
    }
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map){
        phone <- map["phone"]
        formattedPhone <- map["formattedPhone"]
    }
}
