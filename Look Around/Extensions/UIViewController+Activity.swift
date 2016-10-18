//
//  UIViewController+Activity.swift
//  Look Around
//
//  Created by Ahmed Abdurrahman on 10/18/16.
//  Copyright © 2016 OpenSooq. All rights reserved.
//
import MBProgressHUD

import Foundation
extension UIViewController {
    
    func displayErrorMessage(errorMessage: String)  {
        
        var message: String
        
        if errorMessage.characters.count <= 0 {
            message = NSLocalizedString("An unhandled error has occurred. Please try again.", comment: "")
        } else {
            message = errorMessage
        }
        
        
        self.displayNotificationMessage(NSLocalizedString("Error", comment: ""),
                                        message: message,
                                        image: nil)
    }
    
    func displayNotificationMessage(title: String?, message: String, image: UIImage?, handler: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertActionStyle.Default, handler: { (alertAction) in
            handler?()
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        //        alert.view.tintColor = ThemeUtil.BrandGreen
    }
    
    
    func displayActivityIndicator() {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true);
    }
    
    func displayActivityIndicator(text: String) {
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true);
        hud.labelText = text
    }
    
    
    func hideActivityIndicator() {
        MBProgressHUD.hideHUDForView(self.view, animated: true)
    }

}
