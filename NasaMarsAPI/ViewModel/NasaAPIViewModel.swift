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
    case loading
}

final class NasaAPIViewModel : ObservableObject{
    @Published var curiostyDataArray    : [Photo] = PhotoArray()
    @Published var opportunityDataArray : [Photo] = PhotoArray()
    @Published var spiritDataArray      : [Photo] = PhotoArray()
    
    @Published var photoDetailData : Photo?
    
    @Published var selectedEarthDate : String = ""
    @Published var selectedMarsDate : Int?
    @Published var selectedPage : ViewsNames?
    
    @Published var dataStatus : DataStatus = .full
    
    private let serviceLayer = UsersLogicController(networkProtocol: NetworkController())
    private var cancellable = Set<AnyCancellable>()
    let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    init() {
        selectedEarthDate = dateFormatter.string(from: Date().threeDayBefore)
    }
    
}
extension NasaAPIViewModel{
    private func onRecive( _ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            self.dataStatus = .error
            #if DEBUG
            print(error.localizedDescription)
            #endif
        }
    }
}

extension NasaAPIViewModel {
    
    func getCuriosityRoverData(endPointType: Endpoint) {
        dataStatus = .loading
        serviceLayer.getRoverPhotos(roverType: .curiosity,
                                    endPointType: endPointType)
            .sink (receiveCompletion: onRecive(_:),
                   receiveValue: { [weak self] value in
                    if value.photos.isEmpty{
                        self?.dataStatus = .empty
                    }else{
                        self?.curiostyDataArray = value.photos
                        self?.dataStatus = .full
                    }
                   }
            )
            .store(in: &cancellable)
    }
    
    
    func getOpportunityRoverData(endPointType: Endpoint){
        dataStatus = .loading
        serviceLayer.getRoverPhotos(roverType: .opportunity,
                                    endPointType: endPointType)
            .sink(receiveCompletion: onRecive(_:),
                  receiveValue: { [weak self] value in
                    if value.photos.isEmpty{
                        self?.dataStatus = .empty
                    }else{
                        self?.opportunityDataArray = value.photos
                        self?.dataStatus = .full
                    }
                  }
            )
            .store(in: &cancellable)
    }
    
    func getSpiritRoverData(endPointType: Endpoint) {
        dataStatus = .loading
        serviceLayer.getRoverPhotos(roverType: .spirit,
                                    endPointType: endPointType)
            .sink (receiveCompletion: onRecive(_:),
                   receiveValue: { [weak self] value in
                    if value.photos.isEmpty{
                        self?.dataStatus = .empty
                    }else{
                        self?.spiritDataArray = value.photos
                        self?.dataStatus = .full
                    }
                   }
            )
            .store(in: &cancellable)
    }
}
