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
    @IBOutlet weak var cancelTaskButton: UIButton!
    @IBOutlet weak var taskDescription: UITextField!
    @IBOutlet weak var priorityLevel: UISegmentedControl!
    
    @IBAction func buttonPressed(sender: AnyObject) {
        let newTask = PFObject(className: "Task")
        newTask["teamId"] = "YEET"
        newTask["name"] = "BRUH"
        newTask.saveInBackgroundWithBlock {
            (success : Bool, error : NSError?) -> Void in
            if (success) {
                let query = PFQuery(className:"Team")
                query.getObjectInBackgroundWithId("Zqz4CaACw2") {
                    (team: PFObject?, error: NSError?) -> Void in
                    if error == nil && team != nil {
                        team!.addObject(newTask, forKey: "Tasks")
                        team!.saveInBackgroundWithBlock {
                            (success : Bool, error : NSError?) -> Void in
                            if (success) {
                                
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