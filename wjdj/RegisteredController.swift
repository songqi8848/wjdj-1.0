//
//  RegisteredController.swift
//  wjdj
//
//  Created by HANBANG on 15/6/17.
//  Copyright (c) 2015年 HANBANG. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegisteredController: UIViewController,UITextFieldDelegate,UIAlertViewDelegate {

    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var anginpassword: UITextField!
    @IBOutlet weak var address: UITextField!
        override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController!.navigationBar.barTintColor=UIColor(red: 0, green: 143/255.0, blue: 215/255.0, alpha: 1)
        var title:UILabel=UILabel(frame: CGRectMake(0, 0, 200, 40))
        title.backgroundColor=UIColor.clearColor()
        title.font=UIFont.systemFontOfSize(18)
        title.textColor=UIColor.whiteColor()
        title.textAlignment=NSTextAlignment.Center
        title.text="注册"
        self.navigationItem.titleView=title
        
        email.delegate=self
        password.delegate=self
        anginpassword.delegate=self
        address.delegate=self
     
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        email.resignFirstResponder()
        password.resignFirstResponder()
        anginpassword.resignFirstResponder()
        address.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func Registere(sender: AnyObject) {
        if email.text==""
        {
            var alert:UIAlertView=UIAlertView(title: "提示信息", message: "email不能为空", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            email.becomeFirstResponder()
            return
        }
        if password.text==""
        {
            var alert:UIAlertView=UIAlertView(title: "提示信息", message: "密码不能为空", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            password.becomeFirstResponder()
            return
        }
        else if count(password.text)<6 || count(password.text)>16
        {
            var alert:UIAlertView=UIAlertView(title: "提示信息", message: "密码需是6至16位字符", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            password.becomeFirstResponder()
            return

        }
       if anginpassword.text==""
        {
            var alert:UIAlertView=UIAlertView(title: "提示信息", message: "确认密码不能为空", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            anginpassword.becomeFirstResponder()
            return
        }
        else if count(anginpassword.text)<6 || count(anginpassword.text)>16
        {
            var alert:UIAlertView=UIAlertView(title: "提示信息", message: "密码需是6至16位字符", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            password.becomeFirstResponder()
            return
            
        }
        if address.text==""
        {
            var alert:UIAlertView=UIAlertView(title: "提示信息", message: "党支部地址不能为空", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            address.becomeFirstResponder()
            return
        }
        
        if  password.text != anginpassword.text
        {
            var alert:UIAlertView=UIAlertView(title: "提示信息", message: "密码不一致", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            anginpassword.becomeFirstResponder()
            return

        }
        
        let parameters = ["username":email.text,"password":password.text,"dzb":address.text]
        Alamofire.request(.POST,  Constants().BASEURL+"mu/new", parameters: parameters, encoding: ParameterEncoding.JSON).responseJSON{(request, response, resulst, error) in
            
            println(response?.statusCode)
            if error != nil
            {
                var alert:UIAlertView=UIAlertView(title: "提示信息", message: "注册失败", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
                return
            }
            else
            {
                var alertcancel:UIAlertView!
                 alertcancel=UIAlertView(title: "提示信息", message: "注册成功", delegate: self, cancelButtonTitle: "确定")
                    alertcancel.show()
            }
            
            
        }
        

    
        
    }
    
     func alertViewCancel(alertView: UIAlertView) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
//    func alertViewCancel(alertView: UIAlertView) {
//        self.dismissViewControllerAnimated(true, completion: { () -> Void in
//            
//        })
//
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
