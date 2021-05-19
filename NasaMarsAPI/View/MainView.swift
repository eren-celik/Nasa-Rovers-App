//
//  ContentView.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 19.05.2021.
//

import SwiftUI

struct MainView: View {
    @ObservedObject private var service = NasaAPIViewModel()
    
    var body: some View {
        List{
            ForEach(service.photosArray) { id in
                Text(id.camera.fullName)
            }
        }
        .onAppear() {
            service.getPhotos()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
