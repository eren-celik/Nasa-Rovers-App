//
//  ContentView.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 19.05.2021.
//

import SwiftUI

struct TabScreenView: View {
    @ObservedObject private var service = NasaAPIViewModel()
    @State private var showSelectCamera : Bool = false
    
    var body: some View {
        TabView {
            CuriosityRoverView(showSelectCamera: $showSelectCamera)
                .environmentObject(service)
                .tabItem {
                    Image(systemName:  RoverNames.curiosity.iconName)
                    Text( RoverNames.curiosity.rawValue)
                }
            
            OpportunityRoverView(showSelectCamera: $showSelectCamera)
                .environmentObject(service)
                .tabItem {
                    Image(systemName:  RoverNames.opportunity.iconName).font(.system(size: 26))
                    Text(RoverNames.opportunity.rawValue)
                }
            
            SpiritRoverView(showSelectCamera: $showSelectCamera)
                .environmentObject(service)
                .tabItem {
                    Image(systemName: RoverNames.spirit.iconName)
                    Text(RoverNames.spirit.rawValue)
                }
        }
        .sheet(isPresented: $showSelectCamera, content: {
            Text("Sheet")
        })
        .onAppear(){
            service.getCuriosityRoverData(endPointType: .shared.getByEarthDate(earthDate: "2021-5-1", page: 1, camera: .all))
            service.getOpportunityRoverData(endPointType: .shared.getBySolDay(solDay: 5091, page: 1, camera: .all))
            service.getSpiritRoverData(endPointType: .shared.getBySolDay(solDay: 2122, page: 1, camera: .all))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabScreenView()
    }
}
