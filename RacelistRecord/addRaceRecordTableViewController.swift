//
//  addRaceRecordTableViewController.swift
//  RacelistRecord
//
//  Created by lauda on 16/8/15.
//  Copyright © 2016年 lauda. All rights reserved.
//

import UIKit
import CoreData

class addRaceRecordTableViewController: UITableViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var raceRecordAdd:RacelistRecord!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var raceNameTextField: UITextField!
    @IBOutlet weak var raceDateTextField: UITextField!
    @IBOutlet weak var raceTypeTextField: UITextField!
    @IBOutlet weak var raceDistanceTextField: UITextField!
    @IBOutlet weak var raceMoneyTextField: UITextField!
    @IBOutlet weak var raceAddressTextField: UITextField!
    @IBOutlet weak var raceResultTextField: UITextField!
    
    
    
    @IBAction func saveBtnTapped(sender: UIBarButtonItem) {
        
        //实例化托管对象的缓冲区
        let buffer = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
        //新建一个比赛实例对应的托管对象
        let raceRecordEntityDescription = NSEntityDescription.insertNewObjectForEntityForName("RacelistRecord", inManagedObjectContext: buffer!) as! RacelistRecord
        
        raceRecordEntityDescription.raceName = raceNameTextField.text!
        raceRecordEntityDescription.raceDate = raceDateTextField.text!
        raceRecordEntityDescription.raceType = raceTypeTextField.text!
        raceRecordEntityDescription.raceDistance = raceDistanceTextField.text!
        raceRecordEntityDescription.raceMoney = raceMoneyTextField.text
        raceRecordEntityDescription.raceAddress = raceAddressTextField.text!
        raceRecordEntityDescription.raceResult = raceResultTextField.text!
        
        //存储为NSData类型的图片（png格式）
        if let image = imageView.image{
            
//            let salFac = image.size.width > 600 ? 600 / image.size.width : 1
            raceRecordEntityDescription.raceImage = UIImagePNGRepresentation(image)!
        }
        
        //保存数据，有错就打印出来
        do {
            try buffer?.save()
        } catch {
            print(error)
            return
        }
        

        
        performSegueWithIdentifier("unwindToHomeList", sender: sender)
        
        saveRecordToCloud(raceRecordEntityDescription)
        
    }
    
    //保存新添加的餐馆数据到leanCloud端
    func saveRecordToCloud(raceRecord:RacelistRecord) {
        
        //准备一条需要保存的记录
        let record = AVObject(className: "raceRecord")
        record["raceName"] = raceRecord.raceName
        record["raceDate"] = raceRecord.raceDate
        record["raceType"] = raceRecord.raceType
        record["raceDistance"] = raceRecord.raceDistance
//        record["raceImage"] = raceRecord.raceImage
        record["raceMoney"] = raceRecord.raceMoney
        record["raceAddress"] = raceRecord.raceAddress
        record["raceResult"] = raceRecord.raceResult
        
        //图像尺寸重新调整
//        let originImg = UIImage(data: raceRecord.raceImage)
//        let scalingFac = (originImg?.size.width > 1024) ? 1024 / (originImg?.size.width)! : 1.0
//        
//        let scaledImg = UIImage(data: raceRecord.raceImage, scale: scalingFac)!
        
        let originImg = UIImage(data: raceRecord.raceImage)
        let scalingFac = (originImg?.size.width > 1024) ? 1024 / (originImg!.size.width) : 1.0  //图片大于1024的压缩后上传
        let scaledImg = UIImage(data: raceRecord.raceImage, scale: scalingFac)!
        
        //把图象文件转为PNG格式，并用leancloud的file类型保存
        let imgFile = AVFile(name: "\(raceRecord.raceName).jpg", data: UIImagePNGRepresentation(scaledImg))
        record["raceImage"] = imgFile
        
        record.saveInBackgroundWithBlock { (_, e) -> Void in
            if let e = e {
                print(e.localizedDescription)
            } else {
                print("to leancloud保存成功")
            }
        }
        
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .PhotoLibrary
                
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        
        //使用代码进行约束控制
        let leftCons = NSLayoutConstraint(item: imageView, attribute: .Leading, relatedBy: .Equal, toItem: imageView.superview, attribute: .Leading, multiplier: 1, constant: 0)
        let rightCons = NSLayoutConstraint(item: imageView, attribute: .Trailing, relatedBy: .Equal, toItem: imageView.superview, attribute: .Trailing, multiplier: 1, constant: 0)
        let topCons = NSLayoutConstraint(item: imageView, attribute: .Top, relatedBy: .Equal, toItem: imageView.superview, attribute: .Top, multiplier: 1, constant: 0)
        let bottonCons = NSLayoutConstraint(item: imageView, attribute: .Bottom, relatedBy: .Equal, toItem: imageView.superview, attribute: .Bottom, multiplier: 1, constant: 0)
        
        leftCons.active = true
        rightCons.active = true
        topCons.active = true
        bottonCons.active = true
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
