//
//  ShiPinDetailController.swift
//  wjdj
//
//  Created by HANBANG on 15/7/15.
//  Copyright (c) 2015年 HANBANG. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ShiPinDetailController: UIViewController {

    
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
            
            
            html+="<div style='font-size:13px;color=#AAAAAA'>"+(str as String).stringByReplacingOccurrencesOfString("\r\n", withString: "<br/>")+"</div><p><div style='height:150px'></div></p>"

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
    
    
    
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */

}
