//
//  WenJuanDetailController.swift
//  wjdj
//
//  Created by HANBANG on 15/7/18.
//  Copyright (c) 2015年 HANBANG. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WenJuanDetailController: UIViewController,UITableViewDataSource,UITableViewDelegate {
var DetailsNew:Survey!
    @IBOutlet weak var tableView: UITableView!
    var _index:Int=0
    var check=false
    var  lastindex:NSIndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.barTintColor=UIColor(red: 0, green: 143/255.0, blue: 215/255.0, alpha: 1)
        var titleLable=UILabel(frame: CGRectMake(0, 0, 200, 40))
        titleLable.backgroundColor=UIColor.clearColor()
        titleLable.font=UIFont.systemFontOfSize(18)
        titleLable.textColor=UIColor.whiteColor()
        titleLable.textAlignment=NSTextAlignment.Center
        titleLable.text="问卷调查"
        self.navigationItem.titleView=titleLable
        self.tableView.delegate=self
        self.tableView.dataSource=self
       // fakeTableData = NSMutableArray()


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return   DetailsNew!.Questionlist.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell
        
        if cell == nil { // no value
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell") as UITableViewCell
            cell!.selectionStyle = UITableViewCellSelectionStyle.None
        }
        if DetailsNew!.Questionlist.count>0
        {
            var title:UILabel=cell?.contentView.viewWithTag(1) as! UILabel
            var dic=DetailsNew!.Questionlist[indexPath.row] as Question
            
            title.lineBreakMode=NSLineBreakMode.ByWordWrapping
            // = UILineBreakModeWordWrap;
            title.numberOfLines = 0
            
            title.text=dic.title
        }
        if (_index == indexPath.row) {
            cell!.accessoryType = UITableViewCellAccessoryType.Checkmark;
             check=true
        } else {
            cell!.accessoryType = UITableViewCellAccessoryType.None;
        }
        //cell?.s
        return cell!

    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
//        
//        ///之前选择的
         self.lastindex=NSIndexPath(forRow: _index, inSection: 0)
        println("index:\(_index)")
        var lastCell=tableView.cellForRowAtIndexPath(self.lastindex!)
        
        lastCell?.accessoryType=UITableViewCellAccessoryType.None
        
        //现在选择的
        var cell=tableView.cellForRowAtIndexPath(indexPath);
        cell?.accessoryType=UITableViewCellAccessoryType.Checkmark
        _index=indexPath.row
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        check=true

        return indexPath
        
    }
    
    
//    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
//       ///之前选择的
//        let lastindex=NSIndexPath(index: _index)
//        println("index:\(_index)")
//       var lastCell=tableView.cellForRowAtIndexPath(lastindex)
//        
//       lastCell?.accessoryType=UITableViewCellAccessoryType.None
//        
//        //现在选择的
//        var cell=tableView.cellForRowAtIndexPath(indexPath);
//        cell?.accessoryType=UITableViewCellAccessoryType.Checkmark
//        _index=indexPath.row
//        
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        
//        check=true
//        
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func save(sender: AnyObject) {
        
        if(!check){
            var alert:UIAlertView=UIAlertView(title: "提示信息", message: "请选择选项", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            return
        }
        
        let parameters = ["questionids":DetailsNew!.Questionlist[_index].id]
        Alamofire.request(.POST,  Constants().BASEURL+"/wjdc/"+DetailsNew!.id, parameters: parameters, encoding: ParameterEncoding.JSON).responseJSON{(request, response, resulst, error) in
            
            println(response?.statusCode)
            if error == nil
            {
                var alert:UIAlertView=UIAlertView(title: "提示信息", message: "投票成功", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
                self.check=false
                return
            }
            else
            {
                var alert:UIAlertView=UIAlertView(title: "提示信息", message: "投票失败", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
                return
            }
            
            
        }
        

    }
}
