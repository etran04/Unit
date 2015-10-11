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
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var addTaskButton: UIButton!
    @IBOutlet weak var taskDescription: UITextField!
    @IBOutlet weak var priorityLevel: UISegmentedControl!
    
    override func viewDidLoad() {
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func addTaskButtonPressed(sender: AnyObject) {
        let user = PFUser.currentUser()
        
        user?.fetchInBackgroundWithBlock({(object: PFObject?, error: NSError?) -> Void in
            let teamId = object!.objectForKey("currentTeam") as! String
            
            let newTask = PFObject(className: "Task")
            //TODO - access current team to get teamID. store locally to use in getObjectInBackgroundWithId
            newTask["creator"] = PFUser.currentUser()?.username
            newTask["title"] = self.titleField.text
            newTask["teamId"] = teamId
            newTask["assignedTo"] = ""
            newTask["description"] = self.taskDescription.text
            newTask["priorityLevel"] = self.priorityLevel.selectedSegmentIndex
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
 
        })

    }
}