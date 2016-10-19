//
//  IconModel.swift
//  Look Around
//
//  Created by Ahmed Abdurrahman on 10/19/16.
//  Copyright © 2016 OpenSooq. All rights reserved.
//

import ObjectMapper

class IconModel: NSObject, Mappable {
    
    var prefix: String?
    var suffix: String?
    
    override init(){
        super.init()
    }
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map){
        prefix <- map["prefix"]
        suffix <- map["suffix"]
    }
}
