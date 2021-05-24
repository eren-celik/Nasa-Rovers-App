//
//  spirit.swift
//  NasaMarsAPI
//
//  Created by Eren Çelik on 19.05.2021.
//

import SwiftUI

struct SpiritRoverView: View {
    @EnvironmentObject private var service : RoversViewModel
    
    @Binding var showSelectCamera: Bool
    @Binding var showDetailCard  : Bool
    @Binding var showCalendar    : Bool
    
    
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
            .navigationTitle(RoverNames.spirit.rawValue)
            .toolbar {
                CustomToolbarItems(showCalendar: $showCalendar,
                                   showCameraFilterView: $showSelectCamera,
                                   arKitFileName: "spirit")
            }
        }
    }
}

struct Spirit_Previews: PreviewProvider {
    static var previews: some View {
        SpiritRoverView(showSelectCamera: .constant(false),
                        showDetailCard: .constant(false),
                        showCalendar: .constant(false))
    }
}

extension SpiritRoverView{
    private var mainView : some View{
        ScrollView {
            LazyVGrid(columns: ViewsHelper.gridItemLayout , spacing : 20) {
                ForEach(service.spiritDataArray.indices,id: \.self) { value in
                    PhotosCellView(onTapPhoto: $showDetailCard,
                                   photoModel: service.spiritDataArray[value])
                        .environmentObject(service)
                        .onAppear(){
                            if service.spiritDataArray[value].id == service.spiritDataArray.last?.id{
                                service.loadMorePhoto(isLast: true, roverType: .spirit, defaultDate: .spirit)
                            }
                        }
                }
            }
        }
    }
}
