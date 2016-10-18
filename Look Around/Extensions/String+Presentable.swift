//
//  String+Presentable.swift
//  Look Around
//
//  Created by Ahmed Abdurrahman on 10/18/16.
//  Copyright © 2016 OpenSooq. All rights reserved.
//

import Foundation
extension String {
    
    
    
    func presentableString() -> String {
        let str: NSMutableString = NSMutableString(string: self)
        
        let str2: NSMutableString = NSMutableString()
        
        for i:NSInteger in 0  ..< str.length  {
            
            let ch:NSString = str.substringWithRange(NSMakeRange(i, 1))
            if(ch .rangeOfCharacterFromSet(NSCharacterSet.uppercaseLetterCharacterSet()).location != NSNotFound) {
                str2 .appendString(" ")
            }
            
            str2.appendString(ch as String)
        }
        
        
        return str2.capitalizedString
    }

}
