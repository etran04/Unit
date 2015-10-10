//
//  ParseLoginViewController.swift
//  Unit
//
//  Created by Ryan Lee on 10/10/15.
//  Copyright © 2015 TheDRE. All rights reserved.
//

import Foundation
import Parse
import Bolts
import ParseUI

class ParseLoginVC : PFLogInViewController, PFSignUpViewControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fields = [PFLogInFields.UsernameAndPassword, PFLogInFields.LogInButton, PFLogInFields.SignUpButton, PFLogInFields.PasswordForgotten]
    }
    
    override func viewDidAppear(animated: Bool) {
        if(PFUser.currentUser() != nil) {
            //self.performSegueWithIdentifier("goToMainVC", sender: self)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
