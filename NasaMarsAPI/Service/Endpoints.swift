//
//  Endpoints.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 19.05.2021.
//

import Foundation

/// URL Body
struct Endpoint {
    var queryItems: [URLQueryItem] = []
    static let shared = Endpoint()
}

extension Endpoint {
    /// Receives generic type data  from Nasa Server using Combine
    /// - Parameter roverType: Nasa Rovers.
    /// - Returns: Returns  Full base URL (api.nasa.gov/mars-photos/api/v1/rovers)
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
    /// Gives photos according to the earth date
    /// - Parameter earthDate: Standart Earth Date.
    /// - Parameter page: Values Count. Per page gives a 25 value.
    /// - Parameter camera: Rover Camera Position. Default value gives all.
    /// - Returns: Returns Earth date type  URL.
    func getByEarthDate(earthDate: String, page: Int, camera: CameraName) -> Self {
        return Endpoint(queryItems: [
            URLQueryItem(name: "earth_date", value: earthDate),
            URLQueryItem(name: "api_key", value: "50reqbOzD2VPIr6r6ofb77netEOwPPCA3Ne730qH"),
            URLQueryItem(name: "page", value: "\(page)"),
            camera != .all ? URLQueryItem(name: "camera", value: "\(camera)") : URLQueryItem(name: "", value: "")
        ])
    }
    /// Gives photos according to the sol day
    /// - Parameter solDay: Mars Day.
    /// - Parameter page: Values Count. Per page gives a 25 value
    /// - Parameter camera: Rover Camera Position. Default value gives all
    /// - Returns: Returns Mars date type Url.
    func getBySolDay(solDay : Int, page: Int, camera: CameraName) -> Self {
        return Endpoint(queryItems: [
            URLQueryItem(name: "sol", value: "\(solDay)"),
            URLQueryItem(name: "api_key", value: "50reqbOzD2VPIr6r6ofb77netEOwPPCA3Ne730qH"),
            URLQueryItem(name: "page", value: "\(page)"),
            camera != .all ? URLQueryItem(name: "camera", value: "\(camera)") : URLQueryItem(name: "", value: "")
        ])
    }
}
