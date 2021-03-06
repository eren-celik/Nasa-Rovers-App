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
    
    @EnvironmentObject private var service : RoversViewModel
    
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
                                   showCameraFilterView: $showSelectCamera,
                                   arKitFileName: "spirit")
            }
        }
    }
}

struct Opportunity_Previews: PreviewProvider {
    static var previews: some View {
        OpportunityRoverView(showSelectCamera: .constant(false),
                             showDetailCard: .constant(false),
                             showCalendar: .constant(false))
            .environmentObject(RoversViewModel())
    }
}

extension OpportunityRoverView{
    private var mainView: some View {
        ScrollView {
            LazyVGrid(columns: ViewsHelper.gridItemLayout , spacing : 20) {
                ForEach(service.opportunityDataArray.indices,id: \.self) { value in
                    PhotosCellView(onTapPhoto: $showDetailCard,
                                   photoModel: service.opportunityDataArray[value])
                        .environmentObject(service)
                        .onAppear(){
                            if service.opportunityDataArray[value].id == service.opportunityDataArray.last?.id{
                                service.loadMorePhoto(isLast: true, roverType: .opportunity, defaultDate: .opportunity)
                            }
                        }
                }
            }
        }
    }
}
