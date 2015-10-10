//
//  Task.swift
//  Unit
//
//  Created by Eric Tran on 10/10/15.
//  Copyright © 2015 TheDRE. All rights reserved.
//

import Foundation

class Task {
    let creator: User
    var description: String!
    
    init(maker: User, shortDescription: String) {
        creator = maker
        description = shortDescription
    }
    
    func assignTo() {
        
    }
    
    func unassignFrom() {
        
    }
    
    func setStatus() {
        
    }
    
    func setPriority() {
        
    }
    
    func changeDeadline() {
        
    }
    
    func editDescription(newDescription: String) {
        description = newDescription
    }
    
}
