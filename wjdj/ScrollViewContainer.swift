//
//  ScrollViewContainer.swift
//  wjdj
//
//  Created by HANBANG on 15/5/17.
//  Copyright (c) 2015年 HANBANG. All rights reserved.
//


import UIKit

class ScrollViewContainer: UIView {
    
    @IBOutlet var scrollView: UIScrollView!
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent!) -> UIView? {
        
        let view = super.hitTest(point, withEvent: event)
        if let theView = view {
            if theView == self {
                return scrollView
            }
        }
        
        return view
    }
    
}
