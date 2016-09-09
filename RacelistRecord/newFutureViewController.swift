//
//  newFutureViewController.swift
//  RacelistRecord
//
//  Created by lauda on 16/8/30.
//  Copyright © 2016年 lauda. All rights reserved.
//

import UIKit

//全局变量
//声明一个所有关卡是否通过
var allLevels = [1,0,0]

//定义函数存储游戏关卡是否通关的数据
func writelAllLevels() {
    let ud = NSUserDefaults.standardUserDefaults()
    for i in 0..<3 {
        ud.setInteger(allLevels[i], forKey: "level\(i+1)")
    }
}

//定义函数读取存储的游戏关卡数据
func readAllLevels() {
    let ud = NSUserDefaults.standardUserDefaults()
    for i in 0..<3 {
        allLevels[i] = ud.integerForKey("level\(i+1)")
    }
}

class newFutureViewController: UIViewController {

    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var allButtons = [UIButton]()
    
    @IBAction func backBtn(sender: UIButton) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func turnAnswerVC(sender: UIButton) {
        
        let btn = sender as UIButton
        let tag = btn.tag
        
        if allLevels[tag-1] == 1 {
            let answerVC = AnswerViewController()
            answerVC.currenLevel = tag
            presentViewController(answerVC, animated: true, completion: nil)
        } else {
            let alertVC = UIAlertController(title: "提示", message: "还未解锁", preferredStyle: .Alert)
            let actionYes = UIAlertAction(title: "好的", style: .Default, handler: nil)
            
            alertVC.addAction(actionYes)
            presentViewController(alertVC, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func resultTempVC(sender: UIButton) {
//        let resultVC = resultViewController()
//        presentViewController(resultVC, animated: true, completion: nil)
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //读取关卡的数据
        readAllLevels()
        //第一关设置为1，否则为未开锁状态
        allLevels[0] = 1
        
        allButtons.append(button1)
        allButtons.append(button2)
        allButtons.append(button3)
        
        let str = NSTemporaryDirectory()
        print(str)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //开锁功能
    override func viewWillAppear(animated: Bool) {
        for i in 0 ..< 3 {
            if allLevels[i] == 1 {
                allButtons[i].setImage(UIImage(named: "shizi"), forState: .Normal)
            }

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

}
