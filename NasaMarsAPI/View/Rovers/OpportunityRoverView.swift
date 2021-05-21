//
//  Opportunity.swift
//  NasaMarsAPI
//
//  Created by Eren Çelik on 19.05.2021.
//

import SwiftUI

struct OpportunityRoverView: View {
    @Binding var showSelectCamera: Bool
    @Binding var showDetailCard  : Bool
    @Binding var showCalendar    : Bool
    
    @EnvironmentObject private var service : NasaAPIViewModel
    private let gridItemLayout = [
        GridItem(.adaptive(minimum: 150, maximum: 170),spacing: 20)
    ]
    
    var body: some View {
        NavigationView {
            Group{
                switch service.dataStatus{
                case .empty:
                    Text("No Data Found")
                case .full:
                    mainView
                case .error:
                    Text("Error An Occurred")
                case .loading:
                    ProgressView {
                        Text("Loading...")
                    }
                }
            }
            .navigationTitle(RoverNames.opportunity.rawValue)
            .toolbar {
                CustomToolbarItems(showCalendar: $showCalendar,
                                   showCameraFilterView: $showSelectCamera)
            }
        }
    }
    
    private var mainView: some View {
        ScrollView {
            LazyVGrid(columns: gridItemLayout , spacing : 20) {
                ForEach(service.opportunityDataArray.indices) { index in
                    if index == service.opportunityDataArray.count - 2{
                        PhotosCellView(onTapPhoto: $showDetailCard,
                                       photoModel: service.opportunityDataArray[index],
                                       lastObject: true)
                            .environmentObject(service)
                    }else{
                        PhotosCellView(onTapPhoto: $showDetailCard, photoModel: service.opportunityDataArray[index], lastObject: false)
                            .environmentObject(service)
                    }
                }
            }
        }
    }
}

struct Opportunity_Previews: PreviewProvider {
    static var previews: some View {
        OpportunityRoverView(showSelectCamera: .constant(false),
                             showDetailCard: .constant(false),
                             showCalendar: .constant(false))
            .environmentObject(NasaAPIViewModel())
    }
}
