//
//  NetworkManager.swift
//  RxCocoaHeads
//
//  Created by Travis Smith on 3/24/19.
//  Copyright © 2019 Travis Smith. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class NetworkManager {
    private let session: URLSession
    private let apiKey: String
    private let decoder = JSONDecoder()
    
    init(apiKey: String) {
        self.session = URLSession.shared
        self.apiKey = apiKey
    }
    
    private func buildURL(withQueryItems queryItems: [URLQueryItem]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "omdbapi.com"
        
        var allQueryItems = queryItems
        allQueryItems.append(URLQueryItem(name: "apikey", value: apiKey))
        components.queryItems = allQueryItems
        
        guard let url = components.url else {
            fatalError("Something has gone terribly wrong when building your URL")
        }
        
        return url
    }
    
    func fetchMedia(withQuery query: String) -> Single<MediaSearchResult> {
        let url = buildURL(withQueryItems: [URLQueryItem(name: "s", value: query)])
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return session.rx.data(request: request)
            .map { data -> MediaSearchResult in
                return try self.decoder.decode(MediaSearchResult.self, from: data)
            }
            .asSingle()
    }
}
