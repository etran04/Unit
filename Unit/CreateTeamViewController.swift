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
        newTeam.saveInBackgroundWithBlock({(success: Bool, error: NSError?) -> Void in
            // Save team to current user
            PFUser.currentUser()!.addObject(newTeam, forKey: "TeamIds")
            PFUser.currentUser()!["currentTeam"] = newTeam.objectId
            PFUser.currentUser()!.saveInBackgroundWithBlock({(success: Bool, error: NSError?) -> Void in
                
                print(PFUser.currentUser())
                newTeam.addObject(PFUser.currentUser()!, forKey: "Users")
                newTeam.saveInBackgroundWithBlock({(success: Bool, error: NSError?) -> Void in
                    for email in emailsArray {
                        let newEmailToTeam = PFObject(className:"EmailToTeam")
                        newEmailToTeam["Email"] = email
                        newEmailToTeam["TeamName"] = teamName
                        newEmailToTeam.saveInBackground()
                    }
                    
//                    self.performSegueWithIdentifier("goToRootTableVC", sender: self)
                })
            })
        })
        
    }
}