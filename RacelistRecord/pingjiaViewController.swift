//
//  pingjiaViewController.swift
//  RacelistRecord
//
//  Created by lauda on 16/8/16.
//  Copyright © 2016年 lauda. All rights reserved.
//

import UIKit

class pingjiaViewController: UIViewController {
    
    var rating : String?

    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var ratingStack: UIStackView!
    @IBAction func ratingBtnTapped(sender: UIButton) {
        
        switch sender.tag {
        case 100: rating = "red-1.png"
        case 200: rating = "yellow-1.png"
        case 300: rating = "black-1.png"
        default: break
        }
        
        performSegueWithIdentifier("unwindToDetailView", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置背景图虚化
        let backEffect = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
        backEffect.frame = view.frame
        backImage.addSubview(backEffect)
        
        //将动画设置为0，即进入view,先不可见。
        let scale = CGAffineTransformMakeScale(0, 0)
        let tranlate = CGAffineTransformMakeTranslation(0, 500)
        
        ratingStack.transform = CGAffineTransformConcat(scale, tranlate)
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        //正常的动画效果
//        UIView.animateWithDuration(0.3, animations: {
//            self.ratingStack.transform = CGAffineTransformIdentity
//            }, completion: nil)
        
        //带抖动的动画效果
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
            self.ratingStack.transform = CGAffineTransformIdentity},completion: nil)
  
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
