//
//  SettingsViewController.swift
//  Unit
//
//  Created by Eric Tran on 10/10/15.
//  Copyright © 2015 TheDRE. All rights reserved.
//

import Foundation
import UIKit
import Parse

class SettingsViewController: UIViewController {
    
    @IBAction func logoutButtonPressed(sender: AnyObject) {
        PFUser.logOut()
    }
}