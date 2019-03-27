//
//  Media.swift
//  RxCocoaHeads
//
//  Created by Travis Smith on 3/24/19.
//  Copyright © 2019 Travis Smith. All rights reserved.
//

import Foundation

struct Media: Codable {
    let imdbID: String
    let title: String
    let year: String
    let type: String
    let poster: URL
    
    enum CodingKeys: String, CodingKey {
        case imdbID
        case title = "Title"
        case year = "Year"
        case type = "Type"
        case poster = "Poster"
    }
}
