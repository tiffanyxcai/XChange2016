//
//  myMapController.swift
//  Xchange
//
//  Created by Jennifer Lee on 11/12/16.
//  Copyright © 2016 yhacks. All rights reserved.
//

import UIKit
import GoogleMaps

class myMapController: UIViewController, CLLocationManagerDelegate {
    //@IBOutlet weak var viewMap: GMSMapView!
    var viewMap : GMSMapView!
    var locationManager = CLLocationManager()
    var didFindMyLocation = false
   
    override func viewDidLoad() {
        print("00000")
        super.viewDidLoad()
        print("10101")
        let camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(48.857165, longitude: 2.354613, zoom: 8.0)
        viewMap = GMSMapView.mapWithFrame(CGRect.zero, camera: camera)
        viewMap?.myLocationEnabled = true
        viewMap.settings.myLocationButton = true
        viewMap.settings.compassButton = true
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        viewMap.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.New, context: nil)
        
        view = viewMap
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            print("111111")
            viewMap.myLocationEnabled = true
        }
        //        let location = locations.last
        //
        //        let camera = GMSCameraPosition.cameraWithLatitude((location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        //
        //        self.mapView?.animateToCameraPosition(camera)
        //
        //        //Finally stop updating location otherwise it will come again and again in this delegate
        //        self.locationManager.stopUpdatingLocation()
        
    }
    
    override internal func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        print("22222")
        if !didFindMyLocation {
            //unwrap change so we have the actual value
            if let change = change {
                let myLocation: CLLocation = change[NSKeyValueChangeNewKey] as! CLLocation
                viewMap.camera = GMSCameraPosition.cameraWithTarget(myLocation.coordinate, zoom: 10.0)
                didFindMyLocation = true
                viewMap.animateToCameraPosition(viewMap.camera)
            }
        }
    }
    
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


