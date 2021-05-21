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
    
    func getRoverPhotos(roverType: RoverNames,
                        endPointType: Endpoint) -> AnyPublisher<RoverPhotosModel, Error>
    
}


final class UsersLogicController: ServiceLayerLogicProtocol {
    
    internal var networkProtocol: NetworkProtocol
    init(networkProtocol : NetworkProtocol) {
        self.networkProtocol = networkProtocol
    }
    
    func getRoverPhotos(roverType: RoverNames,
                        endPointType: Endpoint) -> AnyPublisher<RoverPhotosModel, Error> {
        
        return networkProtocol.getDataFromServer(url: endPointType.url(roverType: roverType),
                                                 dataDecodingType: RoverPhotosModel.self)
    }
    
}
