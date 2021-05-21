//
//  ContentView.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 19.05.2021.
//

import SwiftUI

struct TabScreenView: View {
    @EnvironmentObject private var service : RoversViewModel
    @State private var selectedTab            : RoverNames = RoverNames.curiosity
    
    @State private var showSelectCameraFilter : Bool = false
    @State private var showDetailCard         : Bool = false
    @State private var showCalendar           : Bool = false
    @State private var selectedDate           : Date = Date()
    
    @State private var cameraPosition : CameraName = CameraName.all
    @State private var data : Photo?
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                CuriosityRoverView(showSelectCamera: $showSelectCameraFilter,
                                   showDetailCard: $showDetailCard,
                                   showCalendar: $showCalendar)
                    .environmentObject(service)
                    .tabItem {
                        Label(RoverNames.curiosity.rawValue,
                              systemImage: RoverNames.curiosity.iconName)
                    }
                    .tag(RoverNames.curiosity)
                
                OpportunityRoverView(showSelectCamera: $showSelectCameraFilter,
                                     showDetailCard: $showDetailCard,
                                     showCalendar: $showCalendar)
                    .environmentObject(service)
                    .tabItem {
                        Label(RoverNames.opportunity.rawValue,
                              systemImage: RoverNames.opportunity.iconName)
                    }
                    .tag(RoverNames.opportunity)
                
                SpiritRoverView(showSelectCamera: $showSelectCameraFilter,
                                showDetailCard: $showDetailCard, showCalendar: $showCalendar)
                    .environmentObject(service)
                    .tabItem {
                        Label(RoverNames.spirit.rawValue,
                              systemImage: RoverNames.spirit.iconName)
                    }
                    .tag(RoverNames.spirit)
            }
            .sheet(isPresented: $showCalendar,
                   onDismiss: calendarDissmisFunctions,
                   content: {
                    CalendarView(selectedDate: $selectedDate)
                        .environmentObject(service)
                   }
            )
            .onChange(of: selectedTab, perform: { value in
                service.currentView = value
            })
            ZStack{
                if showSelectCameraFilter {
                    VisualEffectBlur(blurStyle: .dark)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation(.easeInOut){
                                showSelectCameraFilter.toggle()
                            }
                        }
                    CameraFilterView(currentViewName: $selectedTab,
                                     closeCard: $showSelectCameraFilter)
                        .environmentObject(service)
                        .animation(.easeInOut)
                        .onDisappear {
                            cameraFilterViewDismissFunctions()
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
                        .environmentObject(service)
                }
            }
            .transition(.scale)
        }
    }
    
    func calendarDissmisFunctions() {
        if service.roverPhotoDate != nil{
            switch selectedTab {
            case .curiosity:
                service.getCuriosityRoverData(selectedEarthDate: service.dateFormatter.string(from: selectedDate))
            case .opportunity:
                service.getOpportunityRoverData(selectedEarthDate: service.dateFormatter.string(from: selectedDate))
            case .spirit:
                service.getSpiritRoverData(selectedEarthDate: service.dateFormatter.string(from: selectedDate))
            }
        }
    }
    
    func cameraFilterViewDismissFunctions(){
        service.pageCount = 1
        if service.cameraPosition != .all {
            switch selectedTab {
            case .curiosity:
                service.getCuriosityRoverData()
            case .opportunity:
                service.getOpportunityRoverData()
            case .spirit:
                service.getSpiritRoverData()
            }
        }
    }
    
}

struct TabScreenView_Previews: PreviewProvider {
    static var previews: some View {
        TabScreenView()
    }
}
