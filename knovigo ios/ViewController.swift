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
        let camera = GMSCameraPosition.camera(withLatitude: mapLocation.coordinates.latitude, longitude: mapLocation.coordinates.longitude, zoom: 14.5)
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
            marker.isFlat = true //make sure the orientation of marker depends on phone
            
            //stylying the marker
            marker.icon = GMSMarker.markerImage(with: .blue)
            
            marker.map = self.mapView
        }
    }
    
    //function that manages tapped markers
    //FIXME: function does not react at all; supposedly would if Google pin/marker is tapped
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("\n\n\ntippity tap\n\n\n")
        print(marker)
//        markerTappedHandler?(marker)
        return true
    }
 
    //FIXME: make a working connection from location pg to landing pg
//    @IBAction func unwindToLandingPG(unwindSegue: UIStoryboardSegue){
//        print("function called")
//    }
    
}
