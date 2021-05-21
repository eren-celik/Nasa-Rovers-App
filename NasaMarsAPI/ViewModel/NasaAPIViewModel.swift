//
//  NasaAPIViewModel.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 19.05.2021.
//

import Foundation
import Combine
import SwiftUI

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
    
    @Published var dataStatus : DataStatus = .full
    @Published var cameraPositions : CameraName = CameraName.all
    @Published var photoDetailData : Photo?
    @Published var selectedPage : ViewsNames = ViewsNames.curiosity

    @Published var pageCount: Int = 1
    
    
    private let serviceLayer = UsersLogicController(networkProtocol: NetworkController())
    
    private var cancellable = Set<AnyCancellable>()
    let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
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
    
    func getCuriosityRoverData(selectedEarthDate: String? = nil) {
        dataStatus = .loading
        serviceLayer.getRoverPhotos(roverType: .curiosity,
                                    endPointType: .shared.getByEarthDate(earthDate: selectedEarthDate ?? RoverPhotosDefaultDate.curiosity.rawValue,
                                                                         page: pageCount,
                                                                         camera: cameraPositions))
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
    
    func getOpportunityRoverData(selectedEarthDate: String? = nil){
        dataStatus = .loading
        serviceLayer.getRoverPhotos(roverType: .opportunity,
                                    endPointType: .shared.getByEarthDate(earthDate: selectedEarthDate ?? RoverPhotosDefaultDate.opportunity.rawValue,
                                                                         page: pageCount,
                                                                         camera: cameraPositions))
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
    
    func getSpiritRoverData(selectedEarthDate: String? = nil) {
        self.dataStatus = .loading
        serviceLayer.getRoverPhotos(roverType: .spirit,
                                    endPointType: .shared.getByEarthDate(earthDate: selectedEarthDate ?? RoverPhotosDefaultDate.spirit.rawValue,
                                                                         page: pageCount,
                                                                         camera: cameraPositions))
            .sink(receiveCompletion: onRecive(_:),
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
extension NasaAPIViewModel{
    func loadMorePhoto(currentValue : Photo) {
        if spiritDataArray.last?.id == currentValue.id{
            pageCount += 1
            serviceLayer.getRoverPhotos(roverType: .spirit,
                                        endPointType: .shared.getByEarthDate(earthDate: "2017-5-2" ,
                                                                             page: pageCount,
                                                                             camera: cameraPositions))
                .sink(receiveCompletion: onRecive(_:),
                      receiveValue: { [weak self] value in
                        if !value.photos.isEmpty{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self?.spiritDataArray += value.photos
                            }
                        }
                      }
                )
                .store(in: &cancellable)
        }
    }
}
