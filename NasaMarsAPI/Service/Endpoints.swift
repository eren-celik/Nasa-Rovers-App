//
//  Endpoints.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 19.05.2021.
//

import Foundation

struct Endpoint {
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.nasa.gov"
        components.path = "/mars-photos/api/v1/rovers/curiosity/photos"
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
}

extension Endpoint {
    static var rovers: Self {
        return Endpoint(queryItems: [
            URLQueryItem(name: "earth_date", value: "2021-5-1"),
            URLQueryItem(name: "api_key", value: "50reqbOzD2VPIr6r6ofb77netEOwPPCA3Ne730qH")
        ])
    }
}
