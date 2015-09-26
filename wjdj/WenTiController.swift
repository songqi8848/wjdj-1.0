//
//  WenTiController.swift
//  wjdj
//
//  Created by HANBANG on 15/7/17.
//  Copyright (c) 2015年 HANBANG. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData
class WenTiController: UIViewController {

    @IBOutlet weak var textTitle: UITextField!
   
    @IBOutlet weak var textContent: UITextView!
    
    @IBOutlet weak var textEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textContent.layer.borderColor=UIColor(red: 193.0/255.0, green: 194.0/255.0, blue: 187.0/255.0, alpha: 1).CGColor
         textContent.layer.borderWidth=1
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(sender: AnyObject) {
        if(textTitle.text.isEmpty)
        {
           UIAlertView(title: "提示", message: "标题不能为空", delegate: nil, cancelButtonTitle: "确定").show()
            return
        }
        if(textContent.text.isEmpty)
        {
            UIAlertView(title: "提示", message: "内反馈意见不能为空", delegate: nil, cancelButtonTitle: "确定").show()
            return
        }
        
        if(textEmail.text.isEmpty)
        {
            UIAlertView(title: "提示", message: "邮箱地址不能为空！", delegate: nil, cancelButtonTitle: "确定").show()
            return
        }
        
        let parameters = ["title":textTitle.text,"content":textContent.text,"email":textEmail.text]
        
        Alamofire.request(.POST,  Constants().BASEURL+"/ev", parameters: parameters, encoding: ParameterEncoding.JSON).responseJSON{(request, response, resulst, error) in
            
            println(response?.statusCode)
            if error == nil
            {
                var alert:UIAlertView=UIAlertView(title: "提示信息", message: "您的反馈已提交", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
                 self.textTitle.text=""
                self.textContent.text=""
                 self.textEmail.text=""
                return
            }
            else
            {
                var alert:UIAlertView=UIAlertView(title: "提示信息", message: "反馈失败", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
            }
            
            
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
