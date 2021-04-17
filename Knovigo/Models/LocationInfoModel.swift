//
//  LocationInfoModel.swift
//  Knovigo
//
//  Created by Abhishek Marda on 12/25/20.
//

import UIKit.UIImage

struct LocationInfo
{
    init(name nm : String, address add : String, distancing dist : Int, density dsty : Int, maskWearing msk : Int, image img : UIImage?, priceRange prc : PriceRange, tags tgs : [String], distance range: Double) {
        name = nm
        address = add
        distancing = dist
        density = dsty
        maskWearing = msk
        profileImage = img
        price = prc
        tags = tgs
        distance = range
    }
    let name : String
    let address : String
    let distancing : Int
    let density : Int
    let maskWearing : Int
    let profileImage : UIImage?
    let price : PriceRange
    let tags : [String]
    let distance : Double
    // let rating : Int
//    var coordinates: CLLocationCoordinate2D
    
    // bools for checkboxes
    // business hours
    // popular times
    
}
