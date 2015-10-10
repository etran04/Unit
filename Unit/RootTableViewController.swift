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
    
    var taskDescriptions = [String]()
    var teamMembers = [String]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskDescriptions = ["Task 1", "Task 2", "Task 3", "Task 4", "Task 5"]
        
//        let query = PFQuery(className: "User")
//        query.findObjectsInBackgroundWithBlock( {
//            (objects : [PFObject]?, error: NSError?) -> Void in
//            if error == nil{
//                if let objects = objects as? [PFObject]! {
//                    for object in objects{
//                        print(object["username"] as! String)
//                        self.teamMembers.append(object["username"] as! String)
//                    }
//                }
//            }else{
//                //Handle error
//            }
//        })
        teamMembers = ["Juan", "Quan", "Tran", "Wan"]
        tableView.estimatedRowHeight = 50

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
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
        return taskDescriptions.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return teamMembers[section]
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Configure the cell...
        let cell =
        self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
    
        let row = indexPath.row
        cell.textLabel!.font =
        UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cell.textLabel!.text = taskDescriptions[row]
        return cell
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

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
