//
//  ViewController.swift
//  Xchange
//
//  Created by Jennifer Lee on 11/12/16.
//  Copyright © 2016 yhacks. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, CLLocationManagerDelegate {
    //@IBOutlet weak var viewMap: GMSMapView!
    var viewMap : GMSMapView!
    @IBAction func payPressed(sender: AnyObject) {
        
    }
//    //google map var
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
//        let camera = GMSCameraPosition.cameraWithLatitude(-33.86, longitude: 151.20, zoom: 6.0)
//        let mapView = GMSMapView.mapWithFrame(CGRect.zero, camera: camera)
//        mapView.myLocationEnabled = true
//        view = mapView
//        
//        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
//        // Do any additional setup after loading the view, typically from a nib.   
    }

    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print("11111")
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
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

