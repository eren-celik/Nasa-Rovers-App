//
//  Rover+HelperEnums.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 19.05.2021.
//

import Foundation
/// All Camera Types
enum CameraName: String, CaseIterable {
    case FHAZ       = "Front Hazard Avoidance Camera"
    case RHAZ       = "Rear Hazard Avoidance Camera"
    case MAST       = "Mast Camera"
    case CHEMCAM    = "Chemistry and Camera Complex"
    case MAHLI      = "Mars Hand Lens Imager"
    case MARDI      = "Mars Descent Imager"
    case NAVCAM     = "Navigation Camera"
    case PANCAM     = "Panoramic Camera"
    case MINITES    = "Miniature Thermal Emission Spectrometer (Mini-TES)"
    case all        = "All camera positions"
}
extension CameraName{
    /// Gives an Curiosity Rover Avalible Camera
    static var curiosityAvalibleCamera : [CameraName] {
        return [.FHAZ, .RHAZ, .MAST ,.CHEMCAM, .MAHLI, .MARDI, .NAVCAM ]
    }
    /// Gives an Oppurtunity Rover Avalible Camera
    static var oppurtunityAvabileCamera : [CameraName] {
        return [.FHAZ, .RHAZ, .NAVCAM, .PANCAM, .MINITES ]
    }
    /// Gives an Spirit Rover Avalible Camera
    static var spiritAvalibleCamera : [CameraName] {
        return [.FHAZ, .RHAZ, .NAVCAM, .PANCAM, .MINITES ]
    }
}

enum RoverNames: String , CaseIterable {
    case curiosity = "Curiosity"
    case opportunity = "Opportunity"
    case spirit = "Spirit"
}

extension RoverNames{
    ///TabView Icons Name
    var iconName : String {
        get{
            switch self {
            case .curiosity:
                return "circle.grid.2x2"
            case .opportunity:
                return "circle.grid.2x2.fill"
            case .spirit:
                return "circle.grid.2x2"
            }
        }
    }
    ///Defaults Rover Photo Date
    var roverPhotoDefaultDates: String {
        get{
            switch self{
            case .curiosity:
                return "2021-5-1"
            case .opportunity:
                return "2017-06-07"
            case .spirit:
                return "2009-12-23"
            }
        }
    }
}


enum DataStatus {
    case full
    case empty
    case error
    case loading
}

