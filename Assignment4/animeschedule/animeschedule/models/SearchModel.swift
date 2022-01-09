//
//  SearchModel.swift
//  animeschedule
//
//  Created by Christine Ebeo on 2021-12-29.
//

import Foundation

struct SearchResults : Codable {
    public var results : [SearchResultInfo]
}

struct SearchResultInfo : Codable {
    var mal_id : Int
    var url : String
    var image_url : String
    var title : String
    var airing : Bool
    var synopsis : String
    var score : Double
    
}
