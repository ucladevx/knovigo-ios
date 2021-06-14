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
import GoogleMapsUtils
import CoreLocation

class HomeViewController: UIViewController, GMSMapViewDelegate{
    
    @IBOutlet weak var heatMapView: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    var heatMapLayer : GMUHeatmapTileLayer!
    
    var locationManager: CLLocationManager!
    var markCoords = [location]();
    
    //view load function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locationAuthorizationStatus = CLLocationManager.authorizationStatus()
        if (locationAuthorizationStatus == .denied || locationAuthorizationStatus == .restricted) {
            self.dismiss(animated: false, completion: nil)
            alertLocationAccessNeeded(controller: self);
        }
        
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()

        // set map @UCLA
        let camera = GMSCameraPosition.camera(withLatitude: mapLocation.coordinates.latitude, longitude: mapLocation.coordinates.longitude, zoom: 14.5)
        mapView.camera = camera
        
        //creates the search and report buttons
        setSearchButton();
        setReportButton();
        
        //style heat map box
        heatMapView.layer.cornerRadius = 30
        heatMapView.layer.shadowColor = UIColor.black.cgColor
        heatMapView.layer.shadowOpacity = 0.5
        heatMapView.layer.shadowOffset = .zero
        heatMapView.layer.shadowRadius = 10
        
        heatMapLayer = GMUHeatmapTileLayer()
        
        mapView?.delegate = self
        
        //location manager
        locationManager.startUpdatingLocation()
        var currentLoc: CLLocation!
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
        CLLocationManager.authorizationStatus() == .authorizedAlways) {
            locationManager.startUpdatingLocation()
            currentLoc = locationManager.location
        }
        if (currentLoc == nil) {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
//            self.dismiss(animated: false, completion: nil)
//            alertLocationAccessNeeded();
            currentLoc = CLLocation(latitude: 34.0700, longitude: -118.4398)
        }
        
        let locLat = Float(currentLoc.coordinate.latitude)
        let locLong = Float(currentLoc.coordinate.longitude)
        
        //load data from backend
        loadData(markerGeoCoords: markerCoords, lat: locLat, long: locLong)
        
        //sets the data for the heatmap
        loadHeatmap();
    }
    
    func alertLocationAccessNeeded(controller:UIViewController) {
        let settingsAppURL = URL(string: UIApplication.openSettingsURLString)!
     
         let alert = UIAlertController(
             title: "Need Location Access",
             message: "Location access is required for including the landmark pins. Please allow access and refresh the application for best use!",
            preferredStyle: UIAlertController.Style.alert
         )
     
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Allow Location Access",
                                        style: .cancel,
                                        handler: {(alert) -> Void in
                                        UIApplication.shared.open(settingsAppURL,
                                                                    options: [:],
                                                                    completionHandler: nil)
                                        }))
    
        DispatchQueue.main.async{
             self.present(alert, animated: true, completion: nil)
        }
    }
    
    func loadData(markerGeoCoords: [location], lat: Float, long: Float) {
        let url2 = URL(string: "http://13.52.104.196:8000/places/location/\(lat)/\(long)")
        let task2 = URLSession.shared.dataTask(with: url2!) {(data, response, error) in
            guard let data = data else { return }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
              print("Serialization went wrong")
              return
            }
            guard let object2 = json as? [[String: Any]] else {
              print("Could not read the JSON.")
              return
            }
            for item in object2 {
                var locImage = UIImage(named: "tongva.jpg")
                var locWideImage = UIImage (named: "tongvaWide.jpg")
                for i in markerGeoCoords {
                    if (i.name == (item["name"] as! String)) {
                        locImage = i.image
                        locWideImage = i.wideImage
                    }
                }
                
            let hour = Calendar.current.component(.hour, from: Date())*100
            let weekday = Calendar.current.component(.weekday, from: Date())
            var validHour = false
            var openHour = -1
            var closeHour = -1
            var openString = ""
            var closeString = ""
            let arr = item["businessHours"] as! [[String: Any]]
            let times = arr.first
                switch(weekday) {
                case 1:
                    openString = "sunday_open"
                    closeString = "sunday_close"
                case 2:
                    openString = "monday_open"
                    closeString = "monday_close"
                case 3:
                    openString = "tuesday_open"
                    closeString = "tuesday_close"
                case 4:
                    openString = "wednesday_open"
                    closeString = "wednesday_close"
                case 5:
                    openString = "thursday_open"
                    closeString = "thursday_close"
                case 6:
                    openString = "friday_open"
                    closeString = "friday_close"
                case 7:
                    openString = "saturday_open"
                    closeString = "saturday_close"
                default:
                    break
                }
                if (times?["businessHours"] == nil) {
                    validHour = true;
                }
                if (times?[openString] != nil && times?[closeString] != nil) {
                    openHour = times?[openString] as! Int
                    closeHour = times?[closeString] as! Int
                }
                
                if (closeHour == 0) {
                    closeHour = 2400
                }
                
                if ((openHour != -1 && closeHour != -1) && (hour > openHour) && (hour < closeHour)) {
                    validHour = true
                }
                
                let loc = location(name: item["name"] as! String, coordinates: CLLocationCoordinate2D(latitude: 34.0700, longitude: -118.4398), address: item["address"] as! String, image: locImage!, wideImage: locWideImage!, distance: Double(round(1000*(item["distance"] as! Double))/1000), isOpen: validHour, label: "temp", pinLabel: item["agg_density"] as! Double, sliderMask: item["agg_mask"] as! Double, sliderDistance: item["agg_social"] as! Double, sliderDensity: item["agg_density"] as! Double)
                self.markCoords.append(loc)
            }
            DispatchQueue.main.async {
                self.setMarker(markerGeoCoords: self.markCoords, tempCoords: markerCoords)
            }
        }
        task2.resume()
    }
    
    // function that takes in an array of location objects and marker them on the map
    func setMarker(markerGeoCoords: [location], tempCoords: [location]){
        var marker: GMSMarker
        for i in markerGeoCoords {
            var coords = i.coordinates
            var description = i.label
            for loc in markerCoords {
                if (i.name == loc.name) {
                    coords = loc.coordinates
                    description = loc.label
                }
            }
            marker =  GMSMarker(position: coords)
            marker.title = i.name
            marker.snippet = i.address
            marker.isFlat = true //make sure the orientation of marker depends on phone
            //styling the marker
            marker.map = self.mapView
            marker.accessibilityLabel = i.name
            marker.userData = data(image: i.image, imageWide: i.wideImage, distance: i.distance, isOpen: i.isOpen, label: description, pin: i.pinLabel, sMask: i.sliderMask, sDistance: i.sliderDistance, sDensity: i.sliderDensity);
           
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
        view.densitySlider.value = Float((marker.userData as! data).sDensity)
        setSlider(slider: view.distanceSlider)
        view.distanceSlider.value = Float((marker.userData as! data).sDistance)
        setSlider(slider: view.maskSlider)
        view.maskSlider.value = Float((marker.userData as! data).sMask)
        return view
    }
    
    //will transition to location view controller once code is finished for that
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker)
    {
      //  let viewController = LocationViewController()
        let sb = UIStoryboard(name:"Main",bundle: Bundle.main)
        let locViewController = sb.instantiateViewController(withIdentifier: "LocationPage") as! LocationViewController
        locViewController.locMarker = marker
        present(locViewController, animated: true)
    }
    
    //FIXME: make a working connection from location pg to landing pg
    //    @IBAction func unwindToLandingPG(unwindSegue: UIStoryboardSegue){
    //        print("function called")
    //    }
    
    func loadHeatmap() {
        var list = [GMUWeightedLatLng]()
        
        // Get the data: latitude/longitude positions
        let url = URL(string: "http://13.52.104.196:8000/ladph/heatmap")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
              print("Serialization went wrong")
              return
            }
            guard let object = json as? [[String: Any]] else {
              print("Could not read the JSON.")
              return
            }
            
            for item in object {
              let lat = item["lat"] as! CLLocationDegrees
              let lng = item["lng"] as! CLLocationDegrees
              let int = (item["intensity"] as! NSNumber).floatValue - 30
              let coords = GMUWeightedLatLng(
                coordinate: CLLocationCoordinate2DMake(lat, lng),
                intensity: int
              )
              list.append(coords)
            }
            // Add the latlngs to the heatmap layer.
            self.heatMapLayer.weightedData = list;
        }

        task.resume()
        
        let gradientColors: [UIColor] = [UIColorFromRGB(rgbValue: 0x568EC4),
                                         UIColorFromRGB(rgbValue: 0x61AAFF),
                                         UIColorFromRGB(rgbValue: 0xFFD372),
                                         UIColorFromRGB(rgbValue: 0xE46B6B),
                                         UIColorFromRGB(rgbValue: 0xBA0505)]
        let gradientStartPoints: [NSNumber] = [0.1, 0.3, 0.5, 0.7, 0.9];
        heatMapLayer.gradient = GMUGradient(
          colors: gradientColors,
          startPoints: gradientStartPoints,
          colorMapSize: 256
        )
        heatMapLayer.radius = UInt(50)
    }
    
    //helper function to convert colors for heatmap
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
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
        self.performSegue(withIdentifier: "Report", sender: self)
    }
    
    
    @IBOutlet weak var heatMapLegend: UIImageView!
    @IBOutlet weak var heatMapSwitch: UISwitch!
    var userMoved : Bool!
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool){
        userMoved = gesture
    }
    func mapView(_ mapView: GMSMapView, didChange: GMSCameraPosition){
        if (userMoved ?? true){
            let zoom = mapView.camera.zoom
            if (zoom < 15.5) {
                if (heatMapLayer.map == nil && heatMapSwitch.isOn){
                    turnOnHeatMap()
                }
                heatMapLayer.radius = UInt(50)
            }
            else {
                turnOffHeatMap()
                heatMapSwitch.setOn(false, animated: true)
            }
        }
    }
    
    
    @IBAction func setState(_ sender: Any) {
        if (heatMapSwitch.isOn){
            turnOnHeatMap()
        }
        else {
            turnOffHeatMap()
        }
    }
    // turns off the heatmap
    func turnOffHeatMap () {
        heatMapLegend.isHidden = true
        heatMapLayer.map = nil
    }
    // turns on heatmap
    func turnOnHeatMap () {
        let zoom = mapView.camera.zoom
        if (zoom > 15.5){
            mapView.animate(toZoom: 15)
        }
        heatMapLegend.isHidden = false
        heatMapLayer.map = mapView
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
