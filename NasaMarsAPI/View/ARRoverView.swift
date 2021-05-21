//
//  ARRoverView.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 21.05.2021.
//

import SwiftUI
import SafariServices

struct ARRoverView: View {
    var modeName: Bool
    var body: some View {
        SafariView(url: URL(string: "https://model-uszd.web.app/assets/models/\(modeName ? "curi" : "opp").usdz")!)
    }
}

struct ARRoverView_Previews: PreviewProvider {
    static var previews: some View {
        ARRoverView(modeName: true)
    }
}
struct SafariView: UIViewControllerRepresentable {
    
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {}
}
