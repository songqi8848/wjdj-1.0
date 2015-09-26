//
//  LeftViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit
import Alamofire
import AlecrimCoreData
import SwiftyJSON
import CoreData
class LeftViewController : UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    enum Menu: Int {
        case DongTai = 0
        case ShuDi
        case BuShu
        case DaiTouRen
        case JiangTan
        case TongXinYuan
        case ZhiNan
        case ZhuanTi
        case HuDong
        case TongXunLu
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var images = ["btn_1_1", "btn_2_1", "btn_5_1", "btn_4_1","btn_3_1","btn_10_1","btn_6_1","btn_7_1","btn_8_1","btn_9_1"]
    var imagesCheck=["btn_1_2", "btn_2_2", "btn_5_2", "btn_4_2","btn_3_2","btn_10_2","btn_6_2","btn_7_2","btn_8_2","btn_9_2"]
    
    var mainViewController: UIViewController!
    var dongTaiController: UIViewController!
    var shuDiController: UIViewController!
    var daiTouRenController: UIViewController!
    var zhuanTiController: UIViewController!
    var zhiNanController: UIViewController!
    var huDongController:UIViewController!
    var tongXunLuController:UIViewController!
    var buShuController:UIViewController!
     var jiangTanController:UIViewController!
    var jpcontroller:UIViewController!
    var xinganxianController:UIViewController!
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        self.tableView.backgroundColor=UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        
//        var controller1:UIViewController=UIViewController()
//        controller1.title="测试"
//        var controller2:UIViewController=UIViewController()
//        controller2.title="测试2"
//
//        self.jpcontroller=JPTabViewController(controllers: [controller1,controller2])

//        
//        let huDongController = storyboard.instantiateViewControllerWithIdentifier("HuDong") as! HuDongController
//        self.huDongController = UINavigationController(rootViewController: huDongController)
        
        let tongXunLuController = storyboard.instantiateViewControllerWithIdentifier("TongXunLu") as! TongXunLuController
        self.tongXunLuController = UINavigationController(rootViewController: tongXunLuController)
        
        let zhiNanController = storyboard.instantiateViewControllerWithIdentifier("ZhiNann") as! ZhiNanController
        self.zhiNanController = UINavigationController(rootViewController: zhiNanController)

        let buShuController = storyboard.instantiateViewControllerWithIdentifier("BuShu") as! BuShuController
        self.buShuController = UINavigationController(rootViewController: buShuController)
        
        let jiangTanController = storyboard.instantiateViewControllerWithIdentifier("JiangTan") as! JiangTanController
        self.jiangTanController = UINavigationController(rootViewController: jiangTanController)
        
        let xinganxianController=storyboard.instantiateViewControllerWithIdentifier("xinganxian") as! XinGanXianController
        self.xinganxianController = UINavigationController(rootViewController: xinganxianController)
        
    }
    
 
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return images.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        var btnIamge=UIButton(frame: CGRectMake(5, 5, 150,40))
        var image=UIImage(named: images[indexPath.row])
        var imageCheck=UIImage(named: imagesCheck[indexPath.row])
        btnIamge.setImage(image, forState: UIControlState.Normal)
        btnIamge.setImage(imageCheck, forState: UIControlState.Highlighted)
        btnIamge.tag=indexPath.row
        println(btnIamge.tag)
        btnIamge.addTarget(self, action: "onclickTo:", forControlEvents: UIControlEvents.TouchUpInside)
        
        cell.addSubview(btnIamge)
        cell.backgroundColor=UIColor(red: 224/255.0, green: 224/255.0, blue: 224/255.0 , alpha: 1)
        cell.backgroundView=nil
        
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func onclickTo(sender:UIButton!)
    {
        let app=UIApplication.sharedApplication().delegate as! AppDelegate
        let context=app.managedObjectContext!
        var error:NSError?
        var token:String?
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
        

        
        println(sender.tag)
               if let menu = Menu(rawValue: sender.tag) {
            println("menu:"+String(menu.rawValue))

            switch menu {
            case .DongTai:
                 setData("djdt",tilte: "党建动态")
              
                self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
                self.mainViewController.viewWillAppear(true)
            case .ShuDi:
                 setData("xw",tilte: "新闻速递")
                
                self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
                   self.mainViewController.viewWillAppear(true)
                break
            case .BuShu:
                self.slideMenuController()?.changeMainViewController(self.buShuController, close: true)
                break
            case .DaiTouRen:
                setData("dtr",tilte: "红领带头人")
              
                self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
                  self.mainViewController.viewWillAppear(true)
                break
            case .TongXinYuan:
                setData("hltxy",tilte: "红领同心圆")
                self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
                 self.mainViewController.viewWillAppear(true)
                break
            case .JiangTan:
    
                if (token==nil)
                {
                    self.closeLeft()
                    self.openRight()
                    var alert:UIAlertView=UIAlertView(title: "提示信息", message: "登录之后才能查看资料", delegate: nil, cancelButtonTitle: "确定")
                    alert.show()
                    return
                    
                }
                
                self.slideMenuController()?.changeMainViewController(self.jiangTanController, close: true)
                break
            case .ZhuanTi:
                setData("djzt",tilte: "党建专题")
                self.mainViewController.viewWillAppear(true)
                self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
                break
            case .HuDong:
                self.slideMenuController()?.changeMainViewController(self.xinganxianController, close: true)
                break
            case .ZhiNan:
                self.slideMenuController()?.changeMainViewController(self.zhiNanController, close: true)
                break
            case .TongXunLu:
                if (token==nil)
                {
                    self.closeLeft()
                    self.openRight()
                    var alert:UIAlertView=UIAlertView(title: "提示信息", message: "登录之后才能查看资料", delegate: nil, cancelButtonTitle: "确定")
                    alert.show()
                    return
                    
                }
                self.slideMenuController()?.changeMainViewController(self.tongXunLuController, close: true)
                break
            default:
                break
            }
        }

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    @IBAction func BackcloseLeft(sequence:UIStoryboardSegue) {
         closeLeft()
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        closeLeft()
    }
    
    func setData(parmas:String,tilte:String)
    {
        var nsUserData: NSUserData = NSUserData()
        nsUserData.cacheSetString("pamas", value:parmas)
        nsUserData.cacheSetString("tilte", value:tilte)
    }
}

