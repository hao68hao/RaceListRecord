//
//  aboutTableViewController.swift
//  RacelistRecord
//
//  Created by lauda on 16/8/16.
//  Copyright © 2016年 lauda. All rights reserved.
//

import UIKit
import SafariServices

class aboutTableViewController: UITableViewController {
    
    var sectionTitle = ["我的老板们","跑步网站","帮助"]
    var sectionContent = [["优酷土豆","阿里巴巴","引导页"],["爱江山","爱燃烧","UTMB"],["什么是未来-直接","UIpickerView学习","天气预报"]]
    var links = ["http://www.phonedm.com","http://iranshao.com","http://utmbmontblanc.com/en/"]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView(frame: CGRectZero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return section == 0 ? 2 : 3
        if section == 0 {
            return 3
        } else if section == 1 {
            return 3
        } else {
            return 3
        }
    
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("aboutCell", forIndexPath: indexPath)

        cell.textLabel?.text = sectionContent[indexPath.section][indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            
            if indexPath.row == 0 {
                if let url = NSURL(string: "http://www.youku.com") {
                    UIApplication.sharedApplication().openURL(url)
                }
            } else if indexPath.row == 1 {
                performSegueWithIdentifier("toWebView", sender: self)
            } else if indexPath.row == 2 {
                if let pageVC = storyboard?.instantiateViewControllerWithIdentifier("GuideController") as? GuiderPageViewController{
                    presentViewController(pageVC, animated: true, completion: nil)
                }
                
               
            }

        case 1:
            if let url = NSURL(string: links[indexPath.row]){
                let sfVC = SFSafariViewController(URL: url, entersReaderIfAvailable: true)
                presentViewController(sfVC, animated: true, completion: nil)
            }
            
        case 2:
            if indexPath.row == 0 {
                if let pageVC = storyboard?.instantiateViewControllerWithIdentifier("newFutureSB") as? newFutureViewController{
                    presentViewController(pageVC, animated: true, completion: nil)
                }
            } else if indexPath.row == 1 {
                
                if let url = NSURL(string: "http://www.hangge.com/blog/cache/detail_541.html"){
                    let sfVC = SFSafariViewController(URL: url, entersReaderIfAvailable: true)
                    presentViewController(sfVC, animated: true, completion: nil)
                }

            } else if indexPath.row == 2 {
                let weatherVC = WeatherViewController()
                presentViewController(weatherVC, animated: true, completion: nil)
            }
            
            
        default:
            break
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
