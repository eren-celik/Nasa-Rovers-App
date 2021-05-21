//
//  NasaMarsAPIApp.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 19.05.2021.
//

import SwiftUI

@main
struct NasaMarsAPIApp: App {
    @ObservedObject var apiService = RoversViewModel()
    var body: some Scene {
        WindowGroup {
            TabScreenView()
                .environmentObject(apiService)
                .onAppear {
                    ///Getting data to Default Dates:
                    apiService.getCuriosityRoverData()
                    apiService.getOpportunityRoverData()
                    apiService.getSpiritRoverData()
                }
        }
    }
}
