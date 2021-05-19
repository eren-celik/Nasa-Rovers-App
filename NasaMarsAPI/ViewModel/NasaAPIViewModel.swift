//
//  NasaAPIViewModel.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 19.05.2021.
//

import Foundation
import Combine

final class NasaAPIViewModel : ObservableObject{
    @Published var photosArray : [Photo] = PhotoArray()
    
    private let serviceLayer = UsersLogicController(networkProtocol: NetworkController())
    private var cancellable = Set<AnyCancellable>()
    
    func getPhotos(){
        serviceLayer.getRoverPhotosByEarthDate()
            .sink { status in
                switch status{
                case .finished:
                    break
                case .failure(let error):
                    #if DEBUG
                    print(error.localizedDescription)
                    #endif
                }
            } receiveValue: { [weak self] value in
                print("DEBUG: " , value.photos.count)
                self?.photosArray = value.photos
            }
            .store(in: &cancellable)
    }
}

final class ApiHelperService : ObservableObject {
    @Published var selectedDate : String = ""
}
