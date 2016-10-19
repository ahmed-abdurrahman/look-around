//
//  CategoryModel.swift
//  Look Around
//
//  Created by Ahmed Abdurrahman on 10/19/16.
//  Copyright © 2016 OpenSooq. All rights reserved.
//
import ObjectMapper

class CategoryModel: NSObject, Mappable {
    
    var name: String?
    var icon: IconModel?
    
    override init(){
        super.init()
    }
    
    required init?(_ map: Map){
        
    }

    func mapping(map: Map){
        name <- map["name"]
        icon <- map["icon"]
    }
}
