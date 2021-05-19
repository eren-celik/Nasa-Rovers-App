//
//  ServiceLayer.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 19.05.2021.
//

import Foundation
import Combine



protocol ServiceLayerLogicProtocol: AnyObject {
    
    var networkProtocol: NetworkProtocol { get }
    
    func getRoverPhotos() -> AnyPublisher<RoverPhotosModel, Error>
    
}


final class UsersLogicController: ServiceLayerLogicProtocol {
    
    internal var networkProtocol: NetworkProtocol
    
    init(networkProtocol : NetworkProtocol) {
        self.networkProtocol = networkProtocol
    }
    
    func getRoverPhotos() -> AnyPublisher<RoverPhotosModel, Error> {
        let endpoint = Endpoint.rovers
        return networkProtocol.getDataFromServer(url: endpoint.url,
                                                 dataDecodingType: RoverPhotosModel.self,
                                                 receiveQueue: .main)
    }
}
