//
//  discoveryTableViewController.swift
//  RacelistRecord
//
//  Created by lauda on 16/8/24.
//  Copyright © 2016年 lauda. All rights reserved.
//

import UIKit

class discoveryTableViewController: UITableViewController {
    
    @IBOutlet var spiner: UIActivityIndicatorView!
    
    var raceGetCloudArray:[AVObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        spiner.hidesWhenStopped = true
        spiner.center = view.center
        view.addSubview(spiner)
        spiner.startAnimating()
        
        getRecordFromCloud()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.backgroundColor = UIColor.whiteColor()
        self.refreshControl?.tintColor = UIColor.grayColor()
        self.refreshControl?.addTarget(self, action: #selector(discoveryTableViewController.getNewData), forControlEvents: .ValueChanged)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getNewData() {
        getRecordFromCloud(true)
    }
    
    func getRecordFromCloud(needBee:Bool = false) {
        let query = AVQuery(className: "raceRecord")
        
        query.orderByDescending("createAt")

        //缓存策略
        if needBee {
            query.cachePolicy = .IgnoreCache
        } else {
            query.cachePolicy = .CacheElseNetwork
            query.maxCacheAge = 60 * 2
            if query.hasCachedResult() {
                print("从缓存中获取数据")
            }
        }
        
        query.findObjectsInBackgroundWithBlock { (objects, e) -> Void in
            if let e = e {
                print(e.localizedDescription)
            } else if let object = objects as? [AVObject] {
                self.raceGetCloudArray = object
                
                NSOperationQueue.mainQueue().addOperationWithBlock{
                    //表格数据更新
                    self.tableView.reloadData()
                    //菊花停止动画
                    self.spiner.stopAnimating()
                    //下拉刷新停止
                    self.refreshControl?.endRefreshing()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return raceGetCloudArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("divCell", forIndexPath: indexPath)

        let raceDivArray = raceGetCloudArray[indexPath.row]
        cell.textLabel?.text = raceDivArray["raceName"] as? String
        
        //图像点位符
        cell.imageView?.image = UIImage(named: "yellow-1")
        
        //后台下载图像
        if let img = raceDivArray["raceImage"] as? AVFile{
            img.getDataInBackgroundWithBlock({ (data, e) -> Void in
                if let e = e{
                    print(e.localizedDescription)
                    return
                }
                
                NSOperationQueue.mainQueue().addOperationWithBlock{
                    cell.imageView?.image = UIImage(data: data)

                }
            })
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
