//
//  detailRaceListTableViewController.swift
//  RacelistRecord
//
//  Created by lauda on 16/8/15.
//  Copyright © 2016年 lauda. All rights reserved.
//

import UIKit

class detailRaceListTableViewController: UITableViewController {
    
    @IBOutlet weak var ratingBtn: UIButton!
    @IBOutlet weak var raceImageDetail: UIImageView!
    
    var raceListDetail : RacelistRecord!

    override func viewDidLoad() {
        super.viewDidLoad()
        raceImageDetail.image = UIImage(data: raceListDetail.raceImage)
        
        //详情页列表背景
        tableView.backgroundColor = UIColor(white: 0.98, alpha: 1)
        //设置单元格分割线
        tableView.tableFooterView = UIView(frame: CGRectZero)
        //设置单元格分割线颜色
        tableView.separatorColor = UIColor(white: 0.9, alpha: 1)
        
        title = raceListDetail.raceName
        
        //设置CELL的自适应高度
        tableView.estimatedRowHeight = 36 //预计行高是36
        tableView.rowHeight = UITableViewAutomaticDimension //设置为自动行高
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("detailCell", forIndexPath: indexPath) as! detailRaceListTableViewCell

        //单元格透明
        cell.backgroundColor = UIColor.clearColor()
        
        switch indexPath.row {
        case 0:
            cell.filedLabel.text = "比赛名称"
            cell.valueLabel.text = raceListDetail.raceName
        case 1:
            cell.filedLabel.text = "比赛日期"
            cell.valueLabel.text = raceListDetail.raceDate
        case 2:
            cell.filedLabel.text = "比赛类型"
            cell.valueLabel.text = raceListDetail.raceType
        case 3:
            cell.filedLabel.text = "比赛距离"
            cell.valueLabel.text = raceListDetail.raceDistance
        case 4:
            cell.filedLabel.text = "比赛钱数"
            cell.valueLabel.text = raceListDetail.raceMoney
        case 5:
            cell.filedLabel.text = "比赛地址"
            cell.valueLabel.text = raceListDetail.raceAddress
        case 6:
            cell.filedLabel.text = "比赛成绩"
            cell.valueLabel.text = raceListDetail.raceResult
        default:
            cell.filedLabel.text = ""
            cell.valueLabel.text = ""
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

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMap" {
            let destVC = segue.destinationViewController as! mapViewController
            destVC.raceListMap = self.raceListDetail
        }
    }
    
    @IBAction func close(segue:UIStoryboardSegue){
        
//        if let pingjiaVc = segue.sourceViewController as? pingjiaViewController{
//            if let detailRating = pingjiaVc.rating {
//                self.raceListDetail.raceRating = detailRating
//                self.ratingBtn.setImage(UIImage(named: detailRating), forState: .Normal)
//            }
//        }
    }
 

}
