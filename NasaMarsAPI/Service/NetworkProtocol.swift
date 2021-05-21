//
//  NetworkProtocol.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 19.05.2021.
//

import Foundation
import Combine

protocol NetworkProtocol: AnyObject {
    /// Receives generic type data  from Nasa Server using Combine
    /// - Parameter url: Base Nasa Url.
    /// - Parameter dataDecodingType: Generic decoding data type
    /// - Returns: Returns  AnyPublisher<T, Error>.
    func getDataFromServer<T>(url : URL,
                              dataDecodingType: T.Type) -> AnyPublisher<T, Error> where T: Decodable
    
}

final class NetworkController: NetworkProtocol {
    
    func getDataFromServer<T>(url: URL,
                              dataDecodingType: T.Type) -> AnyPublisher<T, Error> where T : Decodable {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethods.get.rawValue
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { (data: Data, response: URLResponse) in
                guard let httpResponse = response as? HTTPURLResponse ,
                      httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299 else {
                    throw NasaAPIError.invalidResponse
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
