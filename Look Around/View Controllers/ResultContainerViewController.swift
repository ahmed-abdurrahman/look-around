//
//  SearchResultViewController.swift
//  Look Around
//
//  Created by Ahmed Abdurrahman on 10/17/16.
//  Copyright © 2016 OpenSooq. All rights reserved.
//

import UIKit
import CoreLocation

class ResultContainerViewController: BaseViewController {

    // MARK: - Instance Variables
    enum TabIndex : Int {
        case ListTab = 0
        case MapTab = 1
    }
    
    var venues = [VenueModel]()
    var section: ForsquareSection!
    var location: CLLocationCoordinate2D!
    
    var currentViewController: UIViewController?
    lazy var resultTabVC: UIViewController? = {
        let resultTabVC = self.storyboard?.instantiateViewControllerWithIdentifier("ResultListViewController") as! ResultListViewController
        resultTabVC.venues = self.venues
        return resultTabVC
    }()
    lazy var mapTabVC : UIViewController? = {
        let mapTabVC = self.storyboard?.instantiateViewControllerWithIdentifier("MapViewController") as! MapViewController
        mapTabVC.venues = self.venues
        mapTabVC.location = self.location
        return mapTabVC
    }()

    // MARK: - IB Outlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Lifecycle
    override func configureView() {
        super.configureView()
        
        segmentedControl.selectedSegmentIndex = TabIndex.ListTab.rawValue
        displayCurrentTab(TabIndex.ListTab.rawValue)
        self.navigationItem.title = section.rawValue.presentableString()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let currentViewController = currentViewController {
            currentViewController.viewWillDisappear(animated)
        }
    }

    
    // MARK: - Actions
    @IBAction func switchTab(sender: UISegmentedControl) {
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParentViewController()
        
        displayCurrentTab(sender.selectedSegmentIndex)
    }
    
    func displayCurrentTab(tabIndex: Int){
        if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
            
            self.addChildViewController(vc)
            vc.didMoveToParentViewController(self)
            
            vc.view.frame = self.containerView.bounds
            self.containerView.addSubview(vc.view)
            self.currentViewController = vc
        }
    }
    
    func viewControllerForSelectedSegmentIndex(index: Int) -> UIViewController? {
        var vc: UIViewController?
        switch index {
        case TabIndex.ListTab.rawValue :
            vc = resultTabVC
        case TabIndex.MapTab.rawValue :
            vc = mapTabVC
        default:
            return nil
        }
        
        return vc
    }
}
