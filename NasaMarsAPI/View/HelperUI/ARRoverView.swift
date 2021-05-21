//
//  ARRoverView.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 21.05.2021.
//

import SwiftUI

struct ARRoverView: View {
    var modelName: String
    
    var body: some View {
        ARQuickLookView(fileName: modelName)
    }
}

struct ARRoverView_Previews: PreviewProvider {
    static var previews: some View {
        ARRoverView(modelName: "spiritOppModel")
    }
}
