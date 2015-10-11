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
    var found : Bool!, didLogin : Bool!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        found = false;
        didLogin = false;
//        self.navigationController?.navigationBar.
    }
    
    
    func getToCreateVC() {
        self.performSegueWithIdentifier("goToCreateTeam", sender: self)
    }
    
    override func viewDidAppear(animated: Bool) {
        if (didLogin == true && found ==  false) {
            self.performSegueWithIdentifier("goToCreateTeam", sender: self)
            self.found = true;
        }
        else if(PFUser.currentUser() != nil) {
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
        
        didLogin = true;
        // Check if user is suppose to be assigned a team
        let query = PFQuery(className:"EmailToTeam")
        query.findObjectsInBackgroundWithBlock({
            (emailToTeams: [PFObject]?, error: NSError?) -> Void in
            if error == nil && emailToTeams != nil {
                
                for email in emailToTeams! {
                    // Found that the email matches, user was invited to a team basically
                    print(email)
                    print(PFUser.currentUser()?.email)
                    if email["Email"] as! String == (PFUser.currentUser()?.email)!{
                        print("email: \(email)")
                        self.found = true
                        return
                    }
                }
                
                if self.found == false {
                    self.getToCreateVC()
                }
                
            } else {
                print("Error on query for EmailToTeam")
            }
            
        })
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) -> Void {
        self.signUpVC.dismissViewControllerAnimated(true, completion: nil)
        
        // Check if user is suppose to be assigned a team
        let query = PFQuery(className:"EmailToTeam")
        query.findObjectsInBackgroundWithBlock({
            (emailToTeams: [PFObject]?, error: NSError?) -> Void in
            if error == nil && emailToTeams != nil {
                for email in emailToTeams! {
                    // Found that the email matches, user was invited to a team basically
                    if email["Email"] as! String == (PFUser.currentUser()?.email)!{
                        
                        let invitedTo = email["TeamName"]
                        // Get the team and add that team to the list of teams for the user
                        let teams = PFQuery(className:"Team")
                        teams.whereKey("name", equalTo:invitedTo)
                        teams.getFirstObjectInBackgroundWithBlock {
                            (teamToAdd: PFObject?, error: NSError?) -> Void in
                            if error == nil {
                                // For each team, add it to the user's list of teams
                                PFUser.currentUser()?.addObject(teamToAdd!, forKey: "TeamIds")
                                PFUser.currentUser()!.saveInBackgroundWithBlock({(success: Bool, error: NSError?) -> Void in
                                    teamToAdd?.addObject((PFUser.currentUser())!, forKey: "Users")
                                    teamToAdd?.saveInBackground()
                                })
                                
                            } else {
                                // Log details of the failure
                                print("Error on query for teams")
                            }
                        }
                    }
                }
                
            } else {
                print("Error on query for EmailToTeam")
            }
            
        })
    }
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) -> Void {
        self.signUpVC.dismissViewControllerAnimated(true, completion: nil)
    }
}