//
//  ContentView.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 19.05.2021.
//

import SwiftUI

struct TabScreenView: View {
    @ObservedObject private var apiService = NasaAPIViewModel()
    @State var selectedTab : ViewsNames = ViewsNames.curiosity
    
    @State private var showDetailCard : Bool = false
    @State private var showSelectCameraFilter : Bool = false
    @State private var cameraPosition : CameraName = CameraName.all
    @State private var data : Photo?
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                CuriosityRoverView(showSelectCamera: $showSelectCameraFilter, showDetailCard: $showDetailCard)
                    .environmentObject(apiService)
                    .tabItem {
                        Image(systemName:  RoverNames.curiosity.iconName)
                        Text(RoverNames.curiosity.rawValue)
                    }
                    .tag(ViewsNames.curiosity)
                
                OpportunityRoverView(showSelectCamera: $showSelectCameraFilter, showDetailCard: $showDetailCard)
                    .environmentObject(apiService)
                    .tabItem {
                        Image(systemName:  RoverNames.opportunity.iconName).font(.system(size: 26))
                        Text(RoverNames.opportunity.rawValue)
                    }
                    .tag(ViewsNames.opportunity)
                
                SpiritRoverView(showSelectCamera: $showSelectCameraFilter, showDetailCard: $showDetailCard)
                    .environmentObject(apiService)
                    .tabItem {
                        Image(systemName: RoverNames.spirit.iconName)
                        Text(RoverNames.spirit.rawValue)
                    }
                    .tag(ViewsNames.spirit)
            }
            .onChange(of: selectedTab, perform: { value in
                apiService.selectedPage = value
            })
            .onAppear(){
                apiService.getCuriosityRoverData(endPointType: .shared.getByEarthDate(earthDate: "2021-5-1",
                                                                                      page: 1,
                                                                                      camera: cameraPosition))
                apiService.getOpportunityRoverData(endPointType: .shared.getBySolDay(solDay: 5091,
                                                                                     page: 1,
                                                                                     camera: cameraPosition))
                apiService.getSpiritRoverData(endPointType: .shared.getBySolDay(solDay: 2122,
                                                                                page: 1,
                                                                                camera: cameraPosition))
            }
            
            if showSelectCameraFilter {
                VisualEffectBlur(blurStyle: .dark)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation(.easeInOut){
                            showSelectCameraFilter.toggle()
                        }
                    }
                CameraFilterView(cameraPositions: $cameraPosition,
                                 closeCard: $showSelectCameraFilter)
                    .animation(.easeInOut)
                    .onDisappear {
                        //Todo : Add Loading Indicator
                        switch selectedTab {
                        case .curiosity:
                            apiService.getCuriosityRoverData(endPointType: .shared.getByEarthDate(earthDate: "2021-5-1",
                                                                                                  page: 1,
                                                                                                  camera: cameraPosition))
                        case .opportunity:
                            apiService.getOpportunityRoverData(endPointType: .shared.getBySolDay(solDay: 5091,
                                                                                                 page: 1,
                                                                                                 camera: cameraPosition))
                        case .spirit:
                            apiService.getSpiritRoverData(endPointType: .shared.getBySolDay(solDay: 2122,
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabScreenView()
    }
}
