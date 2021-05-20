//
//  NasaAPIViewModel.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 19.05.2021.
//

import Foundation
import Combine

enum DataStatus{
    case full
    case empty
    case error
}

final class NasaAPIViewModel : ObservableObject{
    @Published var curiostyDataArray : [Photo] = PhotoArray()
    @Published var opportunityDataArray : [Photo] = PhotoArray()
    @Published var spiritDataArray : [Photo] = PhotoArray()
    
    @Published var selectedDate : String = ""
    @Published var dataStatus : DataStatus = .full
    
    private let serviceLayer = UsersLogicController(networkProtocol: NetworkController())
    private var cancellable = Set<AnyCancellable>()
    
}

extension NasaAPIViewModel {
    
    func getCuriosityRoverData(endPointType: Endpoint){
        serviceLayer.getRoverPhotos(roverType: .curiosity,
                                    endPointType: endPointType)
            .sink { status in
                switch status{
                case .finished:
                    break
                case .failure(let error):
                    self.dataStatus = .error
                    #if DEBUG
                    print(error.localizedDescription)
                    #endif
                }
            } receiveValue: { [weak self] value in
                if value.photos.isEmpty{
                    self?.dataStatus = .empty
                }else{
                    self?.curiostyDataArray = value.photos
                }
            }
            .store(in: &cancellable)
    }
    
    func getOpportunityRoverData(endPointType: Endpoint){
        serviceLayer.getRoverPhotos(roverType: .opportunity,
                                    endPointType: endPointType)
            .sink { status in
                switch status{
                case .finished:
                    break
                case .failure(let error):
                    self.dataStatus = .error
                    #if DEBUG
                    print(error.localizedDescription)
                    #endif
                }
            } receiveValue: { [weak self] value in
                if value.photos.isEmpty{
                    self?.dataStatus = .empty
                }else{
                    self?.opportunityDataArray = value.photos
                }
            }
            .store(in: &cancellable)
    }
    
    func getSpiritRoverData(endPointType: Endpoint) {
        serviceLayer.getRoverPhotos(roverType: .spirit,
                                    endPointType: endPointType)
            .sink { status in
                switch status{
                case .finished:
                    break
                case .failure(let error):
                    self.dataStatus = .error
                    #if DEBUG
                    print(error.localizedDescription)
                    #endif
                }
            } receiveValue: { [weak self] value in
                if value.photos.isEmpty{
                    self?.dataStatus = .empty
                }else{
                    self?.spiritDataArray = value.photos
                }
            }
            .store(in: &cancellable)
    }
}
