//
//  guiderContentViewController.swift
//  RacelistRecord
//
//  Created by lauda on 16/8/26.
//  Copyright © 2016年 lauda. All rights reserved.
//

import UIKit

class guiderContentViewController: UIViewController {

    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var footerLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageCtrl: UIPageControl!
    @IBOutlet weak var doneBtn: UIButton!
    
    @IBAction func dontBtnTap(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
        
        //记录引导页显示的次数
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "GuiderShower")
    }
    
    var header = ""
    var footer = ""
    var imageName = ""
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headLabel.text = header
        footerLabel.text = footer
        imageView.image = UIImage(named: imageName)
        
        //显示页面底部的豆点页码
        pageCtrl.currentPage = index
        
        //当第九页时，显示按钮
        if index == 8 {
            doneBtn.hidden = false
        } else {
            doneBtn.hidden = true
        }

    }

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
