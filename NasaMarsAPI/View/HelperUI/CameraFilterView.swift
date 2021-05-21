//
//  CameraFilterView.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 20.05.2021.
//

import SwiftUI

struct CameraFilterView: View {
    @EnvironmentObject var service : NasaAPIViewModel
    
    @Binding var currentViewName : ViewsNames
    @Binding var closeCard       : Bool
    
    @State private var showDropDownMenu : Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Select the Camera you want to filter")
                .font(.system(.title3,
                              design: .rounded))
                .padding([.leading,.top], 10)
            DisclosureGroup(service.cameraPositions.rawValue, isExpanded: $showDropDownMenu) {
                VStack(alignment: .leading){
                    ForEach(selectedTab(), id: \.self) { value in
                        HStack {
                            Text(value.rawValue)
                                .font(.system(.body, design: .rounded))
                                .fontWeight(.light)
                                .padding(.top, value == CameraName.FHAZ ? 10 : 0)
                            
                            Spacer()
                        }
                        .onTapGesture {
                            service.cameraPositions = value
                            withAnimation {
                                showDropDownMenu.toggle()
                            }
                            closeCard.toggle()
                        }
                        Divider()
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .font(.system(size: 20,
                          weight: .light,
                          design: .rounded))
            .padding()
            .background(Color(.secondarySystemFill))
            .clipShape(RoundedRectangle(cornerRadius: 15,
                                        style: .circular))
            .padding()
            .onTapGesture {
                withAnimation {
                    showDropDownMenu.toggle()
                }
            }
        }
        .animation(.spring(response: 0.4,
                           dampingFraction: 0.7,
                           blendDuration: 0))
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20,
                                    style: .circular))
        .shadow(color: Color.black.opacity(0.2),
                radius: 3,
                x: 1,
                y: 1
        )
        
    }
    
    private func selectedTab() -> [CameraName] {
        switch currentViewName{
        case .curiosity:
            return CameraName.curiosityAvalibleCamera
        case .opportunity:
            return CameraName.oppurtunityAvabileCamera
        case .spirit:
            return CameraName.spiritAvalibleCamera
        }
    }
}

struct CameraFilterView_Previews: PreviewProvider {
    static var previews: some View {
        CameraFilterView(currentViewName: .constant(.curiosity),
                         closeCard: .constant(false))
    }
}
