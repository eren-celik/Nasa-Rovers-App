//
//  CuriosityView.swift
//  NasaMarsAPI
//
//  Created by Eren Çelik on 19.05.2021.
//

import SwiftUI

struct CuriosityRoverView: View {
    @Binding var showSelectCamera: Bool
    
    @EnvironmentObject private var service : NasaAPIViewModel
    private let gridItemLayout = [GridItem(.adaptive(minimum: 150, maximum: 170),spacing: 20)]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns:  gridItemLayout, spacing : 20) {
                    ForEach(1...20,id : \.self) { value in
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(width: 170, height: 170)
                            .foregroundColor(.red)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                }
            }
            .navigationTitle(RoverNames.curiosity.rawValue)
            .navigationBarItems(trailing: Button(action: {
                showSelectCamera.toggle()
            }, label: {
                Image(systemName: "line.horizontal.3.decrease")
                    .imageScale(.large)
            }))
        }
    }
}

struct CuriosityView_Previews: PreviewProvider {
    static var previews: some View {
        CuriosityRoverView(showSelectCamera: .constant(false))
            .environmentObject(NasaAPIViewModel())
    }
}
