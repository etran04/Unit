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
    
    
    init(maker: User, shortDescription: String, priority: Priority) {
        creator = maker
        description = shortDescription
        currentPriority = priority
        
        assigned = false
        currentStatus = Status.Unstarted
    }
    
    func assignTo(assignedTo: User) {
        assigned = true
        taskTaker = assignedTo
    }
    
    func unassignFrom() {
        assigned = false
        taskTaker = nil
    }
    
    func setStatus(newStatus: Status) {
        currentStatus = newStatus
    }
    
    func setPriority(newPriority: Priority) {
        currentPriority = newPriority
    }
    
    func changeDeadline(newDate: NSDate) {
        dueDate = newDate
    }
    
    func editDescription(newDescription: String) {
        description = newDescription
    }
    
}
