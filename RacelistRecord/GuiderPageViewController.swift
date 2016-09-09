//
//  GuiderPageViewController.swift
//  RacelistRecord
//
//  Created by lauda on 16/8/29.
//  Copyright © 2016年 lauda. All rights reserved.
//

import UIKit

class GuiderPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var headings = ["小腿根部拉伸","膝盖韧带拉伸","髋部拉伸","腰部拉伸","腰后部拉伸","大腿内侧拉伸","肩颈拉伸","臀部拉伸","大腿拉伸"]
    var images = ["01","02","03","04","05","06","07","08","09"]
    var footers = ["促进小腿血液循环","改善膝盖的康复状态","站姿压腿拉伸可以拉伸髋部和腿部","可以对腰背进行锻炼","坐姿前压可以拉伸腰后部肌肉","俯卧压腿拉伸可以锻炼小腿","缓解肩部的紧张状态","缓解臀部的肌肉疲劳","撑墙提腿可以拉伸腿部肌肉"]

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! guiderContentViewController).index
        index += 1
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! guiderContentViewController).index
        index -= 1
        return viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index: Int) -> guiderContentViewController? {
        
        if case 0 ..< headings.count = index {
            
            //创建一个新视图控制器并传递数据
            if let contentVC = storyboard?.instantiateViewControllerWithIdentifier("GuiderContentController") as? guiderContentViewController {
                contentVC.imageName = images[index]
                contentVC.header = headings[index]
                contentVC.footer = footers[index]
                contentVC.index = index
                
                return contentVC
            }
        } else {
            return nil
        }
        
        return nil
    }
    
    /*
    //显示页面底部的逗点页数
    //要显示的页数
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int{
        return headings.count
    }
    
    //起始页的索引
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int{
        return 0
    }
    */

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        if let statringVC = viewControllerAtIndex(0){
            setViewControllers([statringVC], direction: .Forward, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


