//
//  Opportunity.swift
//  NasaMarsAPI
//
//  Created by Eren Çelik on 19.05.2021.
//

import SwiftUI

struct OpportunityRoverView: View {
    @Binding var showSelectCamera : Bool
    
    @EnvironmentObject private var service : NasaAPIViewModel
    private let gridItemLayout = [GridItem(.adaptive(minimum: 150, maximum: 170),spacing: 20)]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridItemLayout , spacing : 20) {
                    ForEach(service.curiostyDataArray) { value in
                        PhotosCellView(photosModel: value)
                    }
                }
            }
            .navigationTitle(RoverNames.opportunity.rawValue)
            .navigationBarItems(trailing: Button(action: {
                showSelectCamera.toggle()
            }, label: {
                Image(systemName: "line.horizontal.3.decrease")
                    .imageScale(.large)
            }))
        }
    }
}

struct Opportunity_Previews: PreviewProvider {
    static var previews: some View {
        OpportunityRoverView(showSelectCamera: .constant(false))
            .environmentObject(NasaAPIViewModel())
    }
}
