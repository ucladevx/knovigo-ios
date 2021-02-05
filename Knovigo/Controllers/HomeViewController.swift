//
//  HomeViewController.swift
//  knovigo ios
//
//  Created by Katie Chang on 2020/11/15.
//  Copyright © 2020 Katie Chang. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class HomeViewController: UIViewController, GMSMapViewDelegate{
    
    @IBOutlet weak var HeatMapView: UIView!
    @IBOutlet weak var map: GMSMapView!
    
    //view load function
    override func viewDidLoad() {
        super.viewDidLoad()
        // set map @UCLA
        //TODO: Map is HARD CODED for now :(; set view to person's location later
        let camera = GMSCameraPosition.camera(withLatitude: mapLocation.coordinates.latitude, longitude: mapLocation.coordinates.longitude, zoom: 14.5)
        map.camera = camera
        
        
        //set markers
        //TODO: Markers are HARD CODED for now :(; change later
        setMarker(markerGeoCoords: markerCoords)
        
        setSearchButton();
        setReportButton();
        
        //style heat map box
        HeatMapView.layer.cornerRadius = 30
        HeatMapView.layer.shadowColor = UIColor.black.cgColor
        HeatMapView.layer.shadowOpacity = 0.5
        HeatMapView.layer.shadowOffset = .zero
        HeatMapView.layer.shadowRadius = 10
        map?.delegate = self
        
    }
    
    struct data {
        var image : UIImage
        var distance : Double
        var isOpen : Bool
        var label: String
        var pin: Double
    }
    // function that takes in an array of location objects and marker them on the map
    func setMarker(markerGeoCoords: [location]){
        var marker: GMSMarker
        for i in markerGeoCoords{
            marker =  GMSMarker(position: i.coordinates)
            marker.title = i.name
            marker.snippet = i.address
            marker.isFlat = true //make sure the orientation of marker depends on phone
            //styling the marker
            marker.map = map
            marker.userData = data(image: i.image, distance: i.distance, isOpen: i.isOpen, label: i.label, pin: i.pinLabel);
            if (i.pinLabel <= 0.20) {
                marker.icon = UIImage(named: "pin-dark-green");
            } else if (i.pinLabel <= 0.40) {
                marker.icon = UIImage(named: "pin-light-green");
            } else if (i.pinLabel <= 0.60) {
                marker.icon = UIImage(named: "pin-yellow");
            } else if (i.pinLabel <= 0.80) {
                marker.icon = UIImage(named: "pin-orange");
            } else {
                marker.icon = UIImage(named: "pin-red");
            }
        }
    }
    
    //function that manages tapped markers
    //FIXME: function does not react at all; supposedly would if Google pin/marker is tapped
    //    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
    //        print("\n\n\ntippity tap\n\n\n")
    //        print(marker)
    ////        markerTappedHandler?(marker)
    //        return true
    //    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let view = Bundle.main.loadNibNamed("CustomPopUp", owner: self, options: nil)![0] as! CustomPopUp
        let frame = CGRect(x: 10, y: 10, width: 350, height: 230)
        view.frame = frame
        view.layer.cornerRadius = 9.0
        view.locTitle.text = marker.title
        view.locAddress.text = marker.snippet
        view.locImg.image = (marker.userData as! data).image
        view.milesAway.text = "\((marker.userData as! data).distance)" + " miles away"
        view.label.text = (marker.userData as! data).label
        if (!(marker.userData as! data).isOpen) {
            view.openClosed.text = "Closed"
            view.openClosed.textColor = UIColor.red
        } else {
            view.openClosed.text = "Open"
            view.openClosed.textColor = UIColor(red: 116/255, green: 178/255, blue: 96/255, alpha: 1.0)
        }
        setSliderInvert(slider: view.densitySlider)
        setSlider(slider: view.distanceSlider)
        setSlider(slider: view.maskSlider)
        return view
    }
    
    //will transition to location view controller once code is finished for that
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker)
    {
        //  let viewController = LocationViewController()
        // self.present(viewController, animated: true, completion: nil)
        print("pressed!")
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
    
    // Set functionality of search button
    @IBOutlet weak var searchBtn: UIButton!
    func setSearchButton() {
        searchBtn.addTarget(self, action: #selector(autocompleteClicked), for: .touchUpInside)
    }
    
    //add user report button
    @IBOutlet weak var ReportButton: UIButton!
    func setReportButton() {
        ReportButton.addTarget(self, action: #selector(userReportButtonPressed), for: .touchUpInside)
        
    }
    
    @objc func userReportButtonPressed() {
        performSegue(withIdentifier: "homeToSearch", sender: self)
    }
    
    
    @IBOutlet weak var heatMapLegend: UIImageView!
    @IBOutlet weak var heatMapSwitch: UISwitch!
    @IBAction func setState(_ sender: Any) {
        if (heatMapSwitch.isOn){
            heatMapLegend.isHidden = false;
        }
        else {
            heatMapLegend.isHidden = true;
        }
    }
    
}

extension HomeViewController: GMSAutocompleteViewControllerDelegate {
    
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
    
    //slider styling functions
    func setSlider(slider:UISlider) {
        let tgl = CAGradientLayer()
        let frame = CGRect(x: 0.0, y: 0.0, width: slider.bounds.width, height: 9.0 )
        tgl.frame = frame
        
        tgl.colors = [UIColor(red: 196/255, green: 13/255, blue: 0/255, alpha: 1.0).cgColor /* #c40d00 */, UIColor(red: 255/255, green: 231/255, blue: 81/255, alpha: 1.0).cgColor /* #ffec21 */, UIColor(red: 80/255, green: 175/255, blue: 114/255, alpha: 1.0).cgColor /* #50af72 */
                      
        ]
        
        tgl.borderWidth = 1.0
        tgl.borderColor = UIColor.white.cgColor
        tgl.cornerRadius = 9.0
        
        tgl.endPoint = CGPoint(x: 1.0, y:  1.0)
        tgl.startPoint = CGPoint(x: 0.0, y:  1.0)
        
        UIGraphicsBeginImageContextWithOptions(tgl.frame.size, false, 0.0)
        tgl.render(in: UIGraphicsGetCurrentContext()!)
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        slider.setMaximumTrackImage(backgroundImage?.resizableImage(withCapInsets:.zero),  for: .normal)
        slider.setMinimumTrackImage(backgroundImage?.resizableImage(withCapInsets:.zero),  for: .normal)
        
        let layerFrame = CGRect(x: 0, y: 0, width: 10.0, height: 10.0)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = CGPath(ellipseIn: layerFrame, transform: nil)
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        
        let thumb = CALayer.init()
        thumb.frame = layerFrame
        thumb.addSublayer(shapeLayer)
        
        UIGraphicsBeginImageContextWithOptions(thumb.frame.size, false, 0.0)
        
        thumb.render(in: UIGraphicsGetCurrentContext()!)
        let thumbImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        slider.setThumbImage(thumbImage, for: .normal)
        slider.setThumbImage(thumbImage, for: .highlighted)
    }
    
    func setSliderInvert(slider:UISlider) {
        let tgl = CAGradientLayer()
        let frame = CGRect(x: 0.0, y: 0.0, width: slider.bounds.width, height: 9.0 )
        tgl.frame = frame
        
        tgl.colors = [UIColor(red: 80/255, green: 175/255, blue: 114/255, alpha: 1.0).cgColor /* #50af72 */, UIColor(red: 255/255, green: 231/255, blue: 81/255, alpha: 1.0).cgColor /* #ffec21 */,  UIColor(red: 196/255, green: 13/255, blue: 0/255, alpha: 1.0).cgColor /* #c40d00 */
        ]
        
        tgl.borderWidth = 1.0
        tgl.borderColor = UIColor.white.cgColor
        tgl.cornerRadius = 9.0
        
        tgl.endPoint = CGPoint(x: 1.0, y:  1.0)
        tgl.startPoint = CGPoint(x: 0.0, y:  1.0)
        
        UIGraphicsBeginImageContextWithOptions(tgl.frame.size, false, 0.0)
        tgl.render(in: UIGraphicsGetCurrentContext()!)
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        slider.setMaximumTrackImage(backgroundImage?.resizableImage(withCapInsets:.zero),  for: .normal)
        slider.setMinimumTrackImage(backgroundImage?.resizableImage(withCapInsets:.zero),  for: .normal)
        
        let layerFrame = CGRect(x: 0, y: 0, width: 10.0, height: 10.0)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = CGPath(ellipseIn: layerFrame, transform: nil)
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        
        let thumb = CALayer.init()
        thumb.frame = layerFrame
        thumb.addSublayer(shapeLayer)
        
        UIGraphicsBeginImageContextWithOptions(thumb.frame.size, false, 0.0)
        
        thumb.render(in: UIGraphicsGetCurrentContext()!)
        let thumbImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        slider.setThumbImage(thumbImage, for: .normal)
        slider.setThumbImage(thumbImage, for: .highlighted)
    }
}
