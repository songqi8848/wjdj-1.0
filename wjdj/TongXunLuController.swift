//
//  TongXunLuController.swift
//  wjdj
//
//  Created by HANBANG on 15/5/16.
//  Copyright (c) 2015年 HANBANG. All rights reserved.
//

import UIKit
import Alamofire
import AlecrimCoreData
import SwiftyJSON
import CoreData
class TongXunLuController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    // default datas
    var fakeTableData:NSMutableArray?
    var fakeImageData:NSMutableArray?
    var page=1;
    var DetailsNew:ContactsName?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textflied: UITextField!
    
    @IBAction func query(sender: AnyObject) {
        self.fakeTableData?.removeAllObjects()
        self.SetTableData(page,type: TABLETYPE.Refresh, Sucess: { (Tabledata) -> Void in
            
            self.tableView.reloadData()
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarItem()
        var titleLable=UILabel(frame: CGRectMake(0, 0, 200, 40))
        titleLable.backgroundColor=UIColor.clearColor()
        titleLable.font=UIFont.systemFontOfSize(18)
        titleLable.textColor=UIColor.whiteColor()
        titleLable.textAlignment=NSTextAlignment.Center
        titleLable.text="党员通讯录"
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

        Alamofire.request(.GET, Constants().QUERYURL+"dytxl",parameters: ["t":token,"ps":10,"pn":page,"osw":self.textflied.text]).responseJSON { (request, response, string, error) in
            if let stringjson: AnyObject=string
            {
                let json = JSON(stringjson)
                //println(json)
                println(json)
                var result=json["result"]
                var orgNames=result["orgNames"]
                // println(orgNames)
                // println(result)
                
            if var count=orgNames.array?.count
            {
                if type==TABLETYPE.Refresh
                {
                    self.fakeTableData?.removeAllObjects()
                }
                for var k:Int=0;k<count;k++
                {
                    println(orgNames[k])
                    var coname=ContactsName()
                   if var names=orgNames[k].string
                   {
                    if(!self.textflied.text.isEmpty){
               
                       if(names.lowercaseString.rangeOfString(self.textflied.text)==nil)
                       {
                         continue
                       }
                      }
                       coname.name=names
                       var concus=result[names]
                        if var count=concus.array?.count
                        {
                            for (var j=0;j<count;j++)
                            {
                                var cn=Contacts()
                                if var id=concus[j]["id"].number
                                {
                                   cn.id=id.integerValue
                                }
                                if var title=concus[j]["title"].string
                                {
                                    cn.title=title
                                }
                                if var name=concus[j]["name"].string
                                {
                                    cn.name=name
                                }
                                if var tel=concus[j]["tel"].string
                                {
                                    cn.tel=tel
                                }
                                if var addr=concus[j]["addr"].string
                                {
                                    cn.address=addr
                                }
                                if var email=concus[j]["email"].string
                                {
                                    cn.email=email
                                }
                                coname.ContactList.append(cn)
                            }
                        }
                       self.fakeTableData?.addObject(coname)
                    }
                }
               }
              }
              Sucess(Tabledata: self.fakeTableData!)
              self.clearAllNotice()
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
        self.DetailsNew=fakeTableData?.objectAtIndex(indexPath.row) as? ContactsName
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
            var dic=fakeTableData!.objectAtIndex(indexPath.row)as! ContactsName
            
            
            //img.image=UIImage(data: NSData(contentsOfURL: data!)!)
            //        img.setImageWithURL(data!, cacheScaled: true) { (imageInstance, error) in
            //            println(imageInstance)
            //        }
            
            title.lineBreakMode=NSLineBreakMode.ByWordWrapping
            // = UILineBreakModeWordWrap;
            title.numberOfLines = 0
            
            title.text=dic.name
            
           
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
        if segue.identifier=="tongxunindex"
        {
            var detalisController=segue.destinationViewController as! TongXunDetailController;
            detalisController.DetailsNew=self.DetailsNew
        }
    }

}
