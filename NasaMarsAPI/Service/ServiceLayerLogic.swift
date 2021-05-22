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
    
    /// Receives generic type data  from Nasa Server using Combine
    /// - Parameter roverType: Nasa Rovers.
    /// - Parameter endPointType: Returns which endpoint to receive data(eg. : Get data by Earth day or Mars(Sol)  day )
    /// - Returns: Returns  AnyPublisher<RoverPhotosModel, Error>.
    func getRoverPhotos(roverType: RoverNames,
                        endPointType: Endpoint) -> AnyPublisher<RoverPhotosModel, Error>
    
}


final class ServicePhotoLogicController: ServiceLayerLogicProtocol {
    
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
