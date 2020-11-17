//
//  ViewController.swift
//  knovigo ios
//
//  Created by Katie Chang on 2020/11/15.
//  Copyright © 2020 Katie Chang. All rights reserved.
//

import UIKit
import GoogleMaps

class location: NSObject {
    let name: String
    let location: CLLocationCoordinate2D
    let zoom: Float
    
    init(name: String, location: CLLocationCoordinate2D, zoom: Float) {
        self.name = name
        self.location = location
        self.zoom =  zoom
    }
}

class ViewController: UIViewController {
    
    var mapView: GMSMapView?
//    var currentLocation: currentLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: 34.0522, longitude: -118.2437, zoom: 8.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
    }


}

