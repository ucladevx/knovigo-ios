//
//  ViewController.swift
//  knovigo ios
//
//  Created by Katie Chang on 2020/11/15.
//  Copyright © 2020 Katie Chang. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

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
      
//         let marker = GMSMarker()
//         marker.position = CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437)
//         marker.title = "Los Angeles"
//         marker.snippet = "California"
//         marker.map = mapView  
//         makeBackground();
      
        makeSearchButton();
        userReportButton();

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
   
     // Present the Autocomplete view controller when the button is pressed.
    @objc func autocompleteClicked(_ sender: UIButton) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self

        // Specify the place data types to return.
        let fields: GMSPlaceField = [.name, .placeID]
        autocompleteController.placeFields = fields

        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        filter.countries = ["BR"]
        autocompleteController.autocompleteFilter = filter

        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
      }

    func makeBackground() {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height

        let xPos = 0
        let yPos = 470

        let rectWidth = Int(screenWidth)

        let rectHeight = Int(screenHeight) - 450

        let rectFrame: CGRect = CGRect(x:CGFloat(xPos), y:CGFloat(yPos), width:CGFloat(rectWidth), height:CGFloat(rectHeight))

        let rectView = UIView(frame: rectFrame)

        rectView.backgroundColor = UIColor.white

        self.view.addSubview(rectView)

    }
     // Add a button to the view.
     func makeSearchButton() {
        let btnLaunchAc = UIButton(frame: CGRect(x: 50, y: 800, width: 200, height: 35))
       btnLaunchAc.backgroundColor = #colorLiteral(red: 0.809851794, green: 0.809851794, blue: 0.809851794, alpha: 1)
       btnLaunchAc.setTitle("Search", for: .normal)
       btnLaunchAc.addTarget(self, action: #selector(autocompleteClicked), for: .touchUpInside)
       self.view.addSubview(btnLaunchAc)
     }

    //add user report button
    @IBOutlet weak var ReportButton: UIButton!
    func userReportButton() {
//        let reportBtn = UIButton(type: .custom)
            ReportButton.frame = CGRect(x: 250, y: 800, width: 40, height: 40)
            ReportButton.layer.cornerRadius = 0.5 * ReportButton.bounds.size.width
            ReportButton.backgroundColor = UIColor(red: 175/255, green: 209/255, blue: 154/255, alpha: 1.0) /* #afd19a */

            ReportButton.clipsToBounds = true
            ReportButton.setImage(UIImage(named:"reportIcon"), for: .normal)
            ReportButton.addTarget(self, action: #selector(userReportButtonPressed), for: .touchUpInside)
            view.addSubview(ReportButton)

    }

    @objc func userReportButtonPressed() {
        self.performSegue(withIdentifier: "Report", sender: self)
    }

   }

   extension ViewController: GMSAutocompleteViewControllerDelegate {

     // Handle the user's selection.
     func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
       print("Place name: \(place.name ?? "none")")
       print("Place ID: \(place.placeID ?? "none")")
        print("Place attributions: \(place.attributions?.string ?? "none")")
       dismiss(animated: true, completion: nil)
     }

    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
      }

      // User canceled the operation.
      func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
      }

      // Turn the network activity indicator on and off again.
      func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
      }

      func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
      }
   }
