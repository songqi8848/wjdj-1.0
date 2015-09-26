//
//   NSUserData.swift
//  wjdj
//
//  Created by HANBANG on 15/6/27.
//  Copyright (c) 2015年 HANBANG. All rights reserved.
//

import Foundation
class  NSUserData{
    
    func cacheSetString(key: String,value: String){
        var userInfo = NSUserDefaults()
        userInfo.setValue(value, forKey: key)
    }
    
    func cacheGetString(key: String) -> String?{
        var userInfo = NSUserDefaults()
        var tmpSign = userInfo.stringForKey(key)
        return tmpSign
    
    }

}