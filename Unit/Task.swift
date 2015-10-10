//
//  Task.swift
//  Unit
//
//  Created by Eric Tran on 10/10/15.
//  Copyright © 2015 TheDRE. All rights reserved.
//

import Foundation

class Task {
    
    let creator: User!
    var description: String!
    var assigned: Bool!
    var taskTaker: User!
    var currentStatus: Status!
    var currentPriority: Priority!
    var dueDate: NSDate?
    
    /* Constructs a task object */
    init(maker: User, shortDescription: String, priority: Priority) {
        creator = maker
        description = shortDescription
        currentPriority = priority
        
        assigned = false
        currentStatus = Status.Unstarted
    }
    
    /* Assigned the task to a user */
    func assignTo(assignedTo: User) {
        assigned = true
        taskTaker = assignedTo
    }
    
    /* Removes assigned user from the task */
    func unassignFrom() {
        assigned = false
        taskTaker = nil
    }

    /* Sets the status of the task */
    func setStatus(newStatus: Status) {
        currentStatus = newStatus
    }
    
    /* Sets the priority of the task */
    func setPriority(newPriority: Priority) {
        currentPriority = newPriority
    }
    
    /* Set the current date of the task */
    func changeDeadline(newDate: NSDate) {
        dueDate = newDate
    }
    
    /* Change the current description of the task */
    func editDescription(newDescription: String) {
        description = newDescription
    }
    
}
