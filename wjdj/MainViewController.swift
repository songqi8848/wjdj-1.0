//
//  ViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit
import Alamofire
import SwiftyJSON

public enum TABLETYPE
{
   case Refresh
   case Loade
}
class MainViewController:UIViewController, UITableViewDataSource,UITableViewDelegate,CirCleViewDelegate {
    

 
//  @IBOutlet weak var scrollView: UIScrollView!
    var circleView: CirCleView!
    @IBOutlet weak var tableView: UITableView!
    var imageArray: [UIImage!]=[];
    var  titleAarry:[String!]=[]
    @IBOutlet weak var imgTitle: UILabel!
    
    var oldSize:CGRect?;
    var oldTableView:UITableView?
    
    var pamas:String!
    var tieltcache:String!
    var titleLable:UILabel!
    var timer: NSTimer!
    // default datas
    var fakeTableData:NSMutableArray?
    var fakeImageData:NSMutableArray?
    var DetailsNew:NewsList?
    var currentPage=0
    var totol=0
    var titles:[String]=[]
    var page=1;
    var userdata:NSUserData=NSUserData();
    func setupRefresh(){
        
        tableView.addHeaderWithCallback({
          
                self.page=1;
                let delayInSeconds:Int64 =  1000000000  * 2
                var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
                dispatch_after(popTime, dispatch_get_main_queue(), {
                    self.SetTableData(1,type: TABLETYPE.Refresh, Sucess: { (Tabledata, ImageData) -> Void in
                        self.tableView.reloadData()
                        self.setImgeData(ImageData)
                       
                       self.tableView.headerEndRefreshing()
                    })


            })
            
        })
        
        
         tableView.addFooterWithCallback({
                self.page++
                let delayInSeconds:Int64 =  1000000000  * 2
                var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
                dispatch_after(popTime, dispatch_get_main_queue(), {
                    self.SetTableData(self.page,type: TABLETYPE.Loade, Sucess: { (Tabledata, ImageData) -> Void in
                        self.tableView.reloadData()
                        self.setImgeData(ImageData)
                        self.tableView.footerEndRefreshing()
                    })
           
                
            })

        })
    }
    

    override func viewWillAppear(animated: Bool) {
        
        weak var weakSelf = self as MainViewController
        
        pamas=userdata.cacheGetString("pamas") ?? "djdt"
        tieltcache=userdata.cacheGetString("tilte") ?? "党建动态"
       // scrollView.frame=CGRectMake(0, 0, view.frame.width, 156)
       // (view.frame.width, 156)
        println("pamas:\(pamas),title:\(tieltcache)")

        tableView.dataSource=self
        tableView.delegate=self
        
        
        titleLable=UILabel(frame: CGRectMake(0, 0, 200, 40))
        titleLable.backgroundColor=UIColor.clearColor()
        titleLable.font=UIFont.systemFontOfSize(18)
        titleLable.textColor=UIColor.whiteColor()
        titleLable.textAlignment=NSTextAlignment.Center
        titleLable.text=tieltcache
        self.navigationItem.titleView=titleLable
        
        fakeTableData = NSMutableArray()
        fakeImageData = NSMutableArray()
        page=1
        
        self.SetTableData(page,type: TABLETYPE.Refresh, Sucess: { (Tabledata, ImageData) -> Void in
            self.tableView.reloadData()
            self.setImgeData(ImageData)
        
        })
        
        //tableView.tableHeaderView
        
        //        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "TableViewCellIdentifier")
             //self.scrollsetupRefresh()
    }

  

    
   override func viewDidLoad() {
        super.viewDidLoad()

    self.automaticallyAdjustsScrollViewInsets = false
     imageArray = [UIImage(named: "fa-cog.png")]
     titleAarry=["qw"]
    self.circleView = CirCleView(frame: CGRectMake(0, 64, self.view.frame.size.width, 156), imageArray: imageArray,titleArray:titleAarry)
    circleView.backgroundColor = UIColor.orangeColor()
    circleView.delegate = self
    self.view.addSubview(circleView)

    
        self.setNavigationBarItem()
        setData("djdt",tilte: "党建动态")
        self.setupRefresh()
    
    }
    
    func SetTableData(page:Int,type:TABLETYPE,Sucess:(Tabledata:NSMutableArray,ImageData:NSMutableArray)->Void)
    {
        
    //"djdt"
       self.pleaseWait()
        Alamofire.request(.GET, Constants().QUERYURL+pamas!,parameters: ["pn":page,"ps":"10"]).responseJSON { (request, response, string, error) in
            if let stringjson: AnyObject=string
            {
                
                let json = JSON(stringjson)
                //println(json)
                 println(json)
                var result=json["result"]
       
                var topResult=json["topResult"]
            
                if var count=topResult.array?.count
                {
                    self.fakeImageData?.removeAllObjects()
                    for var i:Int=0;i<count;i++
                    {
                        //if !ispiclib { continue}

                        if let thumb = topResult[i]["thumb"].string{
                            var image=ImageList()
                            if var title=topResult[i]["title"].string{
                                image.newslist_item_title=title
                            }
                            
                            if var id=topResult[i]["id"].number
                            {
                                image.id=id.stringValue
                            }
                            if var body=topResult[i]["body"].string
                            {
                                image.newslist_item_content=Constants().RESOURCEURL+body
                            }
                            if var modified=topResult[i]["modified"].double
                            {
                                var outputFormat = NSDateFormatter()
                                //格式化规则
                                outputFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                //定义时区
                                outputFormat.locale = NSLocale(localeIdentifier: "shanghai")
                                
                                let pubTime = NSDate(timeIntervalSince1970:modified/1000)
                                
                                var dateString = outputFormat.stringFromDate(pubTime)
                                
                            
                                image.modified=dateString
                            }
                            image.newslist_item_img_path=Constants().RESOURCEURL+thumb
                            self.fakeImageData?.addObject(image)

                        }
                        
                        
                    }
                }
                
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
                 Sucess(Tabledata: self.fakeTableData!, ImageData: self.fakeImageData!)
                self.clearAllNotice()

            }
        }
    }
    
    
    func setImgeData(data:NSMutableArray?)
    {
        if var listdata=data
        {
            var count=listdata.count
            print(count)
            var indexsum=0
            var width:CGFloat = circleView.frame.width//oldSize!.width
            var height:CGFloat = circleView.frame.height
             self.circleView.imageArray=[]
            self.circleView.titleArray=[]
            for var i:Int = 0; i < count; ++i{
              
                var imag=listdata.objectAtIndex(i) as! ImageList
                var queue=NSOperationQueue()
      
                var data=NSURL(string: imag.newslist_item_img_path)
                println( imag.newslist_item_img_path)
                if var path=data?.path{
                 indexsum++
                var imageView=UIImageView()
                var x = (CGFloat(i+1) - 1) * width
                imageView.frame = CGRectMake(x, 0, width, height)
                    imageView.setImageWithURL(data!, cacheScaled: true) { (imageInstance, error) in
                        println(imageInstance)
                      self.circleView.titleArray.append(imag.newslist_item_title)
                      self.circleView.imageArray.append(imageView.image)
                    
                      //self.setImageTitle(0)
                    }
      
                
                }
            }
            self.totol=indexsum;
        
        }
    
    }

    
    func clickCurrentImage(currentIndxe: Int) {
        var   imageList=fakeImageData?.objectAtIndex(currentIndxe) as? ImageList
        if var item=imageList
        {
             DetailsNew=NewsList()
             DetailsNew?.id=item.id
             DetailsNew?.modified=item.modified
             DetailsNew?.newslist_item_content=item.newslist_item_content
             DetailsNew?.newslist_item_title=item.newslist_item_title
             DetailsNew?.thumb=item.newslist_item_img_path
            
        }
        println(DetailsNew)
         self.performSegueWithIdentifier("imgidentifler", sender: self)
        print(currentIndxe);
    }

//    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
//        if  identifier=="imgidentifler"//你自己的判断条件
//        { return true } else {
//            return false
//        }
//        
//    }
    
    func setImageTitle(index:Int)
    {
        if fakeImageData?.count>0
        {
            println("fakeImageData?.count:\(fakeImageData?.count),index:\(index)")
            var currIndex=index
            if fakeImageData?.count<=currIndex
            {
               currentPage=0
               currIndex=0;
            }
              var imag=fakeImageData?.objectAtIndex(currIndex) as! ImageList
              //imgTitle.text=imag.newslist_item_title

        }

    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath)->NSIndexPath? {
        self.DetailsNew=fakeTableData?.objectAtIndex(indexPath.row) as? NewsList
        return indexPath
        
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return fakeTableData!.count
    }
    
    //    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
   //        self.navigationController?.pushViewController(Example1ViewController(), animated: true)
   //    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        

        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell
        
        if cell == nil { // no value
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell") as UITableViewCell
            cell!.selectionStyle = UITableViewCellSelectionStyle.None
        }
        if fakeTableData?.objectAtIndex(indexPath.row) != nil
        {
        var img:UIImageView = cell!.contentView.viewWithTag(3) as!  UIImageView
        var title:UILabel=cell?.contentView.viewWithTag(1) as! UILabel
        var time:UILabel=cell?.contentView.viewWithTag(2) as!UILabel
        var dic=fakeTableData!.objectAtIndex(indexPath.row)as! NewsList
        
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier=="detail" || segue.identifier=="imgidentifler"
        {
            var detalisController=segue.destinationViewController as! DetailsController;
            detalisController.newsList=DetailsNew
        }
        
        
    }
    @IBAction func closeMain(sequen:UIStoryboardSegue)
    {
        
    }
    func setData(parmas:String,tilte:String)
    {
        var nsUserData: NSUserData = NSUserData()
        nsUserData.cacheSetString("pamas", value:parmas)
        nsUserData.cacheSetString("tilte", value:tilte)
    }
}


