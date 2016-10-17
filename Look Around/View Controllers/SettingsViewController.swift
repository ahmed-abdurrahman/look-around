//
//  SettingsViewController.swift
//  Look Around
//
//  Created by Ahmed Abdurrahman on 10/17/16.
//  Copyright © 2016 OpenSooq. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.displayActivityIndicator("Contacting Forsquare..")
        ForsquareService.sharedInstance.getNearbyVenues({
            self.hideActivityIndicator()
            // success
            }) { (error) in
                self.hideActivityIndicator()
                self.displayErrorMessage(error.localizedDescription)
        }
    }

}
