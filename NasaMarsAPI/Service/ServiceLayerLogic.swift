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
    
    func getRoverPhotosByEarthDate() -> AnyPublisher<RoverPhotosModel, Error>
    
}


final class UsersLogicController: ServiceLayerLogicProtocol {
    
    internal var networkProtocol: NetworkProtocol
    
    init(networkProtocol : NetworkProtocol) {
        self.networkProtocol = networkProtocol
    }
    
    func getRoverPhotosByEarthDate() -> AnyPublisher<RoverPhotosModel, Error> {
        let endpoint = Endpoint().getByEarthDate(page: 1)
        return networkProtocol.getDataFromServer(url: endpoint.url(roverType: .curiosity),
                                                 dataDecodingType: RoverPhotosModel.self,
                                                 receiveQueue: .main)
    }
}
