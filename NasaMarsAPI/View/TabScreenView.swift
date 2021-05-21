//
//  ContentView.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 19.05.2021.
//

import SwiftUI

struct TabScreenView: View {
    @EnvironmentObject private var apiService : NasaAPIViewModel
    @State private var selectedTab : ViewsNames = ViewsNames.curiosity
    
    @State private var showSelectCameraFilter : Bool = false
    @State private var showDetailCard : Bool = false
    @State private var showCalendar : Bool = false
    
    @State private var cameraPosition : CameraName = CameraName.all
    @State private var data : Photo?
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                CuriosityRoverView(showSelectCamera: $showSelectCameraFilter,
                                   showDetailCard: $showDetailCard,
                                   showCalendar: $showCalendar)
                    .environmentObject(apiService)
                    .tabItem {
                        Label(RoverNames.curiosity.rawValue,
                              systemImage: RoverNames.curiosity.iconName)
                    }
                    .tag(ViewsNames.curiosity)
                
                OpportunityRoverView(showSelectCamera: $showSelectCameraFilter,
                                     showDetailCard: $showDetailCard,
                                     showCalendar: $showCalendar)
                    .environmentObject(apiService)
                    .tabItem {
                        Label(RoverNames.opportunity.rawValue,
                              systemImage: RoverNames.opportunity.iconName)
                    }
                    .tag(ViewsNames.opportunity)
                
                SpiritRoverView(showSelectCamera: $showSelectCameraFilter,
                                showDetailCard: $showDetailCard, showCalendar: $showCalendar)
                    .environmentObject(apiService)
                    .tabItem {
                        Label(RoverNames.spirit.rawValue,
                              systemImage: RoverNames.spirit.iconName)
                    }
                    .tag(ViewsNames.spirit)
            }
            .sheet(isPresented: $showCalendar,
                   onDismiss: calendarDissmisFunctions,
                   content: {
                    CalendarView()
                   }
            )
            .onChange(of: selectedTab, perform: { value in
                apiService.selectedPage = value
            })
            
            if showSelectCameraFilter {
                VisualEffectBlur(blurStyle: .dark)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation(.easeInOut){
                            showSelectCameraFilter.toggle()
                        }
                    }
                CameraFilterView(cameraPositions: $cameraPosition,
                                 currentViewName: $selectedTab,
                                 closeCard: $showSelectCameraFilter)
                    .animation(.easeInOut)
                    .onDisappear {
                        switch selectedTab {
                        case .curiosity:
                            apiService.getCuriosityRoverData(endPointType: .shared.getByEarthDate(earthDate: apiService.selectedEarthDate,
                                                                                                  page: 1,
                                                                                                  camera: cameraPosition))
                        case .opportunity:
                            apiService.getOpportunityRoverData(endPointType: .shared.getByEarthDate(earthDate: apiService.selectedEarthDate,
                                                                                                    page: 1,
                                                                                                    camera: cameraPosition))
                        case .spirit:
                            apiService.getSpiritRoverData(endPointType: .shared.getByEarthDate(earthDate: apiService.selectedEarthDate,
                                                                                               page: 1,
                                                                                               camera: cameraPosition))
                        }
                    }
            }
            
            if showDetailCard {
                VisualEffectBlur(blurStyle: .dark)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation(.easeInOut){
                            showDetailCard.toggle()
                        }
                    }
                
                RoverDetailCard(closeCard: $showDetailCard)
                    .environmentObject(apiService)
            }
        }
        .animation(.easeInOut)
    }
    
    func calendarDissmisFunctions() {
        switch selectedTab {
        case .curiosity:
            apiService.getCuriosityRoverData(endPointType: .shared.getByEarthDate(earthDate: apiService.selectedEarthDate,
                                                                                  page: 1,
                                                                                  camera: cameraPosition))
        case .opportunity:
            apiService.getOpportunityRoverData(endPointType: .shared.getByEarthDate(earthDate: apiService.selectedEarthDate,
                                                                                    page: 1,
                                                                                    camera: cameraPosition))
        case .spirit:
            apiService.getSpiritRoverData(endPointType: .shared.getByEarthDate(earthDate: apiService.selectedEarthDate,
                                                                               page: 1,
                                                                               camera: cameraPosition))
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabScreenView()
    }
}
