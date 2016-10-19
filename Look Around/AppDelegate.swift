//
//  AppDelegate.swift
//  Look Around
//
//  Created by Ahmed Abdurrahman on 10/17/16.
//  Copyright © 2016 OpenSooq. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
    
         GMSServices.provideAPIKey(Keys.googleMapsKey)
        return true
    }
    
}

