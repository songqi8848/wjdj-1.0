//
//  LoginController.swift
//  wjdj
//
//  Created by HANBANG on 15/6/2.
//  Copyright (c) 2015年 HANBANG. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData

protocol SendMessageDelegate{
    func sendWord(message : String)
}
class LoginController: UIViewController,UITextFieldDelegate {

    var nameUser:String!
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
     var dataContext=DataContext()!
    
    var delegate : SendMessageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     self.navigationController!.navigationBar.barTintColor=UIColor(red: 0, green: 143/255.0, blue: 215/255.0, alpha: 1)
        var title:UILabel=UILabel(frame: CGRectMake(0, 0, 200, 40))
        title.backgroundColor=UIColor.clearColor()
        title.font=UIFont.systemFontOfSize(18)
        title.textColor=UIColor.whiteColor()
        title.textAlignment=NSTextAlignment.Center
        title.text="登录"
        self.navigationItem.titleView=title
        
        username.delegate=self
        password.delegate=self
       //        Alamofire.request(.POST, Constants().BASEURL+"/mu/login", parameters: parameters as [String : String], encoding: .JSON).responseJSON { (request, response, resulst, error) in
//            "ddd"
//        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(sender: AnyObject) {
//        self.performSegueWithIdentifier("login", sender: self)
        let myStoreBoard=self.storyboard!
        let mianView:MainViewController=myStoreBoard.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
        self.presentViewController(mianView,animated: true, completion: nil)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func  touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        username.resignFirstResponder()
        password.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
         textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func btnlogin(sender: AnyObject) {
        
        if username.text==""||password.text==""
        {
            var alert:UIAlertView=UIAlertView(title: "提示信息", message: "用户名或密码不能为空", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            return
        }
        nameUser=username.text
        let parameters = ["username":username.text,"password":password.text]
        Alamofire.request(.POST,  Constants().BASEURL+"/mu/login", parameters: parameters, encoding: ParameterEncoding.JSON).responseJSON{(request, response, resulst, error) in
            
            println(response?.statusCode)
            if error != nil
            {
                var alert:UIAlertView=UIAlertView(title: "提示信息", message: "登录失败请确认用户名或密码输入是否正确", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
                return
            }
            else
            {
                if((self.delegate) != nil){
                    
                    if let json: AnyObject=resulst
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
                            context.delete(user)
                        }
                        
                        var cumUser=NSEntityDescription.insertNewObjectForEntityForName("CustomerUser", inManagedObjectContext: context) as! CustomerUser
                        
                        cumUser.loginNo=self.nameUser
                        
                        
                        var jsonObj=JSON(json)
                        
                        println(jsonObj)
                        
                        let userId=jsonObj["id"]
                        let token=jsonObj["token"]
                        let dzb=jsonObj["dzb"]
                        
                        if var userIdvalue=userId.string{cumUser.userId=userIdvalue}
                        if var tokenvalue=token.string{
                            cumUser.token=tokenvalue
                          var nsUserData: NSUserData = NSUserData()
                         nsUserData.cacheSetString("token", value: tokenvalue)
                            
                        }
                        if var dzbvalue=dzb.string{cumUser.dzb=dzbvalue}
                       
                       
                        if context.save(&error)
                        {
                            self.delegate?.sendWord(self.nameUser)
                           // self.navigationController?.popViewControllerAnimated(true)
                            self.dismissViewControllerAnimated(true,completion: { () -> Void in })

                        }
                        
                    }

                   
                }
                
//                
//                self.dismissViewControllerAnimated(true, completion: { () -> Void in
//                  
//                                    })
//                
            }
            
            
        }
        
        
        
        
        //self.delegate!.changeLabel(str)
        
        //返回RootView
       // self.dismissModalViewControllerAnimated( true)
       
    }
    
    @IBAction func closeLogin(sequence:UIStoryboardSegue)
    {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    }
//    
//    func Delete()
//    {
//        dataContext.customerUser.delete()
//    }

}
