//
//  spirit.swift
//  NasaMarsAPI
//
//  Created by Eren Çelik on 19.05.2021.
//

import SwiftUI

struct SpiritRoverView: View {
    @Binding var showSelectCamera: Bool
    
    @EnvironmentObject private var service : NasaAPIViewModel
    private let gridItemLayout = [GridItem(.adaptive(minimum: 150, maximum: 170),spacing: 20)]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridItemLayout , spacing : 20) {
                    ForEach(service.spiritDataArray) { value in
                        PhotosCellView(photosModel: value)
                    }
                }
            }
            .navigationTitle(RoverNames.spirit.rawValue)
            .navigationBarItems(trailing: Button(action: {
                showSelectCamera.toggle()
            }, label: {
                Image(systemName: "line.horizontal.3.decrease")
                    .imageScale(.large)
            }))
        }
    }
}

struct Spirit_Previews: PreviewProvider {
    static var previews: some View {
        SpiritRoverView(showSelectCamera: .constant(false))
    }
}
