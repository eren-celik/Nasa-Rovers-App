//
//  RoverImages.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 19.05.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct RoverDetailCard: View {
    @Binding var closeCard: Bool
    @EnvironmentObject private var service : RoversViewModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            if let data = service.photoDetailData {
                VStack {
                    WebImage(url: URL(string: data.imgSrc))
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width - 30,
                               height: 320)
                        .aspectRatio(contentMode: .fit)
                    
                    VStack(alignment: .leading,
                           spacing: 8) {
                        VStack(alignment: .leading,spacing: 5) {
                            Text("Date: \(data.earthDate)")
                                .fontWeight(.thin)
                            Text("Rover Name: \(data.rover.name)")
                                .fontWeight(.thin)
                        }
                        
                        Text("Camera Positon: \(data.camera.fullName)")
                        
                        Divider()
                        
                        VStack(alignment: .leading,
                               spacing: 5) {
                            Text("Launch Date: \(data.rover.launchDate)")
                                .fontWeight(.thin)
                            Text("Landing Date: \(data.rover.landingDate)")
                                .fontWeight(.thin)
                        }
                            
                            Text("Status: \(data.rover.status.capitalizingFirstLetter())")
                                .foregroundColor(data.rover.status == "complete" ? .green : .yellow)
                                .font(.system(.title3, design: .rounded))
                    }
                    .padding([.leading, .trailing], 10)
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity,
                           alignment: .leading)
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width - 30,
                       height: UIScreen.main.bounds.height / 1.5,
                       alignment: .center)
            }else{
                Text("Error An Occured Try Another Image")
                    .font(.system(.title3, design: .rounded))
                    .foregroundColor(.red)
                    .padding(30)
            }
            
            Button(action: {
                withAnimation(.easeInOut){
                    self.closeCard.toggle()
                }
            }, label: {
                ZStack {
                    Circle()
                        .foregroundColor(.secondary)
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                }
                .frame(width: 27, height: 27, alignment: .center)
                .padding()
            })
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20,
                                    style: .circular))
        .shadow(color: Color.black.opacity(0.2),
                radius: 3,
                x: 1,
                y: 1
        )
        .animation(.easeInOut)
    }
}

struct RoverDetailCard_Previews: PreviewProvider {
    static var previews: some View {
        RoverDetailCard(closeCard: .constant(false))
            .environmentObject(RoversViewModel())
    }
}
