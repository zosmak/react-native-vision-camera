//
//  PhotoCaptureService.swift
//  VisionCamera
//
//  Created by Daniel on 11/02/2022.
//  Copyright © 2022 mrousavy. All rights reserved.
//

import AVFoundation

extension AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, willCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        // dispose system shutter sound
        AudioServicesDisposeSystemSoundID(1108)
    }
}
