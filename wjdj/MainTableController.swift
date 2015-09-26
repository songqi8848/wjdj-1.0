//
//  MainTableController.swift
//  wjdj
//
//  Created by HANBANG on 15/5/30.
//  Copyright (c) 2015年 HANBANG. All rights reserved.
//

import UIKit

class MainTableController: UITableViewController {

    var scorollview:UIScrollView!
    var timer:NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarItem()

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
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 3
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //let fixedHeight:CGFloat = 60.0
        var cellHeight:CGFloat = 50;
        if indexPath.row==0
        {
        var attributes:NSDictionary = [NSFontAttributeName:UIFont.systemFontOfSize(13)]
           
        
                return 300;

      

//        var boundingRect:CGRect = application.desc!.boundingRectWithSize(CGSizeMake(226, CGFloat.max), options: .UsesLineFragmentOrigin, attributes: attributes as [NSObject : AnyObject], context: nil)
            
//        if cellHeight <= fixedHeight {
//            cellHeight = fixedHeight;
//        }
           
        NSLog("cell height \(cellHeight)")
            NSLog("cell height \(indexPath.row)")

          
        }
        return cellHeight;

    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.row==0)
        {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
             self.scorollview = cell.contentView.viewWithTag(1) as! UIScrollView;
            var width=self.scorollview.frame.width;
            var height=self.scorollview.frame.height;
            
            for var i:CGFloat=1;i<6; i++ {
                
                var imageName:String = "img_0\(i)"
                var image: UIImageView=UIImageView()
                image.image=UIImage(named: imageName)
                   var x=(i-1) * width
                image.frame = CGRectMake(x,0, width, height)
                self.scorollview.addSubview(image)
                self.scorollview.pagingEnabled = true
                self.scorollview.showsHorizontalScrollIndicator=false
                self.scorollview.contentSize = CGSizeMake(5 * width, 0)
                
            }
           
            return cell
        }
      else
        {

         let cell = tableView.dequeueReusableCellWithIdentifier("data", forIndexPath: indexPath) as! UITableViewCell
            return cell
            
        }
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
