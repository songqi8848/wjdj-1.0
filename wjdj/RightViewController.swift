//
//  RightViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit
import Alamofire
import AlecrimCoreData
import SwiftyJSON
import CoreData
class RightViewController : UIViewController {
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var loginName: UILabel!
    @IBOutlet weak var loginTip: UILabel!
    
    @IBOutlet weak var zhuxiao: UIImageView!

    
    @IBOutlet weak var editpwd: UIButton!
    
    @IBOutlet weak var editpwdtip: UILabel!
    @IBOutlet weak var zhuxiaotip: UILabel!
    
       var userEntitie:CustomerUser?
//    lazy var fetchedResultsController: FetchedResultsController<CustomerUser> = {
//        let frc = dataContext.customerUser.orderByAscending({$0.userId}).toFetchedResultsController()
//        return frc
//        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let app=UIApplication.sharedApplication().delegate as! AppDelegate
        let context=app.managedObjectContext!
        var error:NSError?
        
        var fetchrequest:NSFetchRequest=NSFetchRequest()
        fetchrequest.fetchLimit=1
        fetchrequest.fetchOffset=0
        var entity:NSEntityDescription?=NSEntityDescription.entityForName("CustomerUser", inManagedObjectContext: context)
        fetchrequest.entity=entity
        
        var fetchedObjects:[AnyObject]?=context.executeFetchRequest(fetchrequest, error: &error)
        
         if  fetchedObjects?.count>0
         {
            var userEntitie=fetchedObjects?.first as! CustomerUser
            loginBtn.hidden=true
            loginTip.hidden=true
            loginName.hidden=false
            zhuxiao.hidden=false
            zhuxiaotip.hidden=false
            editpwd.hidden=false
            editpwdtip.hidden=false
            loginName.text=userEntitie.loginNo
         }
        
       var sigtap:UITapGestureRecognizer=UITapGestureRecognizer(target: self, action: "onclick:")
        zhuxiao.addGestureRecognizer(sigtap)
    }
    func onclick(recognizer:UIRotationGestureRecognizer)
    {
        let app=UIApplication.sharedApplication().delegate as! AppDelegate
        let context=app.managedObjectContext!
        var error:NSError?
        
        var fetchrequest:NSFetchRequest=NSFetchRequest()
        fetchrequest.fetchLimit=1
        fetchrequest.fetchOffset=0
        var entity:NSEntityDescription?=NSEntityDescription.entityForName("CustomerUser", inManagedObjectContext: context)
        fetchrequest.entity=entity
        
        var fetchedObjects:[AnyObject]?=context.executeFetchRequest(fetchrequest, error: &error)
        
        for user:CustomerUser in fetchedObjects as! [CustomerUser]
        {
             context.deleteObject(user)
        }
        if context.save(&error)
        {
            
            loginBtn.hidden=false
            loginTip.hidden=false
            loginName.hidden=true
            zhuxiao.hidden=true
            zhuxiaotip.hidden=true
            editpwd.hidden=true
            editpwdtip.hidden=true
            loginName.text=""
            var userInfo = NSUserDefaults()
            userInfo.removeObjectForKey("token")
            
        }
       
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func close(sequen:UIStoryboardSegue)
    {
       closeRight()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       if(segue.identifier == "login"){
        var login:LoginController?
        var bVc:UINavigationController = segue.destinationViewController as! UINavigationController
          login=bVc.viewControllers.first as? LoginController
         login!.delegate = self
        closeRight()
        }
    }
  
}
extension RightViewController:SendMessageDelegate{
    
    func sendWord(message: String) {
        loginBtn.hidden=true
        loginTip.hidden=true
        loginName.hidden=false
        zhuxiao.hidden=false
        zhuxiaotip.hidden=false
        editpwdtip.hidden=false
        editpwd.hidden=false
        loginName.text=message
    }
}
