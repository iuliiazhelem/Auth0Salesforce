//
//  ViewController.swift
//  AKAuth0TestApp
//
//  Created by Iuliia Zhelem on 14.07.16.
//  Copyright © 2016 Akvelon. All rights reserved.
//

import UIKit
import Lock

let kSalesforceConnectionName = "salesforce"

class ViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBAction func clickSalesforceButton(sender: AnyObject) {
        
        let success:A0IdPAuthenticationBlock = { (profile, token) in
            dispatch_async(dispatch_get_main_queue()) {
                self.userNameLabel.text = profile.name
                self.userIdLabel.text = profile.userId
            }
        }
            
        let failure = { (error: NSError) in
            print("Oops something went wrong: \(error)")
        }
        
        A0Lock.sharedLock().identityProviderAuthenticator().authenticateWithConnectionName(kSalesforceConnectionName, parameters: nil, success:success, failure: failure)
    }
}
