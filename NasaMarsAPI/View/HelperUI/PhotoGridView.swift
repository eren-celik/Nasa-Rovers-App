//
//  PhotoGridView.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 21.05.2021.
//

import SwiftUI

struct PhotoGridView: View {
    @EnvironmentObject var service : NasaAPIViewModel
    @Binding var showDetailCard: Bool
    
    private let gridItemLayout = [
        GridItem(.adaptive(minimum: 150, maximum: 170),spacing: 20)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItemLayout , spacing : 20) {
                ForEach(service.curiostyDataArray) { value in
                    PhotosCellView(onTapPhoto: $showDetailCard,
                                   photoModel: value)
                        .environmentObject(service)
                        .onAppear(){
                            //service.loadMorePhoto(dataArray: service.curiostyDataArray, roverType: .curiosity, currentValue: value, defaultDate: .curiosity)
                        }
                }
            }
        }
    }
}

//struct PhotoGridView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoGridView()
//    }
//}
