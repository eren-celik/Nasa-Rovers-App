//
//  NasaAPIViewModel.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 19.05.2021.
//

import Foundation
import Combine

final class NasaAPIViewModel : ObservableObject{
    @Published var curiostyDataArray : [Photo] = PhotoArray()
    @Published var spiritDataArray : [Photo] = PhotoArray()

    @Published var selectedDate : String = ""
    
    private let serviceLayer = UsersLogicController(networkProtocol: NetworkController())
    private var cancellable = Set<AnyCancellable>()
    
    func getCuriosityRoverData(){
        serviceLayer.getRoverPhotosByEarthDate(roverType: .curiosity)
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
                print(value)
                self?.curiostyDataArray = value.photos
            }
            .store(in: &cancellable)
    }
    
    func getSpiritRoverData(){
        serviceLayer.getRoverPhotosByEarthDate(roverType: .spirit)
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
                print(value.photos.count)
                self?.spiritDataArray = value.photos
            }
            .store(in: &cancellable)
    }
}
