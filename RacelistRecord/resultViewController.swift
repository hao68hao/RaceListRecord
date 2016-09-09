//
//  resultViewController.swift
//  RacelistRecord
//
//  Created by lauda on 16/8/30.
//  Copyright © 2016年 lauda. All rights reserved.
//

import UIKit

class resultViewController: UIViewController {
    
    var answerResultTime = 0
    var totalResultNum = 0
    var rightResultNum = 0
    var wrongResultNum = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        //设置背景图片
        let backImageView = UIImageView()
        backImageView.image = UIImage(named: "chongli")
        backImageView.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
        self.view.addSubview(backImageView)
        
        //答题时间标签
        let 答题时间标签 = UILabel()
        答题时间标签.frame = CGRectMake(50, 50, 150, 20)
        答题时间标签.text = "答题时间：\(answerResultTime)"
        答题时间标签.textColor = UIColor.whiteColor()
        self.view.addSubview(答题时间标签)
        
        //答题总数
        let 答题总数 = UILabel()
        答题总数.frame = CGRectMake(50, 100, 150, 20)
        答题总数.text = "答题总数：\(totalResultNum)"
        答题总数.textColor = UIColor.whiteColor()
        self.view.addSubview(答题总数)
        
        //正确题数
        let 正确题数 = UILabel()
        正确题数.frame = CGRectMake(50, 150, 150, 20)
        正确题数.text = "正确题数：\(rightResultNum)"
        正确题数.textColor = UIColor.whiteColor()
        self.view.addSubview(正确题数)
        
        //错误题数
        let 错误题数 = UILabel()
        错误题数.frame = CGRectMake(50, 200, 150, 20)
        错误题数.text = "错误题数：\(wrongResultNum)"
        错误题数.textColor = UIColor.whiteColor()
        self.view.addSubview(错误题数)
        
        //返回答题按钮
        let 返回按钮 = UIButton()
        返回按钮.frame = CGRectMake(300, 25, 35, 35)
        返回按钮.setImage(UIImage(named: "shizi"), forState: .Normal)
        self.view.addSubview(返回按钮)
        返回按钮.addTarget(self, action: #selector(resultViewController.backView), forControlEvents: .TouchUpInside)
        
        //返回题目列表按钮
        let 返回题目列表按钮 = UIButton()
        返回题目列表按钮.frame = CGRectMake(300, 80, 35, 35)
        返回题目列表按钮.setImage(UIImage(named: "map"), forState: .Normal)
        self.view.addSubview(返回题目列表按钮)
        返回题目列表按钮.addTarget(self, action: #selector(resultViewController.backAnswerListView), forControlEvents: .TouchUpInside)
    }

    //返回上个VIEW的方法
    func backView() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func backAnswerListView() {
        
        let mainStory = UIStoryboard(name: "Main", bundle: nil)
        let pageVC = mainStory.instantiateViewControllerWithIdentifier("newFutureSB") as! newFutureViewController
        self.presentViewController(pageVC, animated: true, completion: nil)
        
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
