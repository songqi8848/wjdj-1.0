//
//  XinGanXianController.swift
//  wjdj
//
//  Created by HANBANG on 15/7/17.
//  Copyright (c) 2015年 HANBANG. All rights reserved.
//

import UIKit

class XinGanXianController: UIViewController {

    
    @IBOutlet weak var seqgment: UISegmentedControl!
    
    @IBAction func seqmentSelect(sender: AnyObject) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarItem()
        var titleLable=UILabel(frame: CGRectMake(0, 0, 200, 40))
        titleLable.backgroundColor=UIColor.clearColor()
        titleLable.font=UIFont.systemFontOfSize(18)
        titleLable.textColor=UIColor.whiteColor()
        titleLable.textAlignment=NSTextAlignment.Center
        titleLable.text="红领新干线"
        self.navigationItem.titleView=titleLable
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let vc1 = viewControllerWithTuWen()
        let vc2 = viewControllerShiPin()
        
        let slidingContainerViewController = SlidingContainerViewController (
            parent: self,
            contentViewControllers: [vc1, vc2],
            titles: ["问题反馈", "问卷调查"])
        
        view.addSubview(slidingContainerViewController.view)
        
        slidingContainerViewController.sliderView.appearance.outerPadding = 0
        slidingContainerViewController.sliderView.appearance.innerPadding = 50
        slidingContainerViewController.setCurrentViewControllerAtIndex(0)
    }
    
    func viewControllerWithTuWen () -> UIViewController {
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tongXunLuController = storyboard.instantiateViewControllerWithIdentifier("wenti") as! WenTiController
        
        return tongXunLuController
    }
    func viewControllerShiPin () -> UIViewController {
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tongXunLuController = storyboard.instantiateViewControllerWithIdentifier("wenjuan") as! WenJuanController
        
        return tongXunLuController
        
    }
    
    // MARK: SlidingContainerViewControllerDelegate
        
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
