//
//  Team.swift
//  Unit
//
//  Created by Ryan Lee on 10/10/15.
//  Copyright © 2015 TheDRE. All rights reserved.
//

import Foundation
import Parse
import Bolts

class Team {
    var users = [User]()
    var tasks = [Task]()
    let name : String?
    
    init(team_name : String) {
        name = team_name
    }
    
    func getUsers() -> [User] {
        return users
    }
    
    func getTasks() -> [Task] {
        return tasks
    }
    
    func getName() -> String {
        return name!
    }
}
