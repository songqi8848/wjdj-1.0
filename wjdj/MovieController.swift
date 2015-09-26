//
//  MovieController.swift
//  wjdj
//
//  Created by HANBANG on 15/9/12.
//  Copyright (c) 2015年 HANBANG. All rights reserved.
//

import UIKit
import MediaPlayer
class MovieController: UIViewController {
    var movieplayer:MPMoviePlayerController!
        @IBOutlet weak var btnsip: UIButton!
        @IBOutlet weak var upimag: UIImageView!
        @IBOutlet weak var dowimag: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filePath:String?=NSBundle.mainBundle().pathForResource("splh", ofType: "mp4")
         movieplayer=MPMoviePlayerController(contentURL: NSURL(fileURLWithPath: filePath!))
        movieplayer.controlStyle=MPMovieControlStyle.Fullscreen
        movieplayer.view.frame=CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        
        self.view.insertSubview(movieplayer!.view, atIndex: 0)
        movieplayer.play()
        
        var notification:Void=NSNotificationCenter.defaultCenter().addObserver(self, selector: "MoveiePlayerPreLoadFinsh:", name: MPMoviePlayerPlaybackDidFinishNotification, object: nil)
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(5.0)
        

        self.upimag.transform=CGAffineTransformMakeTranslation(0, -self.upimag.frame.height/2)
        self.dowimag.transform=CGAffineTransformMakeTranslation(0, self.dowimag.frame.height/2)
        UIView.commitAnimations()
       
  
        
        // Do any additional setup after loading the view.
    }

    func MoveiePlayerPreLoadFinsh(not:NSNotification)
    {
           createMenuView()
         //self.performSegueWithIdentifier("moveident", sender: self)
    }
    @IBAction func Sip(sender: AnyObject) {
           movieplayer.stop()
           createMenuView()
          //self.performSegueWithIdentifier("moveident", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func createMenuView(){
        
        // create viewController code...
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mainViewController = storyboard.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
        let leftViewController = storyboard.instantiateViewControllerWithIdentifier("LeftViewController") as! LeftViewController
        let rightViewController = storyboard.instantiateViewControllerWithIdentifier("RightViewController") as! RightViewController
        
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        
        leftViewController.mainViewController = nvc
        
        let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController, rightMenuViewController: rightViewController)
        slideMenuController.view.backgroundColor=UIColor.whiteColor()
        self.presentViewController(slideMenuController, animated: true, completion: nil)
        
         mainViewController.viewDidLoad()
         mainViewController.viewWillAppear(true)
               //self.window?.rootViewController = slideMenuController
    
//        self.window?.makeKeyAndVisible()
    }



    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier=="moveident1"
        {
//            var mian=segue.destinationViewController as! UINavigationController;
//            
//            mian.setViewControllers([createMenuView()], animated: true)
        }
    }
  

}
