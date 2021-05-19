//
//  RoverImages.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 19.05.2021.
//

import SwiftUI

struct RoverImages: View {
    
    @EnvironmentObject var service : NasaAPIViewModel
    
    var body: some View {
        NavigationView{
            List{
                ForEach(service.curiostyDataArray) { id in
                    Text(id.camera.fullName)
                }
            }

        }
    }
}

struct RoverImages_Previews: PreviewProvider {
    static var previews: some View {
        RoverImages()
    }
}
