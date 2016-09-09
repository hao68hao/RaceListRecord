//
//  raceListTableViewController.swift
//  RacelistRecord
//
//  Created by lauda on 16/8/15.
//  Copyright © 2016年 lauda. All rights reserved.
//

import UIKit
import CoreData

class raceListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    
    var raceRecordArray:[RacelistRecord] = []
    var frc : NSFetchedResultsController!
    var sc : UISearchController! //声明一个搜索条控制器变量
    var sr:[RacelistRecord] = [] //声明一个搜索结果数据，值为空
    
  
    /*
    实现搜索筛选器：
    1、建立筛选器：searchFilter
    2、对所有的比赛数据进行筛选：raceRecordArray
    3、筛选符合TextToserch的字符串，通过containsString检测一个字符串是否包含另一个字符串
    4、返回给新的数组sr
    */
    
    func searchFilter(TextToserch : String){
        sr = raceRecordArray.filter({ (r) -> Bool in
            return r.raceName.containsString(TextToserch)
//            return r.raceAddress.containsString(TextToserch)
        })
    }
    
    //实现搜索结果更新
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if var textToSearch = sc.searchBar.text{
            
            //去除搜索字符中的空格，实现输入关键字有空格也可以搜索出来结果
            textToSearch = textToSearch.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            
            searchFilter(textToSearch)
            tableView.reloadData()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置详情页的返回按钮样式
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .Plain, target: nil, action: nil)
        
        /*
        取回core data中的数据
         */
        
        //获取哪个entity，即哪个存储的数据表
        let request = NSFetchRequest(entityName: "RacelistRecord")
        //排序，按raceName排序
        let sd = NSSortDescriptor(key: "raceName", ascending: true)
        request.sortDescriptors = [sd]
        
        //获取缓冲区
        let buffer = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
        
        frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: buffer!, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self  //指定代理
        
        do {
            try frc.performFetch()
            raceRecordArray = frc.fetchedObjects as! [RacelistRecord]//执行查询将结果保存到数据中
        }catch{
            print(error)
        }
        
        //添加搜索条
        sc = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = sc.searchBar
        
        //搜索控制器更新
        sc.searchResultsUpdater = self
        //点击搜索框时，背景不变暗
        sc.dimsBackgroundDuringPresentation = false
        //定制搜索框的外观
        sc.searchBar.placeholder = "请输入名称"
        sc.searchBar.tintColor = UIColor.orangeColor()
        sc.searchBar.barTintColor = UIColor.orangeColor()
        sc.searchBar.searchBarStyle = .Minimal

    }
    
    override func viewDidAppear(animated: Bool) {
         //设置pageViewController出现
        super.viewDidAppear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if defaults.boolForKey("GuiderShower"){
            return
        }
        
        if let pageVC = storyboard?.instantiateViewControllerWithIdentifier("GuideController") as? GuiderPageViewController{
            presentViewController(pageVC, animated: true, completion: nil)
        }
        
    }
    
    /*
    当数据库内容发生变化时，NSFetchedResultsControllerDelegate协议的以下方法会被调用
     */
    
    //当控制器开始处理内容变化时
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }

    //当控制器已经处理完内容变化时
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //当控制器正在进行内容处理变化时
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type {
        case .Insert:
            if let _newIndexPath = newIndexPath{
                tableView.insertRowsAtIndexPaths([_newIndexPath], withRowAnimation: .Automatic)
            }
        case .Delete:
            if let _indexPath = indexPath{
                tableView.deleteRowsAtIndexPaths([_indexPath], withRowAnimation: .Automatic)
            }
        case .Update:
            if let _indexPath = indexPath{
                tableView.reloadRowsAtIndexPaths([_indexPath], withRowAnimation: .Automatic)
            }
        default:
            tableView.reloadData()
        }
        raceRecordArray = controller.fetchedObjects as! [RacelistRecord]
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if sc.active {
            return sr.count
        } else {
            return raceRecordArray.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("raceList", forIndexPath: indexPath) as! raceListTableViewCell
        
        let r = sc.active ? sr[indexPath.row] : raceRecordArray[indexPath.row]
        
        cell.raceName.text = r.raceName
        
        cell.raceImage.image = UIImage(data: r.raceImage)
        //设置图片为圆型
        cell.raceImage.layer.cornerRadius = 35
        cell.raceImage.clipsToBounds = true
        
        cell.raceAddress.text = r.raceAddress
        cell.raceDate.text = r.raceDate
        cell.raceResult.text = r.raceResult
        
        return cell
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        //定义滑动菜单的项目【删除】
        let 删除形为 = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "删除") { (action, indexPath) -> Void in
            
            let buffer = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
            let restaurantToDel = self.frc.objectAtIndexPath(indexPath) as! RacelistRecord
            
            buffer?.deleteObject(restaurantToDel)
            
            do {
                try buffer?.save()
            }catch{
                print(error)
            }
        }
        
        //定义滑动菜单的项目【分享】
        let 分享形为 = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "分享") { (action, indexPath) -> Void in
            
            let shareAC = UIAlertController(title: "分享到", message: "选择想分享的社交", preferredStyle: UIAlertControllerStyle.ActionSheet)
            
            let shareQQ = UIAlertAction(title: "QQ", style: UIAlertActionStyle.Default, handler: nil)
            let shareWB = UIAlertAction(title: "微博", style: UIAlertActionStyle.Default, handler: nil)
            let shareWX = UIAlertAction(title: "微信", style: UIAlertActionStyle.Default, handler: nil)
            let shareFB = UIAlertAction(title: "FaceBook", style: UIAlertActionStyle.Default, handler: nil)
            let shareCancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.Default, handler: nil)
            
            shareAC.addAction(shareQQ)
            shareAC.addAction(shareWB)
            shareAC.addAction(shareWX)
            shareAC.addAction(shareFB)
            shareAC.addAction(shareCancel)
            
            self.presentViewController(shareAC, animated: true, completion: nil)
        }
        分享形为.backgroundColor = UIColor(red: 90/255, green: 122/255, blue: 58/255, alpha: 1)
        
        
        return [分享形为, 删除形为]

    }
    
    
    

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return !sc.active
    }
 

    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showRaceDetail"{
            let destVC = segue.destinationViewController as! detailRaceListTableViewController
            
            
            destVC.raceListDetail = sc.active ? sr[tableView.indexPathForSelectedRow!.row] : raceRecordArray[tableView.indexPathForSelectedRow!.row]
            
            
            destVC.hidesBottomBarWhenPushed = true
        }
    }
    
    @IBAction func unwindtoHome(segue: UIStoryboardSegue) {
        
    }
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */

}

/*
 var raceRecordArray = [
 raceRecordStruck(raceName: "TNF100", raceDate: "2016-05-13", reacType: "越野跑", raceDistance: "50公里", raceImage: "1.jpg", raceMoney: "699元", raceAddress: "北京海淀区狂飙乐园", reacResult: "8:23") ,
 raceRecordStruck(raceName: "郑开国际马拉松", raceDate: "2016-03-12", reacType: "公路跑", raceDistance: "42公里", raceImage: "2.jpg", raceMoney: "120元", raceAddress: "河南省郑州市郑开大道", reacResult: "4:42") ,
 raceRecordStruck(raceName: "崇礼100超级天路越野挑战赛", raceDate: "2016-08-14", reacType: "越野跑", raceDistance: "57公里", raceImage: "3.jpg", raceMoney: "699元", raceAddress: "河北省张家口市崇礼县万龙滑雪场", reacResult: "10:20") ,
 raceRecordStruck(raceName: "北京国际长跑节", raceDate: "2016-04-12", reacType: "公路跑", raceDistance: "21公里", raceImage: "4.jpg", raceMoney: "120元", raceAddress: "北京天安门广场", reacResult: "2:35") ,
 raceRecordStruck(raceName: "TNF100", raceDate: "2016-05-13", reacType: "越野跑", raceDistance: "50公里", raceImage: "1.jpg", raceMoney: "699元", raceAddress: "北京海淀区狂飙乐园", reacResult: "8:23") ,
 raceRecordStruck(raceName: "郑开国际马拉松", raceDate: "2016-03-12", reacType: "公路跑", raceDistance: "42公里", raceImage: "2.jpg", raceMoney: "120元", raceAddress: "河南省郑州市郑开大道", reacResult: "4:42") ,
 raceRecordStruck(raceName: "崇礼100超级天路越野挑战赛", raceDate: "2016-08-14", reacType: "越野跑", raceDistance: "57公里", raceImage: "3.jpg", raceMoney: "699元", raceAddress: "河北省张家口市崇礼县万龙滑雪场", reacResult: "10:20") ,
 raceRecordStruck(raceName: "北京国际长跑节", raceDate: "2016-04-12", reacType: "公路跑", raceDistance: "21公里", raceImage: "4.jpg", raceMoney: "120元", raceAddress: "北京天安门广场", reacResult: "2:35") ,
 raceRecordStruck(raceName: "TNF100", raceDate: "2016-05-13", reacType: "越野跑", raceDistance: "50公里", raceImage: "1.jpg", raceMoney: "699元", raceAddress: "北京海淀区狂飙乐园", reacResult: "8:23") ,
 raceRecordStruck(raceName: "郑开国际马拉松", raceDate: "2016-03-12", reacType: "公路跑", raceDistance: "42公里", raceImage: "2.jpg", raceMoney: "120元", raceAddress: "河南省郑州市郑开大道", reacResult: "4:42") ,
 raceRecordStruck(raceName: "崇礼100超级天路越野挑战赛", raceDate: "2016-08-14", reacType: "越野跑", raceDistance: "57公里", raceImage: "3.jpg", raceMoney: "699元", raceAddress: "河北省张家口市崇礼县万龙滑雪场", reacResult: "10:20") ,
 raceRecordStruck(raceName: "北京国际长跑节", raceDate: "2016-04-12", reacType: "公路跑", raceDistance: "21公里", raceImage: "4.jpg", raceMoney: "120元", raceAddress: "北京天安门广场", reacResult: "2:35"),
 raceRecordStruck(raceName: "TNF100", raceDate: "2016-05-13", reacType: "越野跑", raceDistance: "50公里", raceImage: "1.jpg", raceMoney: "699元", raceAddress: "北京海淀区狂飙乐园", reacResult: "8:23") ,
 raceRecordStruck(raceName: "郑开国际马拉松", raceDate: "2016-03-12", reacType: "公路跑", raceDistance: "42公里", raceImage: "2.jpg", raceMoney: "120元", raceAddress: "河南省郑州市郑开大道", reacResult: "4:42") ,
 raceRecordStruck(raceName: "崇礼100超级天路越野挑战赛", raceDate: "2016-08-14", reacType: "越野跑", raceDistance: "57公里", raceImage: "3.jpg", raceMoney: "699元", raceAddress: "河北省张家口市崇礼县万龙滑雪场", reacResult: "10:20") ,
 raceRecordStruck(raceName: "北京国际长跑节", raceDate: "2016-04-12", reacType: "公路跑", raceDistance: "21公里", raceImage: "4.jpg", raceMoney: "120元", raceAddress: "北京天安门广场", reacResult: "2:35"),
 raceRecordStruck(raceName: "TNF100", raceDate: "2016-05-13", reacType: "越野跑", raceDistance: "50公里", raceImage: "1.jpg", raceMoney: "699元", raceAddress: "北京海淀区狂飙乐园", reacResult: "8:23") ,
 raceRecordStruck(raceName: "郑开国际马拉松", raceDate: "2016-03-12", reacType: "公路跑", raceDistance: "42公里", raceImage: "2.jpg", raceMoney: "120元", raceAddress: "河南省郑州市郑开大道", reacResult: "4:42") ,
 raceRecordStruck(raceName: "崇礼100超级天路越野挑战赛", raceDate: "2016-08-14", reacType: "越野跑", raceDistance: "57公里", raceImage: "3.jpg", raceMoney: "699元", raceAddress: "河北省张家口市崇礼县万龙滑雪场", reacResult: "10:20") ,
 raceRecordStruck(raceName: "北京国际长跑节", raceDate: "2016-04-12", reacType: "公路跑", raceDistance: "21公里", raceImage: "4.jpg", raceMoney: "120元", raceAddress: "北京天安门广场", reacResult: "2:35")
 ]
 */

