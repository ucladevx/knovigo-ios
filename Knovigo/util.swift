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
}

let GoogleMapsAPIKey = "AIzaSyDdpsQ_OSZrVjRIeGoXcCXHbuG2pk1rlKI"
let mapLocation = location(name: "UCLA", coordinates: CLLocationCoordinate2D(latitude: 34.0700, longitude: -118.4398), address: "Los Angeles, CA 90095")
let markerCoords = [
    location(name: "Target", coordinates: CLLocationCoordinate2D(latitude: 34.062653, longitude: -118.443939), address: "10861 Weyburn Ave, Los Angeles, CA 90024, United States"),
    location(name: "Trader Joe's", coordinates: CLLocationCoordinate2D(latitude: 34.062210, longitude: -118.443830), address: "1000 Glendon Ave, Los Angeles, CA 90024"),
    location(name: "CVS", coordinates: CLLocationCoordinate2D(latitude: 34.057300, longitude: -118.442500), address: "1001 Westwood Blvd, Los Angeles, CA 90024"),
    location(name: "Whole Foods", coordinates: CLLocationCoordinate2D(latitude: 34.061118, longitude: -118.447282), address: "1050 S, Gayley Ave, Los Angeles, CA 90024"),
    location(name: "Ralph's", coordinates: CLLocationCoordinate2D(latitude: 34.0627169, longitude: -118.4437247), address: "10861 Weyburn Ave, Los Angeles, CA 90024"),
    location(name: "Barney's Beanery", coordinates: CLLocationCoordinate2D(latitude: 34.0617224, longitude: -118.4466561), address: "1037 Broxton Ave, Los Angeles, CA 90024"),
    location(name: "Tongva Steps area", coordinates: CLLocationCoordinate2D(latitude: 34.073998, longitude: -118.4377339), address: "Los Angeles, CA 90095"),
    location(name: "Diddy Riese", coordinates: CLLocationCoordinate2D(latitude: 34.0630614, longitude: -118.4468781), address: "926 Broxton Ave, Los Angeles, CA 90024"),
    location(name: "BJ's Restaurant & Brewhouse", coordinates: CLLocationCoordinate2D(latitude: 34.062940, longitude: -118.447260), address: "939 Broxton Ave, Los Angeles, CA 90024")
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
