//
//  User.swift
//  Unit
//
//  Created by Eric Tran on 10/10/15.
//  Copyright © 2015 TheDRE. All rights reserved.
//

import Foundation
import Parse
import Bolts

class User {
    let email : String?
    let password : String?
    let name : String?
    var teams = [Team]()
    var tasks = [Task]()
    var currentTeam : Team?
    
    // Constructs a User object
    init(user_email : String, user_password : String, user_name : String) {
        email = user_email
        password = user_password
        name = user_name
    }
    
    func getTeams() -> [Team] {
        return teams
    }
    
    func setCurrentTeam(team : Team) {
        currentTeam = team
    }
    
    func getCurrentTeam() -> Team {
        return currentTeam!
    }
    
    func addTeam(team : Team) {
        teams.append(team)
    }
    
    func getTasks() -> [Task] {
        return tasks
    }
    
    func addTask(task : Task) {
        tasks.append(task)
    }
}