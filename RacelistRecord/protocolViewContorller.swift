//
//  protocolViewContorller.swift
//  RacelistRecord
//
//  Created by lauda on 16/8/29.
//  Copyright © 2016年 lauda. All rights reserved.
//

import UIKit

// 定义协议
protocol protocolVCDelegate {
    func getTextValue(title:String)
}

class protocolViewContorller: UIViewController {
    
    var textFiled : UITextField?
    
    var delegate : protocolVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        let screenWidth = self.view.frame.size.width
        textFiled = UITextField(frame: CGRectMake( 10, 40, screenWidth - 20, 35))
        textFiled?.borderStyle = UITextBorderStyle.RoundedRect
        textFiled?.placeholder = "  ..."
        textFiled?.becomeFirstResponder()
        let btn = UIButton(frame: CGRectMake( 10, 80, screenWidth - 20, 35))
        btn.setTitle("协议传值按钮", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        btn.addTarget(self, action: #selector(protocolViewContorller.save), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(textFiled!)
        self.view.addSubview(btn)
    }
    
    func save() {
        self.delegate?.getTextValue((self.textFiled?.text)!)
        self.dismissViewControllerAnimated(true, completion: nil)
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
