//
//  ContentView.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 19.05.2021.
//

import SwiftUI

struct TabScreenView: View {
    @ObservedObject private var apiService = NasaAPIViewModel()
    
    @State private var showDetailCard : Bool = false
    @State private var data : Photo?
    
    var body: some View {
        ZStack {
            TabView {
                CuriosityRoverView(showSelectCamera: $showDetailCard, showDetailCard: $showDetailCard)
                    .environmentObject(apiService)
                    .tabItem {
                        Image(systemName:  RoverNames.curiosity.iconName)
                        Text( RoverNames.curiosity.rawValue)
                    }
                
                OpportunityRoverView(showSelectCamera: $showDetailCard, showDetailCard: $showDetailCard)
                    .environmentObject(apiService)
                    .tabItem {
                        Image(systemName:  RoverNames.opportunity.iconName).font(.system(size: 26))
                        Text(RoverNames.opportunity.rawValue)
                    }
                
                SpiritRoverView(showSelectCamera: $showDetailCard, showDetailCard: $showDetailCard)
                    .environmentObject(apiService)
                    .tabItem {
                        Image(systemName: RoverNames.spirit.iconName)
                        Text(RoverNames.spirit.rawValue)
                    }
            }
            .onAppear(){
                apiService.getCuriosityRoverData(endPointType: .shared.getByEarthDate(earthDate: "2021-5-1", page: 1, camera: .all))
                apiService.getOpportunityRoverData(endPointType: .shared.getBySolDay(solDay: 5091, page: 1, camera: .all))
                apiService.getSpiritRoverData(endPointType: .shared.getBySolDay(solDay: 2122, page: 1, camera: .all))
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
