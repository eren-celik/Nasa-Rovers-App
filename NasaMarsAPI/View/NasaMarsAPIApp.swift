//
//  NasaMarsAPIApp.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 19.05.2021.
//

import SwiftUI

@main
struct NasaMarsAPIApp: App {
    @ObservedObject var apiService = NasaAPIViewModel()
    var body: some Scene {
        WindowGroup {
            TabScreenView()
                .environmentObject(apiService)
                .onAppear {
                    ///Getting data to Default Dates:
                    apiService.getCuriosityRoverData(endPointType: .shared.getByEarthDate(earthDate: RoverPhotosDefaultDate.curiosity.rawValue,
                                                                                          page: 1,
                                                                                          camera: .all))
                    apiService.getOpportunityRoverData(endPointType: .shared.getByEarthDate(earthDate: RoverPhotosDefaultDate.opportunity.rawValue,
                                                                                            page: 1,
                                                                                            camera: .all))
                    apiService.getSpiritRoverData(endPointType: .shared.getByEarthDate(earthDate: RoverPhotosDefaultDate.spirit.rawValue,
                                                                                       page: 1,
                                                                                       camera: .all))
                }
        }
    }
}
