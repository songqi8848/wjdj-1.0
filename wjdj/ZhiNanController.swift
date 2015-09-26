//
//  ZhiNanController.swift
//  wjdj
//
//  Created by HANBANG on 15/5/16.
//  Copyright (c) 2015年 HANBANG. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ZhiNanController: UITableViewController {

    
    // default datas
    var fakeTableData:NSMutableArray?
    var fakeImageData:NSMutableArray?
    var page=1;
    var DetailsNew:NewsList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarItem()
        var titleLable=UILabel(frame: CGRectMake(0, 0, 200, 40))
        titleLable.backgroundColor=UIColor.clearColor()
        titleLable.font=UIFont.systemFontOfSize(18)
        titleLable.textColor=UIColor.whiteColor()
        titleLable.textAlignment=NSTextAlignment.Center
        titleLable.text="党务指南"
        self.navigationItem.titleView=titleLable
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
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return fakeTableData!.count
    }
    
    func SetTableData(page:Int,type:TABLETYPE,Sucess:(Tabledata:NSMutableArray)->Void)
    {
        
        //"djdt"
        self.pleaseWait()
        Alamofire.request(.GET, Constants().QUERYURL+"dwzn",parameters: ["pn":page,"ps":"10"]).responseJSON { (request, response, string, error) in
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
    
    override func  tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        self.DetailsNew=fakeTableData?.objectAtIndex(indexPath.row) as? NewsList
        return indexPath
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        
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
            
            
            //img.image=UIImage(data: NSData(contentsOfURL: data!)!)
            //        img.setImageWithURL(data!, cacheScaled: true) { (imageInstance, error) in
            //            println(imageInstance)
            //        }
            
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
        if segue.identifier=="zhinanindex"
        {
            var detalisController=segue.destinationViewController as! ZhiNanDetailController;
            detalisController.newsList=DetailsNew
        }
    }
}
