//
//  CustomToolBarItems.swift
//  NasaMarsAPI
//
//  Created by Eren Çelik on 20.05.2021.
//

import SwiftUI

struct CustomToolbarItems : ToolbarContent {
    @Binding var showCalendar: Bool
    @Binding var showCameraFilterView: Bool
    var arKitFileName : String
    var body: some ToolbarContent{
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            Button(action: {
                showCalendar.toggle()
            }, label: {
                Image(systemName: "calendar")
                    .imageScale(.large)
            })
            Button(action: {
                showCameraFilterView.toggle()
            }, label: {
                Image(systemName: "line.horizontal.3.decrease")
                    .imageScale(.large)
            })
        }
        ToolbarItem(placement: .navigationBarLeading){
            NavigationLink(
                destination: ARRoverView(modelName: arKitFileName),
                label: {
                    Image(systemName: "arkit")
                })
        }
    }
}
