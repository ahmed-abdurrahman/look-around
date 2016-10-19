//
//  SelectSectionViewController.swift
//  Look Around
//
//  Created by Ahmed Abdurrahman on 10/18/16.
//  Copyright © 2016 OpenSooq. All rights reserved.
//

import UIKit

class SelectSectionViewController: UIViewController {

    var selectedSection: ForsquareSection!
    

    @IBAction func tappedCancel() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SelectSectionViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ForsquareSection.allValues.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SectionCell") as! SectionCell
        
        cell.lblSectionTitle.text = ForsquareSection.allValues[indexPath.row].rawValue.presentableString()
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.selectedSection = ForsquareSection.allValues[indexPath.row]
        
        self.performSegueWithIdentifier("UnwindSelectSection", sender: self)
    }
}
