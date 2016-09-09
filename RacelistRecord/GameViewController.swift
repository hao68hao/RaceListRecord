//
//  GameViewController.swift
//  RacelistRecord
//
//  Created by lauda on 16/8/29.
//  Copyright © 2016年 lauda. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, protocolVCDelegate {
    
    var timer : NSTimer?
    var picNum = 0

    @IBOutlet weak var btnstyle: UIButton!
    @IBOutlet weak var closureTextField: UITextField!
    @IBOutlet weak var protocolTextFiled: UITextField!
    @IBOutlet weak var notificationTextField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func closureBtnTapped(sender: UIButton) {
    }
    
    @IBAction func protocolBtnTapped(sender: UIButton) {
        let protocolVC = protocolViewContorller()
        protocolVC.title = "协议传值"
        protocolVC.delegate = self
        self.presentViewController(protocolVC, animated: true, completion:
            nil)
    }
    
    func getTextValue(title: String) {
        self.protocolTextFiled.text = title
    }
    
//    @IBAction func notificationBtnTapped(sender: UIButton) {
//    }
    
    @IBAction func backBtn(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnstyle.setTitle("返回关于", forState: .Normal)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(GameViewController.changePic), userInfo: nil, repeats: true)
    
    }
    
    func changePic() {
        picNum += 1
        if picNum > 9 {
            picNum = 1
        }
        let changePicName = UIImage(named: "\(picNum).jpg")
        imageView.image = changePicName
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
