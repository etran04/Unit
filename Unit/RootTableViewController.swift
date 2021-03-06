//
//  RootTableViewController.swift
//  Unit
//
//  Created by Eric Tran on 10/10/15.
//  Copyright © 2015 TheDRE. All rights reserved.
//

import UIKit
import Parse

class RootTableViewController: UITableViewController {
    
    var usersToTaskTitles = [String: [String]]()
    var teamMembers = [String]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        //PFUser.logOut()
        self.tableView.editing = true
        let user = PFUser.currentUser()
        
        teamMembers.append("Unassigned Tasks")
        self.usersToTaskTitles["Unassigned Tasks"] = [String]()
        self.teamMembers.append((PFUser.currentUser()?.username)!)
        self.usersToTaskTitles[(PFUser.currentUser()?.username!)!] = [String]()
        
        user?.fetchInBackgroundWithBlock({(object: PFObject?, error: NSError?) -> Void in
            let teamId = object!.objectForKey("currentTeam") as! String
            
            // Add username labels to teams
            let query = PFQuery(className:"Team")
            let username = object!.objectForKey("username") as! String
            
            query.includeKey("Users")
            query.getObjectInBackgroundWithId(teamId) {
                (team: PFObject?, error: NSError?) -> Void in
                print(team)
                if error == nil && team != nil {
                    for user in team?["Users"] as! [PFUser] {
                        print(user["username"] as! String)
                        if user["username"] as! String != username {
                            self.teamMembers.append(user["username"] as! String)
                            self.usersToTaskTitles[user.username!] = [String]()
                        }
                    }
                }
                
                // Go through every user and initialize a task title list for them
                let usersQuery = PFUser.query()
                usersQuery!.findObjectsInBackgroundWithBlock {
                    (results: [PFObject]?, error: NSError?) -> Void in
                    for user in results as! [PFUser] {
                        self.usersToTaskTitles[user.username!] = [String]()
                    }
                    
                    // Sort all tasks to each user
                    let tasksQuery = PFQuery(className: "Task")
                    tasksQuery.whereKey("teamId", equalTo: teamId)
                    tasksQuery.findObjectsInBackgroundWithBlock() {
                        (tasks: [PFObject]?, error: NSError?) -> Void in
                        if error == nil && tasks != nil {
                            for task in tasks! {
                                // it's assigned to someone
                                let personAssigned = task["assignedTo"] as! String
                                if (personAssigned != "") {
                                    (self.usersToTaskTitles[personAssigned])?.append(task["title"] as! (String))
                                    print(self.usersToTaskTitles)
                                } else {
                                    //unassigned task
                                    (self.usersToTaskTitles["Unassigned Tasks"])?.append(task["title"] as! (String))
                                }
                            }
                        }
                        self.tableView.reloadData()
                    }
                }
            }
        })
        
        //teamMembers = ["Juan", "Quan", "Tran", "Wan"]
        tableView.estimatedRowHeight = 50
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        self.tableView.reloadData()
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.usersToTaskTitles = [String: [String]]()
        self.teamMembers = [String]()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return teamMembers.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usersToTaskTitles[teamMembers[section]]!.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return teamMembers[section]
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        
        switch section % 5 {
        case 0:
            label.backgroundColor = UIColor.greenColor()
        case 1:
            label.backgroundColor = UIColor.blueColor()
        case 2:
            label.backgroundColor = UIColor.yellowColor()
        case 3:
            label.backgroundColor = UIColor.purpleColor()
        default:
            label.backgroundColor = UIColor.redColor()
        }

        label.backgroundColor = label.backgroundColor?.colorWithAlphaComponent(0.1)
        label.textColor = UIColor.darkGrayColor()
        label.text = "  " + teamMembers[section]
        label.font = UIFont.boldSystemFontOfSize(15)
        
        return label
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Configure the cell...
        let cell =
            self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
    
        let row = indexPath.row
        
        cell.textLabel!.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        print(indexPath.section)
        cell.textLabel!.text = usersToTaskTitles[teamMembers[indexPath.section]]?[row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        //assign task to that person
//        let itemToMove:String = taskDescriptions[sourceIndexPath.row]
//        taskDescriptions.removeAtIndex(sourceIndexPath.row)
//        taskDescriptions.insert(itemToMove, atIndex: destinationIndexPath.row)
    }

    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.None
    }
    
//    // Override to support conditional editing of the table view.
//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        let cell =
//        self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
//        
//        let row = indexPath.row
//        cell.textLabel!.font =
//            UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
//        cell.textLabel!.text = taskDescriptions[row]
//        return cell
//    }


    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("about to segue")
    }

}
