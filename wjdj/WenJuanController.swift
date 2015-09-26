//
//  WenJuanController.swift
//  wjdj
//
//  Created by HANBANG on 15/7/17.
//  Copyright (c) 2015年 HANBANG. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class WenJuanController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    // default datas
    var fakeTableData:NSMutableArray?
    var fakeImageData:NSMutableArray?
    var page=1;
    var DetailsNew:Survey?
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
        var nsUserData: NSUserData = NSUserData()
        var token=nsUserData.cacheGetString("token") ?? ""
        Alamofire.request(.GET, Constants().QUERYURL+"wjdc",parameters: ["pn":page,"ps":"10"]).responseJSON { (request, response, string, error) in
            if let stringjson: AnyObject=string
            {
                let json = JSON(stringjson)
                //println(json)
                println(json)
                var result=json["result"]
                
                var topResult=json["questionnaires"]
                
                if var count=result.array?.count
                {
                    if type==TABLETYPE.Refresh
                    {
                        self.fakeTableData?.removeAllObjects()
                    }
                    for var i:Int=0;i<count;i++
                    {
        
                            var news=Survey()
                            if var title=result[i]["title"].string{
                                news.title=title
                            }
                            
                            if var id=result[i]["id"].number
                            {
                                news.id=id.stringValue
                            }
                           
                           if var queststring=result[i]["questions"].string
                           {
                               var questions=JSON(queststring)
                            if var count=questions.array?.count
                            {
                                for(var k:Int=0;k<count;k++)
                                {
                                   
                                    if var optionstring=questions[k]["questions"].string
                                    {
                                         var options=JSON(optionstring)
                                        if var count=options.array?.count
                                        {
                                            for(var j:Int=0;j<count;j++)
                                            {
                                                var question:Question=Question()
                                                if var id=options[i]["id"].number
                                                {
                                                    question.id=id.stringValue
                                                }
                                                if var title=options[i]["title"].string{
                                                    question.title=title
                                                }
                                                
                                                news.Questionlist.append(question)

                                            }
                                            
                                        }
                                        
                                    }
                                    
                                }
                            }
                            
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
    
    func  tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        self.DetailsNew=fakeTableData?.objectAtIndex(indexPath.row) as? Survey
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
            var dic=fakeTableData!.objectAtIndex(indexPath.row)as! Survey
            
            title.lineBreakMode=NSLineBreakMode.ByWordWrapping
            // = UILineBreakModeWordWrap;
            title.numberOfLines = 0
            
            title.text=dic.title
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
        if segue.identifier=="wenjuanindex"
        {
            var detalisController:WenJuanDetailController?
            var bVc:UINavigationController = segue.destinationViewController as! UINavigationController
            detalisController=bVc.viewControllers.first as? WenJuanDetailController
            detalisController!.DetailsNew=DetailsNew
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
