//
//  RoverImages.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 19.05.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct RoverDetailCard: View {
    var data: Photo
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                WebImage(url: URL(string: "https://mars.nasa.gov/mer/gallery/all/1/p/5091/1P580139317ESFD2FCP2117L3M1-BR.JPG"))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width - 30,
                           height: 290)
                
                VStack(alignment: .leading,
                       spacing: 8) {
                    VStack(alignment: .leading,spacing: 5) {
                        Text("Date: \(data.earthDate)")
                            .fontWeight(.thin)
                        Text("Rover Name: \(data.rover.name)")
                            .fontWeight(.thin)
                        
                    }
                    
                    
                    Text("Camera Positon: Miniature Thermal Emission Spectrometer (Mini-TES)")
                    
                    Divider()
                    
                    VStack(spacing: 5) {
                        Text("Launch Date: \(data.rover.launchDate)")
                            .fontWeight(.thin)
                        Text("Landing Date: \(data.rover.landingDate)")
                            .fontWeight(.thin)
                    }
                    
                    Text("Status: \(data.rover.status.capitalizingFirstLetter())")
                        .foregroundColor(data.rover.status == "complete" ? .green : .yellow)
                        .font(.system(.title3, design: .rounded))
                }
                .padding([.leading,.trailing],10)
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity,
                       alignment: .leading)
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width - 30,
                   height: UIScreen.main.bounds.height / 1.5,
                   alignment: .center)
            
            
            ZStack {
                Circle()
                    .foregroundColor(Color(.secondaryLabel))
                Image(systemName: "xmark")
                    .foregroundColor(.white)
            }
            .frame(width: 27, height: 27, alignment: .center)
            .padding()
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20,
                                    style: .circular))
        
    }
}

struct RoverDetailCard_Previews: PreviewProvider {
    static var previews: some View {
        RoverDetailCard(data: Photo(sol: 5091,
                                    camera: Camera(id: 14, name: "FHAZ", roverID: 6, fullName: "Front Hazard Avoidance Camera"), imgSrc: "https://mars.nasa.gov/mer/gallery/all/1/f/5091/1F580145109EDND2FCP1121R0M1-BR.JPG", earthDate: "2018-05-21",
                                    rover: Rover(id: 6, name: "Opportunity", landingDate: "2004-01-25", launchDate: "2003-07-07", status:     "complete")))
    }
}
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
