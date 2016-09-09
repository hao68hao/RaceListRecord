//
//  WeatherViewController.swift
//  RacelistRecord
//
//  Created by lauda on 16/9/1.
//  Copyright © 2016年 lauda. All rights reserved.
//

import UIKit

struct Weather {
    var 城市 : String?
    var 天气 : String?
    var 温度 : String?
}

class WeatherViewController: UIViewController {
    
    let 城市标签 = UILabel()
    let 天气标签 = UILabel()
    let 温度标签 = UILabel()
    let backImageview = UIImageView()
    
    //增加一个计算属性，一旦界面发生变化，就更新VIEW
    var weatherData : Weather? {
        //属性监视器
        didSet {
            configView()
        }
    }
    
    //配置视图的方法
    func configView() {
        城市标签.text = self.weatherData?.城市
        天气标签.text = self.weatherData?.天气
        温度标签.text = self.weatherData?.温度
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //城市标签
        城市标签.frame = CGRectMake(70, 100, 300, 30)
//        城市标签.text = "城市：\(weatherData?.城市)"
        城市标签.textColor = UIColor.blackColor()
        self.view.addSubview(城市标签)
        
        //天气标签
        天气标签.frame = CGRectMake(70, 200, 300, 30)
//        天气标签.text = "天气：\(weatherData?.天气)"
        天气标签.textColor = UIColor.blackColor()
        self.view.addSubview(天气标签)
        
        //温度标签
        温度标签.frame = CGRectMake(70, 300, 300, 30)
//        温度标签.text = "温度：\(weatherData?.温度)"
        温度标签.textColor = UIColor.blackColor()
        self.view.addSubview(温度标签)
        
        //设置背景图片
        backImageview.image = UIImage(named: "wallpaper")
        backImageview.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
        self.view.addSubview(backImageview)
        
        let backBtn = UIButton()
        backBtn.frame = CGRectMake(70, 400, 40, 40)
        backBtn.setImage(UIImage(named: "black-1"), forState: .Normal)
        self.view.addSubview(backBtn)
        backBtn.addTarget(self, action: #selector(WeatherViewController.getBackAboutView), forControlEvents: .TouchUpInside)
        
        getWeatherData()


    }
    
    func getBackAboutView() {
        
        let mainStory = UIStoryboard(name: "Main", bundle: nil)
        let pageVC = mainStory.instantiateViewControllerWithIdentifier("aboutSB") as! aboutTableViewController
        self.presentViewController(pageVC, animated: true, completion: nil)
        
    }

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getWeatherData() {
        //资源获取-网址获取
        let url = NSURL(string: "http://api.k780.com:88/?app=weather.future&weaid=1&&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json")
        
        //会话配置
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        //配置连接超时时间
        config.timeoutIntervalForRequest = 10
        
        //建立会话
        let session = NSURLSession(configuration: config)
        
        //会话任务
        let task = session.dataTaskWithURL(url!) { (data, _, error) -> Void in
            
            //如果连接没有错误，则处理数据
            do {
                
                //将json数据强制转换为字典类型，
                if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments) as? NSDictionary {
                    print(jsonResult)
                    
                    //从json中序列化的数据中，获取键值是“result”的数据，然后再进行内容映射一一对应到需要的键值中
                    let weather = (jsonResult.valueForKey("result") as? NSDictionary).map({
                        
                        Weather(城市: $0["citynm"] as? String,
                            天气: $0["weather"] as? String,
                            温度: $0["temperature_curr"] as? String)
                        
                    })
                    
                    
                    //界面更新放到主线程中
                    dispatch_async(dispatch_get_main_queue(), {
                        self.weatherData = weather
                    })
                    
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }

        }
        
        //执行任务
        task.resume()
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
