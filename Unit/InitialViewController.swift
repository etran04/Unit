//
//  ViewController.swift
//  Unit
//
//  Created by Eric Tran on 10/10/15.
//  Copyright © 2015 TheDRE. All rights reserved.
//

import UIKit
import Parse
import Bolts
import ParseUI

class InitialViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    let signUpVC = ParseSignUpVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        //PFUser.logOut()
        if(PFUser.currentUser() != nil) {
            self.performSegueWithIdentifier("goToMainVC", sender: self)
        }
        else {
            let loginVC = ParseLoginVC()
            
            loginVC.fields = [PFLogInFields.UsernameAndPassword, PFLogInFields.LogInButton, PFLogInFields.SignUpButton, PFLogInFields.PasswordForgotten]
            
            signUpVC.fields = [PFSignUpFields.UsernameAndPassword, PFSignUpFields.SignUpButton, PFSignUpFields.Email, PFSignUpFields.DismissButton]
        
            loginVC.signUpController = signUpVC
            loginVC.delegate = self
            signUpVC.delegate = self
            self.presentViewController(loginVC, animated: false, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func logInViewController(controller: PFLogInViewController, didLogInUser user: PFUser) -> Void {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) -> Void {
        // Check if user is suppose to be assigned a team
        let query = PFQuery(className:"EmailToTeam")
        query.findObjectsInBackgroundWithBlock() {
            (emailToTeams: [PFObject]?, error: NSError?) -> Void in
            if error == nil && emailToTeams != nil {
//                if emailToTeams?.count == 0 {
//                    // If emailToTeams doesn't have anything in them, go straight to create team VC
//                    // Special case for no EmailToTeam item in database
//                    // performSegue ("goToCreateTeamVC")
//                }
                
                var foundMatch = false
                for email in emailToTeams! {
                    // Found that the email matches, user was invited to a team basically
                    if email["Email"] as! String == (PFUser.currentUser()?.email)!{
                        
                        let invitedTo = email["TeamName"]
                        
                        // Get a list of all teams with the
                        let teams = PFQuery(className:"Team")
                        teams.whereKey("name", equalTo:invitedTo)
                        teams.getFirstObjectInBackgroundWithBlock {
                            (teamToAdd: PFObject?, error: NSError?) -> Void in
                            if error == nil {
                                // For each team, add it to the user's list of teams
                                PFUser.currentUser()?.addObject(teamToAdd!, forKey: "TeamIds")
                            } else {
                                // Log details of the failure
                                print("Error on query for teams")
                            }
                        }
                        foundMatch = true
                    }
                }
                    
                if !foundMatch {
                    // Couldn't find a match for emailToTeams
                    // performSegue("goToCreateTeamVC")
                }
                
            } else {
                print("Error on query for EmailToTeam")
            }
        }

        self.signUpVC.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) -> Void {
        self.signUpVC.dismissViewControllerAnimated(true, completion: nil)
    }
}