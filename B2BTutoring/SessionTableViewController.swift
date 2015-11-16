//
//  SessionTableViewController.swift
//  B2BTutoring
//
//  Created by yingjun on 15/10/29.
//  Copyright © 2015年 Team 1. All rights reserved.
//

import UIKit

class SessionTableViewController: UITableViewController {
    
    var sessions = [Session]()
    
    @IBOutlet var tutorSegment: UISegmentedControl!
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch tutorSegment.selectedSegmentIndex
        {
        case 0:
            loadData(true)
        case 1:
            loadData(false)
        default:
            break; 
        }
    }
    
    func do_table_refresh()
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
            return
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData(true)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    func loadData(forTutor: Bool) -> Void {
        if forTutor {
            if let currentUser = User.currentUser() {
                User.objectWithoutDataWithObjectId(currentUser.objectId).fetchInBackgroundWithBlock {
                    (object: PFObject?, error: NSError?) -> Void in
                    if error == nil {
                        if let user = object as? User {
                            self.sessions = user.getOngoingTutorSessions()
                            print(self.sessions.count)
                            self.do_table_refresh()
                        }
                    } else {
                        print("Error retrieving user sessions")
                    }
                }
            } else {
                print("no current user")
            }
        } else {
            self.sessions = [Session]()
            self.tableView.reloadData()
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessions.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SessionTableViewCell", forIndexPath: indexPath) as! SessionTableViewCell
        cell.tutorImageView.image = UIImage(named:"starwar")
        cell.titleLabel.text = sessions[indexPath.row].title
        cell.categoryLabel.text = sessions[indexPath.row].category
        cell.tagLabel.text = sessions[indexPath.row].tags
        cell.locationLabel.text = sessions[indexPath.row].location
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        cell.timeLabel.text = dateFormatter.stringFromDate(sessions[indexPath.row].starts)
        cell.capacityLabel.text = "2/10"
        cell.ratingLabel.text = "☆4.7"
        
        return cell
    }

    @IBAction func exitSessionCreation(segue: UIStoryboardSegue) {
        loadData(true)
        print("Exit session creation.")
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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
