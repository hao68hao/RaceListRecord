//
//  mapViewController.swift
//  RacelistRecord
//
//  Created by lauda on 16/8/15.
//  Copyright © 2016年 lauda. All rights reserved.
//

import UIKit
import MapKit

class mapViewController: UIViewController, MKMapViewDelegate {
    
    var raceListMap:RacelistRecord!

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //显示地图的相关信息
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.showsTraffic = true
        mapView.showsBuildings = true

        let geocode = CLGeocoder()
        geocode.geocodeAddressString(raceListMap.raceAddress){ (placemarks, error) -> Void in
            if error != nil{
                print(error)
                return
            }
            
            if let placmarkAccess = placemarks{
                let placmarkTrue = placmarkAccess[0]
                
                let anntation = MKPointAnnotation()
                anntation.title = self.raceListMap.raceName
                anntation.subtitle = self.raceListMap.raceType
                
                if let location = placmarkTrue.location{
                    anntation.coordinate = location.coordinate
                }
                
                self.mapView.showAnnotations([anntation], animated: true)
                self.mapView.selectAnnotation(anntation, animated: true)
            }
            
            
        }
        
    }
    
    //显示地理位置的图片
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let id = "我的图订"
        
        if annotation is MKUserLocation {
            return nil
        }
        
        var annotationView = self.mapView.dequeueReusableAnnotationViewWithIdentifier(id) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: id)
            annotationView?.canShowCallout = true
        }
        
        let imageView = UIImageView(frame: CGRectMake(0, 0, 53, 53))
        imageView.image = UIImage(data: raceListMap.raceImage)
        
        annotationView?.leftCalloutAccessoryView = imageView
        annotationView?.pinTintColor = UIColor.greenColor()
        
        return annotationView
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
