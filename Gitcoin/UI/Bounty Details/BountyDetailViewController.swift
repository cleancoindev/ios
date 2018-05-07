//
//  StaticViewController.swift
//  StaticTableview
//
//  Created by Craig Clayton on 3/26/18.
//  Copyright © 2018 Spartan Race. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SCLAlertView
import InputBarAccessoryView

class BountyDetailViewController: UITableViewController{
    
    @IBOutlet weak var lblPosted: UILabel!
    @IBOutlet weak var lblFunderInfo: UILabel!
    @IBOutlet weak var lblIssueDesc: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var keywordContainer: UIView!
    
    var bounty: Bounty?
    let tagsField = GitCoinWSTagField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let bounty = bounty{
            setPosted(bounty)
            setFunderInfo(bounty)
            setIssueDesc(bounty)
            set(imageUrl: bounty.avatarUrl)
            set(title: bounty.title)
            set(keywords: bounty.keywordArray)
            set(status: bounty.status)
        }
        
        tableView.estimatedRowHeight = 500.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    func setPosted(_ bounty: Bounty){
        lblPosted.text = "POSTED: \(bounty.createdAgo) - EXP. \(bounty.expiresIn)"
    }
    
    func setFunderInfo(_ bounty: Bounty){
        
        var ownerGithubUsernameString = ""
        var bountyOwnerEmailString = ""
        var tokenValueString = ""
        var usdtDisplayValueString = ""
        
        lblFunderInfo.text = ""
        
        if let ownerGithubUsername = bounty.ownerGithubUsername, !ownerGithubUsername.isEmpty{
            ownerGithubUsernameString = "\(ownerGithubUsername) \n"
            lblFunderInfo.text?.append(ownerGithubUsernameString)
        }
        
        if let bountyOwnerEmail = bounty.bountyOwnerEmail, !bountyOwnerEmail.isEmpty{
            bountyOwnerEmailString = "\(bountyOwnerEmail) \n"
            lblFunderInfo.text?.append(bountyOwnerEmailString)
        }
        
        if !bounty.usdtDisplayValue.isEmpty {
            usdtDisplayValueString = "\(bounty.usdtDisplayValue) \n"
            lblFunderInfo.text?.append(usdtDisplayValueString)
        }
        
        if let tokenValue = bounty.tokenValueString, !tokenValue.isEmpty{
            tokenValueString = "\(tokenValue) \n"
            lblFunderInfo.text?.append(tokenValueString)
        }

    }
    
    func setIssueDesc(_ bounty: Bounty){
        lblIssueDesc.text = bounty.descriptionText
    }
    
    func set(status: String?){
        if let status = status{
            self.lblStatus.text = status
        }
    }
    
    func set(title: String?){
        if let title = title{
            self.lblTitle.text = title
        }
    }
    
    func set(imageUrl: String?){
        if let imageUrl = imageUrl{
            Alamofire.request(imageUrl).responseImage { response in
                if let image = response.result.value {
                    let circularImage = image.af_imageRoundedIntoCircle()
                    
                    self.avatarImageView.image = circularImage
                }
            }
        }
    }
    
    func set(keywords: [String]?){
        
        guard let keywords = keywords else {
            return
        }
        
        tagsField.readOnly = true
        tagsField.translatesAutoresizingMaskIntoConstraints = false
        keywordContainer.addSubview(tagsField)
        
        NSLayoutConstraint.activate([
            tagsField.topAnchor.constraint(equalTo: keywordContainer.topAnchor),
            tagsField.leadingAnchor.constraint(equalTo: keywordContainer.leadingAnchor),
            tagsField.trailingAnchor.constraint(equalTo: keywordContainer.trailingAnchor),
            tagsField.bottomAnchor.constraint(equalTo: keywordContainer.bottomAnchor),
            ])
        
        tagsField.addTags(keywords)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}