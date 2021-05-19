//
//  Rover+HelperEnums.swift
//  NasaMarsAPI
//
//  Created by Eren  Çelik on 19.05.2021.
//

import Foundation

enum FullName: String, Codable {
    case frontHazardAvoidanceCameraLeft  = "Front Hazard Avoidance Camera - Left"
    case frontHazardAvoidanceCameraRight = "Front Hazard Avoidance Camera - Right"
    case mastCameraZoomLeft              = "Mast Camera Zoom - Left"
    case mastCameraZoomRight             = "Mast Camera Zoom - Right"
    case medaSkycam = "MEDA Skycam"
    case navigationCameraLeft = "Navigation Camera - Left"
    case navigationCameraRight = "Navigation Camera - Right"
    case sherlocWATSONCamera = "SHERLOC WATSON Camera"
    case superCamRemoteMicroImager = "SuperCam Remote Micro Imager"
}

enum CameraName: String, Codable {
    case frontHazcamLeftA = "FRONT_HAZCAM_LEFT_A"
    case frontHazcamRightA = "FRONT_HAZCAM_RIGHT_A"
    case mczLeft = "MCZ_LEFT"
    case mczRight = "MCZ_RIGHT"
    case navcamLeft = "NAVCAM_LEFT"
    case navcamRight = "NAVCAM_RIGHT"
    case sherlocWatson = "SHERLOC_WATSON"
    case skycam = "SKYCAM"
    case supercamRMI = "SUPERCAM_RMI"
}

enum RoverNames: String {
    case curiosity
    case opportunity
    case spirit
}
