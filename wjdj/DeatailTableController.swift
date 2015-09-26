//
//  DeatailTableController.swift
//  wjdj
//
//  Created by HANBANG on 15/7/15.
//  Copyright (c) 2015年 HANBANG. All rights reserved.
//

import UIKit

class DeatailTableController: UITableViewController {

    var Strings=["Uncomment the following line to preserve selection betweenpresentationsUncomment the following line to preserve selection betweenpresentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection betweenpresentationsUncomment the following line to preserve selection betweenpresentationsUncomment the following line to preserve selection betweenpresentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationUncomment the following line to preserve selection betweenpresentationsUncomment the following line to preserve selection betweenpresentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentationsUncomment the following line to preserve selection between presentations"]
    override func viewDidLoad() {
        super.viewDidLoad()
       
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
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return Strings.count

    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return Strings.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
           var textview=cell.contentView.viewWithTag(1) as! UITextView
           textview.text=Strings[indexPath.row]
       
        ///NSUTF8StringEncoding
        var encode:NSStringEncoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue))

      
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
