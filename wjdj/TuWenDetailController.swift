//
//  TuWenDetailController.swift
//  wjdj
//
//  Created by HANBANG on 15/7/15.
//  Copyright (c) 2015年 HANBANG. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class TuWenDetailController: UIViewController {
    
    
    var newsList:NewsList?
    
    var imag: UIImageView?
    var textview: UILabel!
    
    
    
    @IBOutlet weak var webview: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.barTintColor=UIColor(red: 0, green: 143/255.0, blue: 215/255.0, alpha: 1)
        if var new=newsList
        {
            
            var html="<p style='font-size:15px'>"+new.newslist_item_title+"</p>"
            html+="<p style='font-size:10px;color=#AAAAAA'>"+new.modified+"</p>"
            if new.thumb.lowercaseString.hasSuffix("jpg")||new.thumb.lowercaseString.hasSuffix("png")||new.thumb.lowercaseString.hasSuffix("bmp")||new.thumb.lowercaseString.hasSuffix("jpeg")
            {
                html+="<p> <img src='"+new.thumb+"' style='width:100%;height:150px;border:0px'></img></p>"
            }
            var error:NSErrorPointer=nil;
            var encode:NSStringEncoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue))
            
            var str:NSString=NSString(contentsOfURL: NSURL(string: newsList!.newslist_item_content)!, encoding: encode, error: error)!
            
            html+="<div style='font-size:13px;color=#AAAAAA'>&nbsp;&nbsp;"+(str as String).stringByReplacingOccurrencesOfString("\r\n", withString: "<br/>&nbsp;&nbsp;")+"</div><p><div style='height:150px'></div></p>"

            webview.loadHTMLString(html, baseURL: nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        if textView.isFirstResponder()
        {
            return true
        }
        return false
    }
    
    

//    
//    var newsList:NewsList?
//    
//    var imag: UIImageView?
//    var textview: UILabel!
//    
//    @IBOutlet weak var scrollview: UIScrollView!
//    
//    @IBOutlet weak var newTitle: UILabel!
//    @IBOutlet weak var Newstime: UILabel!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.navigationController!.navigationBar.barTintColor=UIColor(red: 0, green: 143/255.0, blue: 215/255.0, alpha: 1)
//        if var new=newsList
//        {
//            textview=UILabel();
//            //textview.delegate=self
//            newTitle.numberOfLines=0
//            newTitle.lineBreakMode=NSLineBreakMode.ByWordWrapping
//            newTitle.adjustsFontSizeToFitWidth=true;
//            newTitle.text=new.newslist_item_title
//            Newstime.text=new.modified
//            //delaysContentTouches
//            //            self.scrollview.delaysContentTouches=true
//            //            self.scrollview.canCancelContentTouches=true
//            //            self.scrollview.touchesShouldCancelInContentView(textview)
//            
//            //         self.textview.returnKeyType=UIReturnKeyType.Default //返回键的类型
//            //
//            //         self.textview.keyboardType=UIKeyboardType.Default
//            var width=self.scrollview.frame.width
//            var height=self.scrollview.frame.height
//            if new.thumb.lowercaseString.hasSuffix("jpg")||new.thumb.lowercaseString.hasSuffix("png")||new.thumb.lowercaseString.hasSuffix("bmp")||new.thumb.lowercaseString.hasSuffix("jpeg")
//            {
//                imag=UIImageView();
//                
//                imag?.frame=CGRectMake(0, 90, width, 150)
//                // imag?.contentMode=UIViewContentMode.Center
//                
//                var url=NSURL(string: new.thumb)
//                imag?.setImageWithURL(url!,cacheScaled: true) { (imageInstance, error) in
//                    
//                    if error==nil
//                    {
//                        let transition = CATransition()
//                        self.scrollview.addSubview(self.imag!)
//                        
//                        self.addSubText(CGRectMake(0, 95+150, width,height))
//                        self.imag?.layer.addAnimation(transition, forKey: "fade")
//                        
//                        
//                    }
//                    else
//                    {
//                        
//                        self.addSubText(CGRectMake(0, 95, width,height))
//                        
//                    }
//                    
//                    
//                }
//            }
//            else
//            {
//                
//                self.addSubText(CGRectMake(0, 95, width,height))
//                
//                println(self.scrollview.frame)
//                println(self.scrollview.contentSize)
//                
//            }
//            
//        }
//        
//        // Do any additional setup after loading the view.
//    }
//    
//    func addSubText(frame:CGRect)
//    {
//        
//        var error:NSErrorPointer=nil;
//        ///NSUTF8StringEncoding
//        var encode:NSStringEncoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue))
//        
//        var str:NSString=NSString(contentsOfURL: NSURL(string: newsList!.newslist_item_content)!, encoding: encode, error: error)!
//        
//        self.textview.font=UIFont.systemFontOfSize(14)
//        self.textview.autoresizesSubviews = true
//        self.textview.text=str as String
//        self.textview.frame=frame
//        self.textview.numberOfLines=0
//        var fixedWidth:CGFloat=textview.frame.size.width
//        
//        var newSize:CGSize=textview.sizeThatFits(CGSizeMake(fixedWidth, CGFloat(MAXFLOAT)))
//        var newFrame:CGRect=textview.frame
//        newFrame.size=CGSizeMake(CGFloat(fmaxf(Float(newSize.width),Float(fixedWidth))), newSize.height);
//        textview.frame = newFrame
//        
//        self.scrollview.contentSize=CGSize(width: self.textview.frame.size.width, height: self.textview.frame.size.height+350)
//        
//        self.scrollview.addSubview(self.textview)
//        
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
//        if textView.isFirstResponder()
//        {
//            return true
//        }
//        return false
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
