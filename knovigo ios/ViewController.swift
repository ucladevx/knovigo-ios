//
//  ViewController.swift
//  knovigo ios
//
//  Created by Katie Chang on 2020/11/15.
//  Copyright © 2020 Katie Chang. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, GMSMapViewDelegate {
    
    var mapView: GMSMapView?
    
    //view load function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set map @UCLA
        //TODO: Map is HARD CODED for now :(; set view to person's location later
        let camera = GMSCameraPosition.camera(withLatitude: 34.0700, longitude: -118.4398, zoom: 20.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        //set markers
        //TODO: Markers are HARD CODED for now :(; change later
        setMarker(markerGeoCoords: markerCoords)

    }
    
    // function that takes in an array of location objects and marker them on the map
    func setMarker(markerGeoCoords: [location]){
        var marker: GMSMarker
        for i in markerGeoCoords{
            marker =  GMSMarker(position: i.coordinates)
            marker.title = i.name
            marker.map = self.mapView
        }
    }
    
    //function that manages tapped markers
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("\n\n\ntippity tap\n\n\n")
        return true
    }
    
}
