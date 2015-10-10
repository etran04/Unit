//
//  AddTaskViewController.swift
//  Unit
//
//  Created by Ryan Lee on 10/10/15.
//  Copyright © 2015 TheDRE. All rights reserved.
//

import Foundation
import UIKit
import Parse

class AddTaskViewController : UIViewController {
    
    @IBOutlet weak var addTaskButton: UIButton!
    @IBOutlet weak var taskDescription: UITextField!
    @IBOutlet weak var priorityLevel: UISegmentedControl!
    
    @IBAction func buttonPressed(sender: AnyObject) {
        //let user = PFUser.currentUser()
        let teamId : String = "Zqz4CaACw2"
        //let teamId : String = user["currentTeam"] as! String
        let newTask = PFObject(className: "Task")
        //TODO - access current team to get teamID. store locally to use in getObjectInBackgroundWithId
        newTask["teamId"] = teamId
        //newTask["description"] = taskDescription.text
        //newTask["priorityLevel"] = priorityLevel.selectedSegmentIndex
        newTask.saveInBackgroundWithBlock {
            (success : Bool, error : NSError?) -> Void in
            if (success) {
                let query = PFQuery(className:"Team")
                query.getObjectInBackgroundWithId(teamId) {
                    (team: PFObject?, error: NSError?) -> Void in
                    if error == nil && team != nil {
                        team!.addObject(newTask, forKey: "Tasks")
                        team!.saveInBackgroundWithBlock {
                            (success : Bool, error : NSError?) -> Void in
                            if (success) {
                                //TODO - close New Task screen and go back to main task screen
                            }
                            else {
                                print("SUCKER")
                            }
                        }
                    } else {
                        print(error)
                    }
                }
            } else {
                print("YOU SUCK")
            }
        }
    }
}