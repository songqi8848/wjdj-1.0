//
//  DataContext.swift
//  wjdj
//
//  Created by HANBANG on 15/6/23.
//  Copyright (c) 2015年 HANBANG. All rights reserved.
//

import Foundation
import AlecrimCoreData

let dataContext = DataContext()!

final class DataContext: AlecrimCoreData.Context {
    
    var customerUser: AlecrimCoreData.Table<CustomerUser> { return AlecrimCoreData.Table<CustomerUser>(context: self) }

}