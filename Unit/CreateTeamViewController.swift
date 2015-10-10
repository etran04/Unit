//
//  CreateTeamViewController.swift
//  Unit
//
//  Created by Eric Tran on 10/10/15.
//  Copyright © 2015 TheDRE. All rights reserved.
//

import UIKit
import Parse
import Foundation

class CreateTeamViewController: UIViewController {
    
    @IBOutlet weak var teamNameField: UITextField!
    @IBOutlet weak var emailListField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func createTeamButtonPressed(sender: AnyObject) {
        let teamName = teamNameField.text
        let uneditedText = emailListField.text
        let emailsArray = uneditedText!.componentsSeparatedByString(",")
        
        // Create the team and save into Parse database
        let newTeam = PFObject(className:"Team")
        newTeam["name"] = teamName
        newTeam.saveInBackground()
        
        for email in emailsArray {
            let newEmailToTeam = PFObject(className:"EmailToTeam")
            newEmailToTeam["Email"] = email
            newEmailToTeam["TeamName"] = teamName
            newEmailToTeam.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // Get a list of all teams with the
                    let teams = PFQuery(className:"Team")
                    teams.whereKey("name", equalTo:teamName!)
                    teams.getFirstObjectInBackgroundWithBlock {
                        (teamToAdd: PFObject?, error: NSError?) -> Void in
                        if error == nil {
                            // For each team, add it to the user's list of teams
                            let user = PFUser()
                            user.username = "temp"
                            user.password = "temp"
                            user.email = email
                            user.addObject(teamToAdd!, forKey: "TeamIds")
                        } else {
                            // Log details of the failure
                            print("Error on query for teams")
                        }
                    }
                } else {
                    // There was a problem, check error.description
                }
            }
        }
        
    }
}