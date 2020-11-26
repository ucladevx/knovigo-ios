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
                
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437)
        marker.title = "Los Angeles"
        marker.snippet = "California"
        marker.map = mapView
        
        makeBackground();
        makeSearchButton();
        userReportButton();
    }
    
   
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
        let btnLaunchAc = UIButton(frame: CGRect(x: 20, y: 500, width: 200, height: 35))
       btnLaunchAc.backgroundColor = #colorLiteral(red: 0.809851794, green: 0.809851794, blue: 0.809851794, alpha: 1)
       btnLaunchAc.setTitle("Search", for: .normal)
       btnLaunchAc.addTarget(self, action: #selector(autocompleteClicked), for: .touchUpInside)
       self.view.addSubview(btnLaunchAc)
     }

    //add user report button
    func userReportButton() {
        let reportBtn = UIButton(type: .custom)
            reportBtn.frame = CGRect(x: 250, y: 500, width: 40, height: 40)
            reportBtn.layer.cornerRadius = 0.5 * reportBtn.bounds.size.width
            reportBtn.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            reportBtn.clipsToBounds = true
            reportBtn.setImage(UIImage(named:"thumbsUp.png"), for: .normal)
            reportBtn.addTarget(self, action: #selector(userReportButtonPressed), for: .touchUpInside)
            view.addSubview(reportBtn)

    }

    @objc func userReportButtonPressed() {
        print("thumbs up button pressed")
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


