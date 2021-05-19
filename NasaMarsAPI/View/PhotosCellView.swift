//
//  PhotosCellView.swift
//  NasaMarsAPI
//
//  Created by Eren Çelik on 19.05.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct PhotosCellView: View {
    private var photoData : Photo
    
    init(photosModel: Photo) {
        self.photoData = photosModel
    }
    
    var body: some View {
        WebImage(url: URL(string: photoData.imgSrc)!)
            .resizable()
            .indicator(.activity)
            .aspectRatio(contentMode: .fill)
            .frame(width: 170, height: 170)
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct PhotosCellView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosCellView(photosModel: Photo(sol: 2, camera: Camera(id: 2, name: "", roverID: 2, fullName: ""), imgSrc: "https://mars.nasa.gov/msl-raw-images/msss/03105/mcam/3105MR0162310161401727C00_DXXX.jpg", earthDate: "", rover: Rover(id: 2, name: "", landingDate: "", launchDate: "", status: "")))
    }
}
