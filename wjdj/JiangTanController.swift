//
//  JiangTanController.swift
//  wjdj
//
//  Created by HANBANG on 15/5/16.
//  Copyright (c) 2015年 HANBANG. All rights reserved.
//

import UIKit
var rect:CGRect?
var viewTuWen:UIView?

var tuwenx:CGFloat?
var tuweny:CGFloat?
var tuwenheight:CGFloat?
var tuwenwidht:CGFloat?

class JiangTanController: UIViewController {

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
        titleLable.text="红领讲坛"
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
            titles: ["图文资料", "视频资料"])
        
        view.addSubview(slidingContainerViewController.view)
        
        slidingContainerViewController.sliderView.appearance.outerPadding = 0
        slidingContainerViewController.sliderView.appearance.innerPadding = 50
        slidingContainerViewController.setCurrentViewControllerAtIndex(0)
    }
    
    func viewControllerWithTuWen () -> UIViewController {
        
             var storyboard = UIStoryboard(name: "Main", bundle: nil)
              let tongXunLuController = storyboard.instantiateViewControllerWithIdentifier("TuWen") as! TuWenController
        
        return tongXunLuController
    }
    func viewControllerShiPin () -> UIViewController {
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tongXunLuController = storyboard.instantiateViewControllerWithIdentifier("shipin") as! ShiPinController
        
        return tongXunLuController
        
//                var storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let tongXunLuController = storyboard.instantiateViewControllerWithIdentifier("ceshi") as! WebViewController
//        
//                return tongXunLuController
    }
    
    // MARK: SlidingContainerViewControllerDelegate
    
    func slidingContainerViewControllerDidShowSliderView(slidingContainerViewController: SlidingContainerViewController) {
        
    }
    
    func slidingContainerViewControllerDidHideSliderView(slidingContainerViewController: SlidingContainerViewController) {
        
    }
    
    func slidingContainerViewControllerDidMoveToViewController(slidingContainerViewController: SlidingContainerViewController, viewController: UIViewController) {
        
    }
    
    func slidingContainerViewControllerDidMoveToViewControllerAtIndex(slidingContainerViewController: SlidingContainerViewController, index: Int) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func SeqSwitch(sender:AnyObject?)
    {
       var segment:UISegmentedControl=sender as! UISegmentedControl
        
        switch sender!.selectedSegmentIndex
        {
         case 0:
            var tongxunlu:TongXunLuController=TongXunLuController()
            self.view.addSubview(tongxunlu.view)
         case 1:
            println(2)
        default:
            println(3)
        }
        
    
    }
    
    func LoadViewTuWen(){
       viewTuWen=UIView();
       seqgment.frame.maxX
       viewTuWen?.frame=CGRectMake(0, tuweny!+30, tuwenwidht!, tuwenheight!)
       viewTuWen?.backgroundColor=UIColor.blueColor()
       self.view.addSubview(viewTuWen!)
    
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
