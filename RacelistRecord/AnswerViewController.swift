//
//  AnswerViewController.swift
//  RacelistRecord
//
//  Created by lauda on 16/8/30.
//  Copyright © 2016年 lauda. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    
    var currenLevel = 0
    
    //定义问题数组
    let allQuestion = [["什么是未来","A、电动汽车","B、VR","C、深度学习","D、无人驾驶"],
                       ["九月份的越野赛有？","A、TNF100","B、UTMB","C、崂山100","D、五岳寨"],
                       ["我会什么前端开发","A、Android","B、PHP","C、VC","D、Swift"],
                       ["我在哪里上班","A、易视腾","B、合一集团","C、阿里巴巴","D、腾讯"]]
    //定义正确答案
    let rightAnswer = [2,4,4,2]
    
    //声明正在答题的变量
    var currentAnswer = 0
    
    //声明全局常量，四个按钮
    let chooseABtn = UIButton()
    let chooseBBtn = UIButton()
    let chooseCBtn = UIButton()
    let chooseDBtn = UIButton()
    
    let questionLabel = UILabel()
    let chooseALabel = UILabel()
    let chooseBLabel = UILabel()
    let chooseCLabel = UILabel()
    let chooseDLabel = UILabel()
    
    let timerLabel = UILabel()
    
    //声明一个计时器
    var timer = NSTimer()
    var 倒计时计时器 = NSTimer()
    
    //声明倒计时时间数
    var timeNum = 15
    
    
    var totalAnswerNum = 4
    var rightAnswerNum = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        倒计时计时器 = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(AnswerViewController.updateTime), userInfo: nil, repeats: true)
        
        //设置背景图片
        let backImageView = UIImageView()
        backImageView.image = UIImage(named: "chongli")
        backImageView.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
        self.view.addSubview(backImageView)

        //增加返回上页的按钮
        let backBtn = UIButton()
        backBtn.frame = CGRectMake(15, 15, 35, 35)
        backBtn.setImage(UIImage(named: "red-1"), forState: .Normal)
        self.view.addSubview(backBtn)
        backBtn.addTarget(self, action: #selector(AnswerViewController.backNewFutureVC), forControlEvents: .TouchUpInside)
        
        //增加问题题目label
        
        questionLabel.frame = CGRectMake(50, 50, 100, 20)
        questionLabel.text = allQuestion[0][0]
        questionLabel.textColor = UIColor.whiteColor()
        self.view.addSubview(questionLabel)
        
        //增加A选项label
        
        chooseALabel.frame = CGRectMake(100, 100, 100, 20)
        chooseALabel.text = allQuestion[0][1]
        chooseALabel.textColor = UIColor.whiteColor()
        self.view.addSubview(chooseALabel)
        
        //增加A按钮
        
        chooseABtn.frame = CGRectMake(100, 100, 100, 20)
//        chooseABtn.setImage(UIImage(named: "red-1"), forState: .Normal)
        chooseABtn.tag = 1
        self.view.addSubview(chooseABtn)
        chooseABtn.addTarget(self, action: #selector(AnswerViewController.answerDuiBi), forControlEvents: .TouchUpInside)
        
        //增加B选项label
        
        chooseBLabel.frame = CGRectMake(100, 150, 100, 20)
        chooseBLabel.text = allQuestion[0][2]
        chooseBLabel.textColor = UIColor.whiteColor()
        self.view.addSubview(chooseBLabel)
        
        //增加B按钮
        
        chooseBBtn.frame = CGRectMake(100, 150, 100, 20)
//        chooseBBtn.setImage(UIImage(named: "red-1"), forState: .Normal)
        chooseABtn.tag = 2
        self.view.addSubview(chooseBBtn)
        chooseBBtn.addTarget(self, action: #selector(AnswerViewController.answerDuiBi), forControlEvents: .TouchUpInside)
        
        //增加C选项label
        
        chooseCLabel.frame = CGRectMake(100, 200, 100, 20)
        chooseCLabel.text = allQuestion[0][3]
        chooseCLabel.textColor = UIColor.whiteColor()
        self.view.addSubview(chooseCLabel)
        
        //增加C按钮
        
        chooseCBtn.frame = CGRectMake(100, 200, 100, 20)
//        chooseCBtn.setImage(UIImage(named: "red-1"), forState: .Normal)
        chooseCBtn.tag = 3
        self.view.addSubview(chooseCBtn)
        chooseCBtn.addTarget(self, action: #selector(AnswerViewController.answerDuiBi), forControlEvents: .TouchUpInside)
        
        //增加D选项label
        
        chooseDLabel.frame = CGRectMake(100, 250, 100, 20)
        chooseDLabel.text = allQuestion[0][4]
        chooseDLabel.textColor = UIColor.whiteColor()
        self.view.addSubview(chooseDLabel)
        
        //增加D按钮
        
        chooseDBtn.frame = CGRectMake(100, 250, 100, 20)
//        chooseDBtn.setImage(UIImage(named: "red-1"), forState: .Normal)
        chooseDBtn.tag = 4
        self.view.addSubview(chooseDBtn)
        chooseDBtn.addTarget(self, action: #selector(AnswerViewController.answerDuiBi), forControlEvents: .TouchUpInside)
        
        //倒计时Label
        
        timerLabel.frame = CGRectMake(250, 50, 100, 20)
        timerLabel.text = "00:\(timeNum)"
        timerLabel.backgroundColor = UIColor.blackColor()
        timerLabel.textColor = UIColor.whiteColor()
        timerLabel.textAlignment = .Center
        self.view.addSubview(timerLabel)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        倒计时计时器 = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(AnswerViewController.updateTime), userInfo: nil, repeats: true)
        setOriginState()
    }
    
    override func viewDidDisappear(animated: Bool) {
        倒计时计时器.invalidate()
    }
    
    //设置控件的初始状态
    func setOriginState(){
        
        timeNum = 15
        currentAnswer = 0
        
        totalAnswerNum = 4
        
        rightAnswerNum = 0
        
        chooseABtn.setImage(UIImage(named: ""), forState: .Normal)
        chooseBBtn.setImage(UIImage(named: ""), forState: .Normal)
        chooseCBtn.setImage(UIImage(named: ""), forState: .Normal)
        chooseDBtn.setImage(UIImage(named: ""), forState: .Normal)
        
        //所有的按钮重置为可用状态
        chooseABtn.enabled = true
        chooseBBtn.enabled = true
        chooseCBtn.enabled = true
        chooseDBtn.enabled = true
        
        //更新标签的题目内容
        questionLabel.text = allQuestion[currentAnswer][0]
        chooseALabel.text = allQuestion[currentAnswer][1]
        chooseBLabel.text = allQuestion[currentAnswer][2]
        chooseCLabel.text = allQuestion[currentAnswer][3]
        chooseDLabel.text = allQuestion[currentAnswer][4]
    }
    
    //返回上个VIEW的方法
    func backNewFutureVC() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //判断答题对错
    func answerDuiBi(sender:UIButton) {
        
        //判断选择的答案是否正确
        if sender.tag == rightAnswer[currentAnswer]{
            sender.setImage(UIImage(named: "yellow-1"), forState: .Normal)
            rightAnswerNum += 1
        }else{
            sender.setImage(UIImage(named: "black-1"), forState: .Normal)
        }
        
        //判断后所有按钮不能在点击
        chooseABtn.enabled = false
        chooseBBtn.enabled = false
        chooseCBtn.enabled = false
        chooseDBtn.enabled = false
        
        //停一秒后更新题目
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(AnswerViewController.updateAnswer), userInfo: sender, repeats: false)
        
    }
    
    //更新题目
    func updateAnswer() {
        
        //更新一题后加1
        currentAnswer += 1
        
        //判断答题是否完成，如果完成，跳到结果页
        if currentAnswer >= 4 {
            
            let resultVC = resultViewController()
            
            //向resultViewController中的变量传值
            resultVC.totalResultNum = self.totalAnswerNum
            resultVC.rightResultNum = self.rightAnswerNum
            resultVC.wrongResultNum = self.totalAnswerNum - self.rightAnswerNum
            resultVC.answerResultTime = 15 - self.timeNum
            
            if self.rightAnswerNum >  self.totalAnswerNum/2 {
                allLevels[currenLevel] = 1
                writelAllLevels()
                
            }

            
            self.presentViewController(resultVC, animated: true, completion: nil)
            return
        }
         
        //所有的按钮重置为可用状态
        chooseABtn.enabled = true
        chooseBBtn.enabled = true
        chooseCBtn.enabled = true
        chooseDBtn.enabled = true
        
        //更新标签的题目内容
        questionLabel.text = allQuestion[currentAnswer][0]
        chooseALabel.text = allQuestion[currentAnswer][1]
        chooseBLabel.text = allQuestion[currentAnswer][2]
        chooseCLabel.text = allQuestion[currentAnswer][3]
        chooseDLabel.text = allQuestion[currentAnswer][4]
    
        let sender = timer.userInfo as! UIButton
        sender.setImage(UIImage(named: ""), forState: .Normal)
        
    }
    
    //更新倒计时时间
    func updateTime() {
        timeNum -= 1
        
        //如果倒计时到0，停止计时器
        if timeNum <= 0 {
            倒计时计时器.invalidate()
            timeNum = 15
            let alertVC = UIAlertController(title: "提示", message: "时间结束，请重新做答", preferredStyle: .Alert)
            
            let yesAction = UIAlertAction(title: "是", style: .Default, handler: { (action) -> Void in
                self.倒计时计时器 = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(AnswerViewController.updateTime), userInfo: nil, repeats: true)
            })
            
            let noAction = UIAlertAction(title: "否", style: .Default, handler:{ (action) -> Void in
                
                //定义resultViewController的变量
                let resultVC = resultViewController()
                
                //向resultViewController中的变量传值
                resultVC.totalResultNum = self.totalAnswerNum
                resultVC.rightResultNum = self.rightAnswerNum
                resultVC.wrongResultNum = self.totalAnswerNum - self.rightAnswerNum
                resultVC.answerResultTime = 15
                
                if self.rightAnswerNum >  self.totalAnswerNum/2 {
                    allLevels[self.currenLevel] = 1
                    //写入关卡数据
                    writelAllLevels()
                    
                }
                
                self.presentViewController(resultVC, animated: true, completion: nil)
            })
            
            alertVC.addAction(yesAction)
            alertVC.addAction(noAction)
            self.presentViewController(alertVC, animated: true, completion: nil)
        }
        
        //显示倒计时的数字，判断小于10的时候，加上一个0让界面美观
        if timeNum < 10 {
            timerLabel.text = "00:0\(timeNum)"
        } else {
            timerLabel.text = "00:\(timeNum)"
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
