//
//  Constants.swift
//  sattracker
//
//  Created by Daniel Berger on 26.05.19.
//  Copyright © 2019 Daniel Berger. All rights reserved.
//

import Foundation
import SceneKit

let ScaleFactor: Double = 0.001 // For Scaling down original earth and orbit measures
let EarthRadius: Double = 6371 * ScaleFactor // Earth's radius scaled down
let EarthPeriod: Double = 86400 // 24h in seconds
let CameraDistance: Double = EarthRadius * 5 // Distance of initial viewpoint (camera) to earth
let SunPosition: SCNVector3 = SCNVector3(x: Float(EarthRadius * 100), y: 0, z: Float(EarthRadius * 100))

let PanFactor: Double = 0.004 // Higher Number means greater speed when panning camera
let MaxPanFactor: Double = 2.6 // Maximum multiplier for panning speed relative to scale (zoom)

extension Double {
  var rad: Double {
    get {
      return self * .pi / 180
    }
  }
}
