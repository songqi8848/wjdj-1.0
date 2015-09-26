//
//  AboutController.swift
//  wjdj
//
//  Created by HANBANG on 15/7/19.
//  Copyright (c) 2015年 HANBANG. All rights reserved.
//

import UIKit

class AboutController: UIViewController {

    @IBAction func close(sender: AnyObject) {
         self.dismissViewControllerAnimated(true,completion: { () -> Void in })
       
    }
   
    @IBOutlet weak var webview: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.barTintColor=UIColor(red: 0, green: 143/255.0, blue: 215/255.0, alpha: 1)
        var titleLable=UILabel(frame: CGRectMake(0, 0, 200, 40))
        titleLable.backgroundColor=UIColor.clearColor()
        titleLable.font=UIFont.systemFontOfSize(18)
        titleLable.textColor=UIColor.whiteColor()
        titleLable.textAlignment=NSTextAlignment.Center
        titleLable.text="关于"
        self.navigationItem.titleView=titleLable
        //读取中文时首先要取得中文编码
        var conntent="<div style='font-size:13px;color=#AAAAAA'>&nbsp;&nbsp;认真贯彻落实党的十八大和十八届三中、四中全会精神，牢固树立“上级服务基层、党建服务中心、党员服务群众”的意识，深入推进基层服务型党组织建设，进一步扩大"
        conntent+="党的组织覆盖和工作覆盖，建设好服务载体和平台，注重运用现代信息技术提高服务效能，为广大党员群众提供全方位、专业化、规范化服务。<br/>"
        conntent+="&nbsp;&nbsp;将开发区（同里镇）非公党建网站上的新闻、通知、在线学习等模块，集成到手机端、PAD端，通过高速的3G、4G网络，让党员群众随时随地登录非公党建网站，了解第一手"
        conntent+="新闻、通知，随时随地在线学习。<br/>"
        conntent+="&nbsp;&nbsp;1、移动办公更及时。随时随地通过手机等智能终端登录政务内网平台进行日常工作批复、流程流转。<br/>"
       conntent+=" &nbsp;&nbsp;2、信息传达更快速。通过该项目平台定期发送电子信息、会议通知、调查问卷等信息，支持互动反馈，及时收集非公企业的信息。<br/>"
        conntent+="&nbsp;&nbsp;3、在线学习更全面。及时发布党建知识、领导讲话等学习资料，通过该平台可直接在手机终端上在线学习。<br/>"
       conntent+=" &nbsp;&nbsp;4、动态展示更新颖。有效地将WAP、WEB、APP三版合一，非公党建网站不再局限于电脑网络，可通过手机等其它智能终端展示工作成果及进度。<br/>"
        conntent+="&nbsp;&nbsp;５、交流互动更便捷。建立非公党建工作者通讯录，建立企业蓝信群，交流形式和时间不再单一，在一个共同目的基础上搭建一个触手可及的交流平台，让所有党建工作者参与到党建工作中。<br/></div>"
        
         webview.loadHTMLString(conntent.stringByReplacingOccurrencesOfString("\r\n", withString: "<br/>&nbsp;&nbsp;"), baseURL: nil)
//        var encode:NSStringEncoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue))
//
//       
//        
//    var str:NSString=NSString(contentsOfURL: NSURL(string: NSBundle.mainBundle().pathForResource("about", ofType:"txt")!)!, encoding: encode, error: nil)!
//        
//        println(str)
//        //取得当前应用下路径
//        var sp = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentationDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
//        
//        //循环出力取得路径
//        for file in sp {
//            println(file)
//        }
//        
//        //设定路径
//        var url: NSURL = NSURL(fileURLWithPath: "/Users/Shared/data.txt")!
//        
//        //定义可变数据变量
//        var data = NSMutableData()
//        //向数据对象中添加文本，并制定文字code
//        data.appendData("Hello Swift".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!)
//        //用data写文件
//        data.writeToFile(url.path!, atomically: true)
//        
//        //从url里面读取数据，读取成功则赋予readData对象，读取失败则走else逻辑
//        if let readData = NSData(contentsOfFile: url.path!) {
//            //如果内容存在 则用readData创建文字列
//            println(NSString(data: readData, encoding: NSUTF8StringEncoding))
//        } else {
//            //nil的话，输出空
//            println("Null")
//        }
        // Do any additional setup after loading the view.
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
