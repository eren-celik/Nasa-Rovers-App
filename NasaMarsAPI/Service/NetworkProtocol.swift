//
//  NetworkProtocol.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 19.05.2021.
//

import Foundation
import Combine

protocol NetworkProtocol: AnyObject {
    func getDataFromServer<T>(url : URL,
                              dataDecodingType: T.Type,
                              receiveQueue: DispatchQueue) -> AnyPublisher<T, Error> where T: Decodable
    
}

final class NetworkController: NetworkProtocol {
    
    func getDataFromServer<T>(url: URL,
                              dataDecodingType: T.Type,
                              receiveQueue: DispatchQueue) -> AnyPublisher<T, Error> where T : Decodable {
        
        let urlRequest = URLRequest(url: url)
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { (data: Data, response: URLResponse) in
                guard let httpResponse = response as? HTTPURLResponse ,
                      httpResponse.statusCode == 200 else {
                    throw NasaAPIError.invalidResponse
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: receiveQueue)
            .eraseToAnyPublisher()
    }
}
