//
//  EditPwdController.swift
//  wjdj
//
//  Created by HANBANG on 15/7/18.
//  Copyright (c) 2015年 HANBANG. All rights reserved.
//

import UIKit
import Alamofire
import AlecrimCoreData
import SwiftyJSON
import CoreData
class EditPwdController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var aginpassword: UITextField!
    
    var token:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.barTintColor=UIColor(red: 0, green: 143/255.0, blue: 215/255.0, alpha: 1)
        var titleLable=UILabel(frame: CGRectMake(0, 0, 200, 40))
        titleLable.backgroundColor=UIColor.clearColor()
        titleLable.font=UIFont.systemFontOfSize(18)
        titleLable.textColor=UIColor.whiteColor()
        titleLable.textAlignment=NSTextAlignment.Center
        titleLable.text="修改密码"
        self.navigationItem.titleView=titleLable
        
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
       
            username.text=userEntitie.loginNo
            token=userEntitie.token
        }

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var save: UIButton!
    
    @IBAction func close(sender: AnyObject) {
       self.dismissViewControllerAnimated(true,completion: { () -> Void in })
        
    }
    @IBAction func btnsave(sender: AnyObject) {
        if (password.text.isEmpty)
        {
            var alert:UIAlertView=UIAlertView(title: "提示信息", message: "请输入密码", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            return

        }
        if (aginpassword.text.isEmpty)
        {
            var alert:UIAlertView=UIAlertView(title: "提示信息", message: "请输入确认密码", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            return
            
        }
        if(aginpassword.text != password.text)
        {
            var alert:UIAlertView=UIAlertView(title: "提示信息", message: "请输入密码输入不一致", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            return
        }
        
        
        let parameters = ["token":token,"pwd":password.text]
        Alamofire.request(.POST,  Constants().BASEURL+"mu/pwd", parameters: parameters, encoding: ParameterEncoding.JSON).responseJSON{(request, response, resulst, error) in
            
            println(response?.statusCode)
            if error != nil
            {
                var alert:UIAlertView=UIAlertView(title: "提示信息", message: "密码修改失败", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
                return
            }
            else
            {
                var alertcancel:UIAlertView!
                alertcancel=UIAlertView(title: "提示信息", message: "密码修改成功", delegate: self, cancelButtonTitle: "确定")
                alertcancel.show()
                 return
            }
            
            
        }
        

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
