//
//  CameraFilterView.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 20.05.2021.
//

import SwiftUI

struct CameraFilterView: View {
    @Binding var cameraPositions: CameraName
    @Binding var closeCard : Bool
    @State private var showDropDownMenu : Bool = false
    
    var body: some View {
        VStack {
            DisclosureGroup(cameraPositions.rawValue, isExpanded: $showDropDownMenu) {
                VStack(alignment: .leading){
                    ForEach(CameraName.allCases , id: \.self) { value in
                        HStack {
                            Text(value.rawValue)
                                .font(.system(.body, design: .rounded))
                                .fontWeight(.light)
                                .padding(.top, value == CameraName.FHAZ ? 10 : 0)
                            
                            Spacer()
                        }
                        .onTapGesture {
                            cameraPositions = value
                            showDropDownMenu.toggle()
                            closeCard.toggle()
                        }
                        Divider()
                    }
                }.frame(maxWidth: .infinity)
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
                showDropDownMenu.toggle()
            }
            .animation(.spring(response: 0.4,
                               dampingFraction: 0.7,
                               blendDuration: 0))
        }
        .background(Color.white)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20,
                                    style: .circular))
        .shadow(color: Color.black.opacity(0.2),
                radius: 3,
                x: 1,
                y: 1
        )
        
    }
}

struct CameraFilterView_Previews: PreviewProvider {
    static var previews: some View {
        CameraFilterView(cameraPositions: .constant(CameraName.CHEMCAM),
                         closeCard: .constant(false))
    }
}
