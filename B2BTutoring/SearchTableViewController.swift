//
//  SearchTableViewController.swift
//  B2BTutoring
//
//  Created by Claire Zhang on 10/28/15.
//  Copyright © 2015 Team 1. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRectMake(0, 0, 340, 20))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // embed search bar inside navbar
        searchBar.placeholder = "Search"
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        
        let nibName = UINib(nibName: "sessionCell", bundle:nil)
        self.tableView.registerNib(nibName, forCellReuseIdentifier: "cell")
        
        let cellPrototype = tableView.dequeueReusableCellWithIdentifier("cell")
        self.tableView.rowHeight = (cellPrototype?.bounds.height)!
        
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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! SessionTableViewCell
        cell.tutorImageView.image = UIImage(named:"starwar")
        cell.titleLabel.text = "Introductory Jazz Guitar"
        cell.categoryLabel.text = "Music"
        cell.tagLabel.text = "#guitar #jazz"
        cell.locationLabel.text = "0.5m"
        cell.timeLabel.text = "June 12, 3pm"
        cell.capacityLabel.text = "2/10"
        cell.ratingLabel.text = "☆4.7"
        
        return cell
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
