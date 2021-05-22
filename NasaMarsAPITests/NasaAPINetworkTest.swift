//
//  NasaAPINetworkTest.swift
//  NasaMarsAPITests
//
//  Created by Eren  Çelik on 19.05.2021.
//

import XCTest
import Combine
@testable import NasaMarsAPI

class NasaAPINetworkTest: XCTestCase {
    
    override  func setUp() {
    }
    
    func testFilePaths_GivesAExampleJsonData() throws{
        let photoData = Bundle(for: NasaAPINetworkTest.self).decode(RoverPhotosModel.self,
                                                                    from: "exampleData.json")
        
        XCTAssertEqual(photoData.photos.count, 25)
        XCTAssert(photoData.photos.first?.camera.id == 20 , "Camera ID True")
    }
    
    override func tearDown() {
        
    }
    
}
