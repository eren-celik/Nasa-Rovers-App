//
//  Rover+HelperEnums.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 19.05.2021.
//

import Foundation

enum CameraName: String, Codable {
    case FHAZ       = "Front Hazard Avoidance Camera"
    case RHAZ       = "Rear Hazard Avoidance Camera"
    case MAST       = "Mast Camera"
    case CHEMCAM    = "Chemistry and Camera Complex"
    case MAHLI      = "Mars Hand Lens Imager"
    case MARDI      = "Mars Descent Imager"
    case NAVCAM     = "Navigation Camera"
    case PANCAM     = "Panoramic Camera"
    case MINITES    = "Miniature Thermal Emission Spectrometer (Mini-TES)"
}

enum RoverNames: String {
    case curiosity = "Curiosity"
    case opportunity = "Opportunity"
    case spirit = "Spirit"
}
