//
//  MediaSearchResult.swift
//  RxCocoaHeads
//
//  Created by Travis Smith on 3/24/19.
//  Copyright © 2019 Travis Smith. All rights reserved.
//

import Foundation

struct MediaSearchResult: Codable {
    let media: [Media]
    let totalResults: String
    let response: String
    
    enum CodingKeys: String, CodingKey {
        case media = "Search"
        case totalResults
        case response = "Response"
    }
}
