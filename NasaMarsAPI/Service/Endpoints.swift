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

//URL Body
extension Endpoint {
    func url(roverType: RoverNames) -> URL{
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.nasa.gov"
        components.path = "/mars-photos/api/v1/rovers/\(roverType)/photos"
        components.queryItems = queryItems
        
        guard let url = components.url else {
            fatalError("Invalid URL Components: \(components)")
        }
        return url
        
    }
}

//Query Parameters
extension Endpoint {
    
    func getByEarthDate(page: Int) -> Self {
        return Endpoint(queryItems: [
            URLQueryItem(name: "earth_date", value: "2021-5-1"),
            URLQueryItem(name: "api_key", value: "50reqbOzD2VPIr6r6ofb77netEOwPPCA3Ne730qH"),
            URLQueryItem(name: "page", value: "\(page)")
        ])
    }
    
    func getBySolDay(solDay : Int, page: Int) -> Self {
        return Endpoint(queryItems: [
            URLQueryItem(name: "sol", value: "\(solDay)"),
            URLQueryItem(name: "api_key", value: "50reqbOzD2VPIr6r6ofb77netEOwPPCA3Ne730qH"),
            URLQueryItem(name: "page", value: "\(page)")
        ])
    }
}
