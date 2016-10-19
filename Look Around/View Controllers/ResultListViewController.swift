//
//  ResultListViewController.swift
//  Look Around
//
//  Created by Ahmed Abdurrahman on 10/17/16.
//  Copyright © 2016 OpenSooq. All rights reserved.
//

import UIKit

class ResultListViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var venues = [VenueModel]()
    
    let detailsSegue = "ListToDetailsSegue"
    var selectedVenue: VenueModel!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == detailsSegue {
            let detailsVC = segue.destinationViewController as! VenueDetailsViewController
            detailsVC.venue = selectedVenue
        }
    }
}

extension ResultListViewController: UITableViewDelegate, UITableViewDataSource {

   
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCellWithIdentifier("VenueCell") as! VenuTableViewCell
        
        cell.venueModel = venues[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.selectedVenue = venues[indexPath.row]
        self.performSegueWithIdentifier(detailsSegue, sender: self)
    }
}
