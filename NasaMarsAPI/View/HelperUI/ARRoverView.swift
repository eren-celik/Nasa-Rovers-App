//
//  ARRoverView.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 21.05.2021.
//

import SwiftUI
import QuickLook
import ARKit

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


struct ARQuickLookView: UIViewControllerRepresentable {
    var fileName: String
    
    func makeCoordinator() -> ARQuickLookView.Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> QLPreviewController {
        let controller = QLPreviewController()
        controller.dataSource = context.coordinator
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ controller: QLPreviewController,
                                context: Context) {}
    
    class Coordinator: NSObject, QLPreviewControllerDataSource, QLPreviewControllerDelegate {
        let parent: ARQuickLookView
        
        init(_ parent: ARQuickLookView) {
            self.parent = parent
            super.init()
        }
        
        func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            return 1
        }
        
        func previewController(_ controller: QLPreviewController,
                               previewItemAt index: Int) -> QLPreviewItem {
            guard let path = Bundle.main.path(forResource: parent.fileName, ofType: "usdz") else { fatalError("Couldn't find the supported input file.")
            }
            let url = URL(fileURLWithPath: path)
            return url as QLPreviewItem
        }
    }
}
