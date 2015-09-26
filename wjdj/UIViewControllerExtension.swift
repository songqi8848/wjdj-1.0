//
//  UIViewControllerExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setNavigationBarItem() {
       self.navigationController!.navigationBar.barTintColor=UIColor(red: 0, green: 143/255.0, blue: 215/255.0, alpha: 1)
        
        self.addLeftBarButtonWithImage(UIImage(named: "fa-list-ul")!)
        self.addRightBarButtonWithImage(UIImage(named: "fa-cog")!)
    }
}
extension JPTabViewController{
    override public func  viewDidLoad() {
     //self.setNavigationBarItem()
      super.viewDidLoad()

        
        
    }
 
}
