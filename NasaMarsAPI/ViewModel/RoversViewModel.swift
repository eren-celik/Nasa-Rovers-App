//
//  NasaAPIViewModel.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 19.05.2021.
//

import Foundation
import Combine


final class RoversViewModel : ObservableObject{
    private let serviceLayer = ServicePhotoLogicController(networkProtocol: NetworkController())
    private var cancellable = Set<AnyCancellable>()
    
    @Published var curiostyDataArray    : [Photo] = PhotoArray()
    @Published var opportunityDataArray : [Photo] = PhotoArray()
    @Published var spiritDataArray      : [Photo] = PhotoArray()
    
    @Published var dataStatus : DataStatus = .full
    @Published var cameraPosition : CameraName = CameraName.all
    /// Holding Single Photo Data
    @Published var photoDetailData : Photo?
    
    @Published var roverPhotoDate : String?
    @Published var pageCount: Int = 1
    
    /// Holding TabView Screen Values
    @Published var currentView : RoverNames?{
        didSet{
            pageCount = 1
            cameraPosition = .all
        }
    }
    ///Api Data date format
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
            switch error {
            case NasaAPIError.jsonParsingFailure:
                #if DEBUG
                print(NasaAPIError.jsonParsingFailure.localizedDescription)
                #endif
            default:
                #if DEBUG
                print("Unidentified: ",error.localizedDescription)
                #endif
            }
        }
    }
}

extension RoversViewModel {
    /// Brings up Curiosity Rover data
    /// - Parameter selectedEarthDate: If the user has selected a specific date that day, it will return data according to that date, if there is no date, the default date is returned
    func getCuriosityRoverData(selectedEarthDate: String? = nil) {
        dataStatus = .loading
        serviceLayer.getRoverPhotos(roverType: .curiosity,
                                    endPointType: .shared.getByEarthDate(earthDate: selectedEarthDate ?? RoverNames.curiosity.roverPhotoDefaultDates,
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
    /// Brings up Opportunity Rover data
    /// - Parameter selectedEarthDate: If the user has selected a specific date that day, it will return data according to that date, if there is no date, the default date is returned
    func getOpportunityRoverData(selectedEarthDate: String? = nil){
        dataStatus = .loading
        serviceLayer.getRoverPhotos(roverType: .opportunity,
                                    endPointType: .shared.getByEarthDate(earthDate: selectedEarthDate ?? RoverNames.opportunity.roverPhotoDefaultDates,
                                                                         page: pageCount,
                                                                         camera: cameraPosition))
            .sink(receiveCompletion: onRecive(_:),
                  receiveValue: { [weak self] value in
                    if value.photos.isEmpty{
                        self?.dataStatus = .empty
                    }else{
                        DispatchQueue.main.async {
                            self?.opportunityDataArray = value.photos
                            self?.dataStatus = .full
                        }
                    }
                  }
            )
            .store(in: &cancellable)
    }
    /// Brings up Spirit Rover data
    /// - Parameter selectedEarthDate: If the user has selected a specific date that day, it will return data according to that date, if there is no date, the default date is returned
    func getSpiritRoverData(selectedEarthDate: String? = nil) {
        self.dataStatus = .loading
        serviceLayer.getRoverPhotos(roverType: .spirit,
                                    endPointType: .shared.getByEarthDate(earthDate: selectedEarthDate ?? RoverNames.spirit.roverPhotoDefaultDates,
                                                                         page: pageCount,
                                                                         camera: cameraPosition))
            .sink(receiveCompletion: onRecive(_:),
                  receiveValue: { [weak self] value in
                    if value.photos.isEmpty{
                        self?.dataStatus = .empty
                    }else{
                        DispatchQueue.main.async {
                            self?.spiritDataArray = value.photos
                            self?.dataStatus = .full
                        }
                    }
                  }
            )
            .store(in: &cancellable)
    }
}
extension RoversViewModel{
    /// If the selected date or camera has more photos, brings up the other photos
    /// - Parameter isLast: If the user saw the last photos should return a true value
    /// - Parameter roverType: Nasa Rover Type
    /// - Parameter defaultDate: If the user has selected a specific date that day, it will return data according to that date, if there is no date, the default date is returned
    /// - Note : If the user changes the screen or TabView whatever page count resetting to one otherwise page count increase 1 until getting the no more photos
    func loadMorePhoto(isLast: Bool, roverType : RoverNames, defaultDate: RoverNames) {
        if isLast {
            serviceLayer.getRoverPhotos(roverType: roverType,
                                        endPointType: .shared.getByEarthDate(earthDate: self.roverPhotoDate ?? defaultDate.roverPhotoDefaultDates,
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
