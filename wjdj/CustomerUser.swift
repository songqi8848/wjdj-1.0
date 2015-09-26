//
//  CustomerUser.swift
//  wjdj
//
//  Created by HANBANG on 15/6/24.
//  Copyright (c) 2015年 HANBANG. All rights reserved.
//

import Foundation
import CoreData
import AlecrimCoreData
@objc(CustomerUser)
class CustomerUser: NSManagedObject {

    @NSManaged var userId: String
    @NSManaged var token: String
    @NSManaged var dzb: String
    @NSManaged var loginNo: String

}
extension CustomerUser
{
    static let userId = AlecrimCoreData.Attribute<String>("userId")
    static let token = AlecrimCoreData.Attribute<String>("token")
    static let dzb = AlecrimCoreData.Attribute<String>("dzb")
    
}
