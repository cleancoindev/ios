//
//  ProfileBountyContainerViewController.swift
//  Gitcoin
//
//  Created by John Brunelle on 3/4/18.
//  Copyright © 2018 Gitcoin. All rights reserved.
//

import UIKit
import BetterSegmentedControl

class ProfileBountyContainerViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var segControlContainer: UIView!
    @IBOutlet weak var controlXAxisConstraint: NSLayoutConstraint!
    
    // MARK: - Bounty Detail and Discuss View Controllers
    
    private lazy var accountViewController: ProfileContainerViewController = {
        let storyboard = UIStoryboard(name: "ProfileContainerViewController", bundle: Bundle.main)
        var viewController = storyboard.instantiateInitialViewController() as! ProfileContainerViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    private lazy var claimedViewController: ProfileClaimedViewController = {
        let storyboard = UIStoryboard(name: "ProfileClaimedViewController", bundle: Bundle.main)
        var viewController = storyboard.instantiateInitialViewController() as! ProfileClaimedViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    private lazy var savedViewController: ProfileSavedViewController = {
        let storyboard = UIStoryboard(name: "ProfileSavedViewController", bundle: Bundle.main)
        var viewController = storyboard.instantiateInitialViewController() as! ProfileSavedViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "PROFILE"
        
        let control = BetterSegmentedControl(
            frame: CGRect(x: 0, y: 0, width: segControlContainer.bounds.width-20, height: segControlContainer.bounds.height),
            titles: ["My Account", "Bounties Saved", "Started Bounties"],
            index: 0,
            options: [.backgroundColor(.white),
                      .titleColor(UIColor(red:13/255, green:0.0, blue:60/255, alpha:1.00)),
                      .indicatorViewBackgroundColor(UIColor(red:13/255, green:0.0, blue:60/255, alpha:1.00)),
                      .selectedTitleColor(.white),
                      .titleBorderWidth(1.0),
                      .cornerRadius(6.0),
                      .titleFont(UIFont(name: "FuturaStd-Book", size: 12.0)!),
                      .selectedTitleFont(UIFont(name: "FuturaStd-Book", size: 12.0)!)]
        )
        
        control.addTarget(self, action: #selector(BountyDetailsContainerViewController.navigationSegmentedControlValueChanged(_:)), for: .valueChanged)
        
        let xConstraint = (view.bounds.width - control.bounds.width)/2.0

        controlXAxisConstraint.constant = xConstraint
        
        let customSubview = UIView(frame: CGRect(x: 0, y: 0, width: control.frame.width, height: control.frame.height))
        customSubview.backgroundColor = .clear
        customSubview.layer.borderColor = UIColor(red:13/255, green:0.0, blue:60/255, alpha:1.00).cgColor
        customSubview.layer.borderWidth = 1.0
        customSubview.layer.cornerRadius = 6.0
        
        control.addSubview(customSubview)
        segControlContainer.addSubview(control)
        
        add(asChildViewController: accountViewController)
    }
    
    // MARK: - Segmented Action handlers
    @objc func navigationSegmentedControlValueChanged(_ sender: BetterSegmentedControl) {
        if sender.index == 0 {
            add(asChildViewController: accountViewController)
            remove(asChildViewController: claimedViewController)
            remove(asChildViewController: savedViewController)
        }
        else if sender.index == 1 {
            add(asChildViewController: savedViewController)
            remove(asChildViewController: claimedViewController)
            remove(asChildViewController: accountViewController)
        }
        else {
            add(asChildViewController: claimedViewController)
            remove(asChildViewController: savedViewController)
            remove(asChildViewController: accountViewController)
        }
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        containerView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }
    
}
