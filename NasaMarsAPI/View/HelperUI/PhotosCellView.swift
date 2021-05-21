//
//  PhotosCellView.swift
//  NasaMarsAPI
//
//  Created by Eren Çelik on 19.05.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct PhotosCellView: View {
    @Binding var onTapPhoto: Bool
    @EnvironmentObject private var service : NasaAPIViewModel
    
    private var photoData : Photo
    
    init(onTapPhoto: Binding<Bool>, photoModel: Photo) {
        self._onTapPhoto = onTapPhoto
        self.photoData = photoModel
    }
    
    var body: some View {
        WebImage(url: URL(string: photoData.imgSrc)!)
            .resizable()
            .indicator(.activity)
            .aspectRatio(contentMode: .fill)
            .frame(width: 170, height: 170)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .onTapGesture {
                self.onTapPhoto.toggle()
                service.photoDetailData = photoData
            }
    }
}

struct PhotosCellView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosCellView(onTapPhoto: .constant(false),
                       photoModel: Photo(sol: 2, camera: Camera(id: 2, name: "", roverID: 2, fullName: ""),
                                         imgSrc: "https://mars.nasa.gov/msl-raw-images/msss/03105/mcam/3105MR0162310161401727C00_DXXX.jpg",
                                         earthDate: "",
                                         rover: Rover(id: 2, name: "", landingDate: "", launchDate: "", status: "")))
    }
}
