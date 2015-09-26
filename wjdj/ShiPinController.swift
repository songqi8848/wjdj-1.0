//
//  ShiPinController.swift
//  wjdj
//
//  Created by HANBANG on 15/7/15.
//  Copyright (c) 2015年 HANBANG. All rights reserved.
//

import UIKit
import Alamofire
import AlecrimCoreData
import SwiftyJSON
import CoreData
class ShiPinController: UIViewController , UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    // default datas
    var fakeTableData:NSMutableArray?
    var fakeImageData:NSMutableArray?
    var page=1;
    var DetailsNew:NewsList?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate=self
        self.tableView.dataSource=self
        fakeTableData = NSMutableArray()
        self.SetTableData(page,type: TABLETYPE.Refresh, Sucess: { (Tabledata) -> Void in
            self.tableView.reloadData()
        })
        
        self.setupRefresh()
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return fakeTableData!.count
    }
    
    func SetTableData(page:Int,type:TABLETYPE,Sucess:(Tabledata:NSMutableArray)->Void)
    {
        self.pleaseWait()
        //"djdt"
        let app=UIApplication.sharedApplication().delegate as! AppDelegate
        let context=app.managedObjectContext!
        var error:NSError?
        var token:String=""
        var fetchrequest:NSFetchRequest=NSFetchRequest()
        fetchrequest.fetchLimit=1
        fetchrequest.fetchOffset=0
        var entity:NSEntityDescription?=NSEntityDescription.entityForName("CustomerUser", inManagedObjectContext: context)
        fetchrequest.entity=entity
        
        var fetchedObjects:[AnyObject]?=context.executeFetchRequest(fetchrequest, error: &error)
        
        if  fetchedObjects?.count>0
        {
            var userEntitie=fetchedObjects?.first as! CustomerUser
            
            token=userEntitie.token
        }

        Alamofire.request(.GET, Constants().QUERYURL+"jtyxx",parameters: ["t":token]).responseJSON { (request, response, string, error) in
            if let stringjson: AnyObject=string
            {
                let json = JSON(stringjson)
                //println(json)
                println(json)
                var result=json["result"]
                
                var topResult=json["topResult"]
                
                if var count=result.array?.count
                {
                    if type==TABLETYPE.Refresh
                    {
                        self.fakeTableData?.removeAllObjects()
                    }
                    for var i:Int=0;i<count;i++
                    {
                        //if !ispiclib { continue}
                       
                    if (result[i]["isVideoLib"].bool!)
                       {
                        
                        var news=NewsList()
                        if var title=result[i]["title"].string{
                            news.newslist_item_title=title
                        }
                        
                        if var id=result[i]["id"].number
                        {
                            news.id=id.stringValue
                        }
                        if let thumb = result[i]["thumb"].string{
                            news.thumb=Constants().RESOURCEURL+thumb
                        }
                        if let published=result[i]["published"].double{
                            
                            
                            var outputFormat = NSDateFormatter()
                            //格式化规则
                            outputFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            //定义时区
                            outputFormat.locale = NSLocale(localeIdentifier: "shanghai")
                            
                            let pubTime = NSDate(timeIntervalSince1970:published/1000)
                            
                            var dateString = outputFormat.stringFromDate(pubTime)
                            
                            news.modified=dateString
                        }
                        if let body = result[i]["body"].string{
                            news.newslist_item_content=Constants().RESOURCEURL+body
                        }
                        
                        self.fakeTableData?.addObject(news)
                        }
                        
                   }
                    
                }
                
                Sucess(Tabledata: self.fakeTableData!)
                self.clearAllNotice()
                
            }
        }
    }
    
    func setupRefresh(){
        
        tableView.addHeaderWithCallback({
            
            self.page=1;
            let delayInSeconds:Int64 =  1000000000  * 2
            var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
            dispatch_after(popTime, dispatch_get_main_queue(), {
                self.SetTableData(1,type: TABLETYPE.Refresh, Sucess: { (Tabledata) -> Void in
                    self.tableView.reloadData()
                    self.tableView.headerEndRefreshing()
                })
                
                
            })
        })
        
        
        tableView.addFooterWithCallback({
            self.page++
            let delayInSeconds:Int64 =  1000000000  * 2
            var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
            dispatch_after(popTime, dispatch_get_main_queue(), {
                self.SetTableData(self.page,type: TABLETYPE.Loade, Sucess: { (Tabledata) -> Void in
                    self.tableView.reloadData()
                    self.tableView.footerEndRefreshing()
                })
                
                
            })
            
        })
    }
    
    func  tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        self.DetailsNew=fakeTableData?.objectAtIndex(indexPath.row) as? NewsList
        return indexPath
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell
        
        if cell == nil { // no value
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell") as UITableViewCell
            cell!.selectionStyle = UITableViewCellSelectionStyle.None
        }
        if fakeTableData?.objectAtIndex(indexPath.row) != nil
        {
            var title:UILabel=cell?.contentView.viewWithTag(1) as! UILabel
            var time:UILabel=cell?.contentView.viewWithTag(2) as!UILabel
            var dic=fakeTableData!.objectAtIndex(indexPath.row)as! NewsList
            var img:UIImageView = cell!.contentView.viewWithTag(3) as!  UIImageView
            
            var data=NSURL(string: dic.thumb)
            
            if var url=data
            {
                
                if dic.thumb.lowercaseString.hasSuffix("jpg")||dic.thumb.lowercaseString.hasSuffix("png")||dic.thumb.lowercaseString.hasSuffix("bmp")||dic.thumb.lowercaseString.hasSuffix("jpeg")
                {
                    img.setImageWithURL(url,cacheScaled: true) { (imageInstance, error) in
                        
                        if error==nil
                        {
                            let transition = CATransition()
                            img.layer.addAnimation(transition, forKey: "fade")
                        }
                        
                    }
                }
                else
                {
                    img.image=nil
                }
                
            }
            
            title.lineBreakMode=NSLineBreakMode.ByWordWrapping
            // = UILineBreakModeWordWrap;
            title.numberOfLines = 0
            
            title.text=dic.newslist_item_title
            
            time.text=dic.modified
        }
        cell?.layer.masksToBounds=true
        cell?.layer.cornerRadius=10;
        //cell?.s
        return cell!
    }
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell
    
    // Configure the cell...
    
    return cell
    }
    */
    
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
    
    @IBAction func closebushu(seque:UIStoryboardSegue)
    {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier=="shipinindex"
        {
            var detalisController:WebViewController?
            var bVc:UINavigationController = segue.destinationViewController as! UINavigationController
            detalisController=bVc.viewControllers.first as? WebViewController
            detalisController!.newsList=DetailsNew
        }
    }

}
