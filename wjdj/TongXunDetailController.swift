//
//  TongXunDetailController.swift
//  wjdj
//
//  Created by HANBANG on 15/7/18.
//  Copyright (c) 2015年 HANBANG. All rights reserved.
//

import UIKit
import AddressBook
import AddressBookUI
class TongXunDetailController: UIViewController {
  var DetailsNew:ContactsName?
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var tel: UILabel!
    
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var cutitle: UILabel!
    
    @IBOutlet weak var zhewei: UILabel!
    
    @IBOutlet weak var address: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        var titleLable=UILabel(frame: CGRectMake(0, 0, 200, 40))
        titleLable.backgroundColor=UIColor.clearColor()
        titleLable.font=UIFont.systemFontOfSize(18)
        titleLable.textColor=UIColor.whiteColor()
        titleLable.textAlignment=NSTextAlignment.Center
        titleLable.text="个人资料"
        self.navigationItem.titleView=titleLable

        if var detail=DetailsNew
        {
            
           cutitle.text=detail.name ?? ""
           tel.text=detail.ContactList.first?.tel
            name.text=detail.ContactList.first?.name
            email.text=detail.ContactList.first?.email
            address.text=detail.ContactList.first?.address
            zhewei.text=detail.ContactList.first?.title
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(sender: AnyObject) {
        var error:Unmanaged<CFError>?
        var addressBook:ABAddressBookRef=ABAddressBookCreateWithOptions(nil, &error).takeRetainedValue()
        let sysAddressbookStatus=ABAddressBookGetAuthorizationStatus()
        if (sysAddressbookStatus == .Denied || sysAddressbookStatus == .NotDetermined)
        {
            var aoutorizesingal:dispatch_semaphore_t=dispatch_semaphore_create(0)
            var askauthorization:ABAddressBookRequestAccessCompletionHandler={
              success,error in
                if success
                {
                    var sysContacts:NSArray=ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue() as NSArray
                    dispatch_semaphore_signal(aoutorizesingal)
                    
                }
            
            }
            
            ABAddressBookRequestAccessWithCompletion(addressBook, askauthorization)
            dispatch_semaphore_wait(aoutorizesingal, DISPATCH_TIME_FOREVER)
        }
        var newContack:ABRecordRef!=ABPersonCreate().takeRetainedValue()
        var success:Bool=false
        success=ABRecordSetValue(newContack, kABPersonNicknameProperty, cutitle.text, &error)
        println("昵称\(success)")
            
            success=ABRecordSetValue(newContack, kABPersonFirstNameProperty, name.text, &error)
            println("姓\(success)")
            
        success=ABRecordSetValue(newContack, kABPersonLastNameProperty, name.text, &error)
         println("名\(success)")
        
        let tmpMutableMultiPhones: ABMutableMultiValue=ABMultiValueCreateMutable(ABPropertyType(kABStringPropertyType)).takeRetainedValue()
            
        success=ABMultiValueAddValueAndLabel(tmpMutableMultiPhones, tel.text, kABPersonPhoneMobileLabel, nil)
        
        success=ABRecordSetValue(newContack, kABPersonPhoneProperty, tmpMutableMultiPhones, nil)
         println("设置电话成功\(success)")
        
        success=ABAddressBookAddRecord(addressBook, newContack, &error)
        
        println("保存联系人\(success)")
        success=ABAddressBookSave(addressBook, &error)
          println("保存数据\(success)")
          
          if(success)
          {
            
            var alert:UIAlertView=UIAlertView(title: "提示信息", message: "保存通讯录成功", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            return
          }
          else
          {
            var alert:UIAlertView=UIAlertView(title: "提示信息", message: "保存通讯录失败", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            return
            
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
