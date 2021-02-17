//
//  ReportDataModel.swift
//  Knovigo
//
//  Created by Abhishek Marda on 2/17/21.
//

import Foundation

/// Contains data that will be sent to Django endpoint to post a new user report
struct ReportDataModel: Codable {
    let name : String
    let start, end : Date
    let density, social_distancing, mask, covid : Int
    let masks_req, staff_masks_req, plexiglass_req, line_req, capacity_limit_req, takeout_avlbl, dinein_avlbl, outdoor_seats_avlbl, social_dist_req, bathroom_avlbl, wifi_avlbl, outlets_avlbl : Bool
    let covid_notes : String
    let other_comments : String
}

/// Data representing the response value we get from the post request
struct Response : Decodable {
    let success : Bool
    let reason : String?
}
