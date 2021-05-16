//
//  util.swift
//  knovigo ios
//
//  Created by Katie Chang on 2020/12/15.
//  Copyright © 2020 Katie Chang. All rights reserved.
//
import GoogleMaps

struct location {
    var name: String
    var coordinates: CLLocationCoordinate2D
    var address: String
    var image: UIImage
    var wideImage: UIImage
    var distance: Double
    var isOpen: Bool
    var label: String
    var pinLabel: Double
    var sliderMask : Double
    var sliderDistance : Double
    var sliderDensity: Double
}

struct data {
    var image : UIImage
    var imageWide: UIImage
    var distance : Double
    var isOpen : Bool
    var label: String
    var pin: Double
    var sMask : Double
    var sDistance : Double
    var sDensity: Double
}
let GoogleMapsAPIKey = "AIzaSyDXBl8VMXv_Ok0pd6EcUt_Pti83hbM7gf4"
let mapLocation = location(name: "UCLA", coordinates: CLLocationCoordinate2D(latitude: 34.0700, longitude: -118.4398), address: "Los Angeles, CA 90095", image: UIImage(named: "tongva.jpg")!, wideImage: UIImage(named: "tongvaWide.jpg")!, distance: 0, isOpen: true, label: "University", pinLabel: 0.25, sliderMask: 1, sliderDistance: 1, sliderDensity: 0)
var markerCoords = [
    location(name: "Target", coordinates: CLLocationCoordinate2D(latitude: 34.062653, longitude: -118.443939), address: "10861 Weyburn Ave, Los Angeles, CA 90024, United States", image: UIImage(named: "target.jpg")!, wideImage: UIImage(named: "targetWide.jpg")!, distance: 3.4, isOpen: true, label: "Department Store", pinLabel: 0.65, sliderMask: 0.2, sliderDistance: 0.3, sliderDensity: 1),
    location(name: "Trader Joe's", coordinates: CLLocationCoordinate2D(latitude: 34.062210, longitude: -118.443830), address: "1000 Glendon Ave, Los Angeles, CA 90024", image: UIImage(named: "traderjoes.jpg")!, wideImage: UIImage(named: "traderjoeswide.jpg")!, distance: 2.8, isOpen: false, label: "Grocery Store", pinLabel: 0.85, sliderMask: 0.6, sliderDistance: 0.9, sliderDensity: 0.4),
    location(name: "CVS", coordinates: CLLocationCoordinate2D(latitude: 34.057300, longitude: -118.442500), address: "1001 Westwood Blvd, Los Angeles, CA 90024", image: UIImage(named: "cvs.jpg")!, wideImage: UIImage(named: "cvsWide.jpg")!,distance: 7.9, isOpen: true, label: "Drug Store", pinLabel: 0.15, sliderMask: 0.2, sliderDistance: 0.8, sliderDensity: 0.4),
    location(name: "Whole Foods Market", coordinates: CLLocationCoordinate2D(latitude: 34.061118, longitude: -118.447282), address: "1050 S, Gayley Ave, Los Angeles, CA 90024", image: UIImage(named: "wholefoods.jpg")!, wideImage: UIImage(named: "wholeFoodsWide.jpg")!, distance: 3.8, isOpen: false, label: "Grocery Store", pinLabel: 0.95, sliderMask: 0.5, sliderDistance: 0.2, sliderDensity: 0.7),
    location(name: "Ralphs", coordinates: CLLocationCoordinate2D(latitude: 34.0627169, longitude: -118.4437247), address: "10861 Weyburn Ave, Los Angeles, CA 90024", image: UIImage(named: "ralphs.jpg")!, wideImage: UIImage(named: "ralphsWide.jpg")!, distance: 2.3, isOpen: true, label: "Grocery Store", pinLabel: 0.30, sliderMask: 0.4, sliderDistance: 0.2, sliderDensity: 1),
    location(name: "Barney's Beanery Westwood", coordinates: CLLocationCoordinate2D(latitude: 34.0617224, longitude: -118.4466561), address: "1037 Broxton Ave, Los Angeles, CA 90024", image: UIImage(named: "barneys.jpg")!, wideImage: UIImage(named: "barneysWide.jpg")!, distance: 5.4, isOpen: false, label: "Restaurant", pinLabel: 0.25, sliderMask: 0.3, sliderDistance: 1, sliderDensity: 0.4),
    location(name: "Tongva Steps area", coordinates: CLLocationCoordinate2D(latitude: 34.073998, longitude: -118.4377339), address: "Los Angeles, CA 90095", image: UIImage(named: "tongva.jpg")!, wideImage: UIImage(named: "tongvaWide.jpg")!, distance: 2.6, isOpen: true, label: "UCLA", pinLabel: 0.10, sliderMask: 0.3, sliderDistance: 1, sliderDensity: 0.4),
    location(name: "Diddy Riese", coordinates: CLLocationCoordinate2D(latitude: 34.0630614, longitude: -118.4468781), address: "926 Broxton Ave, Los Angeles, CA 90024", image: UIImage(named: "diddy.jpg")!, wideImage: UIImage(named: "diddyWide.jpg")!, distance: 7.1, isOpen: true, label: "Bakery", pinLabel: 0.60, sliderMask: 0.8, sliderDistance: 0.3, sliderDensity: 0.4),
    location(name: "BJ's Restaurant & Brewhouse", coordinates: CLLocationCoordinate2D(latitude: 34.062940, longitude: -118.447260), address: "939 Broxton Ave, Los Angeles, CA 90024", image: UIImage(named: "bjs.jpg")!, wideImage: UIImage(named: "bjsWide.jpg")!, distance: 8.4, isOpen: false, label: "Restaurant", pinLabel: 0.75, sliderMask: 0.2, sliderDistance: 1, sliderDensity: 0.8)
]

struct tag {
    var name: String
    var isImplemented: Bool
}

var protocolTags = [
    tag(name: "Masks Reqiured", isImplemented: true),
    tag(name: "Outlets Available", isImplemented: false),
    tag(name: "Dine-In", isImplemented: false),
    tag(name: "Staff Wears Masks", isImplemented: true),
    tag(name: "Plexiglass at Cashier", isImplemented: true),
    tag(name: "Bathroom Open", isImplemented: true),
    tag(name: "Takeout", isImplemented: false),
    tag(name: "Wifi Provided", isImplemented: true),
    tag(name: "Limited Capacity", isImplemented: true),
    tag(name: "Line Outside", isImplemented: true),
    tag(name: "Outdoor Seating", isImplemented: false)
]
