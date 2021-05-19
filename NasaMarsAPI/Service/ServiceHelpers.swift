//
//  ServiceHelpers.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 19.05.2021.
//

import Foundation

public enum HTTPMethods: String {
    case get = "GET"
}

public enum NasaAPIError: Error {
    case invalidResponse
    case invalidData
    case jsonParsingFailure
    
    var localizedDescription: String {
        switch self {
        case .invalidResponse:
            return "Something went wrong: Invalid Response"
        case .invalidData:
            return "Something went wrong: Invalid Data"
        case .jsonParsingFailure:
            return "Something went wrong: JSON Parsing Failure"
        }
    }
}

