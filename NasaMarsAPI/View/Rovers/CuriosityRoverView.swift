//
//  CuriosityView.swift
//  NasaMarsAPI
//
//  Created by Eren Çelik on 19.05.2021.
//

import SwiftUI

struct ViewsHelper {
    static let gridItemLayout = [
        GridItem(.adaptive(minimum: 150, maximum: 170),spacing: 20)
    ]
}
struct CuriosityRoverView: View {
    @Binding var showSelectCamera: Bool
    @Binding var showDetailCard  : Bool
    @Binding var showCalendar    : Bool
    
    @EnvironmentObject private var service : RoversViewModel
    
    var body: some View {
        NavigationView {
            Group{
                switch service.dataStatus {
                case .empty:
                    Text("No Data Found")
                case .full:
                    mainView
                case .error:
                    Text("Error An Occured")
                case .loading:
                    ProgressView {
                        Text("Loading...")
                    }
                }
            }
            
            .navigationTitle(RoverNames.curiosity.rawValue)
            .toolbar {
                CustomToolbarItems(showCalendar: $showCalendar,
                                   showCameraFilterView: $showSelectCamera,
                                   arKitFileName: "curiosity")
            }
        }
    }
}

struct CuriosityView_Previews: PreviewProvider {
    static var previews: some View {
        CuriosityRoverView(showSelectCamera: .constant(false),
                           showDetailCard: .constant(false),
                           showCalendar: .constant(false))
            .environmentObject(RoversViewModel())
    }
}

extension CuriosityRoverView{
    private var mainView: some View{
        ScrollView {
            LazyVGrid(columns: ViewsHelper.gridItemLayout , spacing : 20) {
                ForEach(service.curiostyDataArray.indices,id: \.self) { value in
                    PhotosCellView(onTapPhoto: $showDetailCard,
                                   photoModel: service.curiostyDataArray[value])
                        .environmentObject(service)
                        .onAppear(){
                            if service.curiostyDataArray[value].id == service.curiostyDataArray.last?.id{
                                service.loadMorePhoto(isLast: true, roverType: .curiosity, defaultDate: .curiosity)
                            }
                        }
                }
                
            }
        }
    }
}
