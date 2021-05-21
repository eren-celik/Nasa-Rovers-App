//
//  NasaAPIViewModel.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 19.05.2021.
//

import Foundation
import Combine


final class RoversViewModel : ObservableObject{
    private let serviceLayer = UsersLogicController(networkProtocol: NetworkController())
    private var cancellable = Set<AnyCancellable>()
    
    @Published var curiostyDataArray    : [Photo] = PhotoArray()
    @Published var opportunityDataArray : [Photo] = PhotoArray()
    @Published var spiritDataArray      : [Photo] = PhotoArray()
    
    @Published var dataStatus : DataStatus = .full
    @Published var cameraPosition : CameraName = CameraName.all
    @Published var photoDetailData : Photo?
    
    @Published var roverPhotoDate : String?
    @Published var pageCount: Int = 1
    
    @Published var currentView : RoverNames?{
        didSet{
            pageCount = 1
            cameraPosition = .all
        }
    }
    
    let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
extension RoversViewModel{
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

extension RoversViewModel {
    
    func getCuriosityRoverData(selectedEarthDate: String? = nil) {
        dataStatus = .loading
        serviceLayer.getRoverPhotos(roverType: .curiosity,
                                    endPointType: .shared.getByEarthDate(earthDate: selectedEarthDate ?? RoverPhotosDefaultDate.curiosity.rawValue,
                                                                         page: pageCount,
                                                                         camera: cameraPosition))
            .sink (receiveCompletion: onRecive(_:),
                   receiveValue: { [weak self] value in
                    if value.photos.isEmpty{
                        self?.dataStatus = .empty
                    }else{
                        DispatchQueue.main.async {
                            self?.curiostyDataArray = value.photos
                            self?.dataStatus = .full
                        }
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
                                                                         camera: cameraPosition))
            .sink(receiveCompletion: onRecive(_:),
                  receiveValue: { [weak self] value in
                    if value.photos.isEmpty{
                        self?.dataStatus = .empty
                    }else{
                        DispatchQueue.main.async {
                            self?.curiostyDataArray = value.photos
                            self?.dataStatus = .full
                        }
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
                                                                         camera: cameraPosition))
            .sink(receiveCompletion: onRecive(_:),
                  receiveValue: { [weak self] value in
                    if value.photos.isEmpty{
                        self?.dataStatus = .empty
                    }else{
                        DispatchQueue.main.async {
                            self?.curiostyDataArray = value.photos
                            self?.dataStatus = .full
                        }
                    }
                  }
            )
            .store(in: &cancellable)
    }
}
extension RoversViewModel{
    func loadMorePhoto(isLast: Bool, roverType : RoverNames, defaultDate: RoverPhotosDefaultDate) {
        if isLast {
            serviceLayer.getRoverPhotos(roverType: roverType,
                                        endPointType: .shared.getByEarthDate(earthDate: self.roverPhotoDate ?? defaultDate.rawValue,
                                                                             page: pageCount,
                                                                             camera: cameraPosition))
                .handleEvents(receiveOutput: { response in
                    self.pageCount += 1
                })
                .sink(receiveCompletion: onRecive(_:),
                      receiveValue: { [weak self] value in
                        if !value.photos.isEmpty{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                switch roverType{
                                case .curiosity:
                                    self?.curiostyDataArray += value.photos
                                    break
                                case .opportunity:
                                    self?.opportunityDataArray += value.photos
                                    break
                                case .spirit:
                                    self?.spiritDataArray += value.photos
                                    break
                                }
                            }
                        }
                      }
                )
                .store(in: &cancellable)
            
        }
    }
}
