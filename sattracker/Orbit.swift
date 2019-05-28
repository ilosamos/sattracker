//
//  Orbit.swift
//  sattracker
//
//  Created by Daniel Berger on 26.05.19.
//  Copyright © 2019 Daniel Berger. All rights reserved.
//

import Foundation
import UIKit
import SceneKit
import Euclid
import SCNLine

class Orbit: SCNNode {
  var apogee: Double
  var perigee: Double
  var inclination: Double
  var incRad: Double
  var eccentricity: Double
  var rA: Double
  var rP: Double
  var majorAxis: Double
  var minorAxis: Double
  
  init(apogee ap: Double, perigee pe: Double, inclination inc: Double) {
    self.apogee = ap * ScaleFactor
    self.perigee = pe * ScaleFactor
    self.inclination = inc
    self.incRad = inc.rad
    self.rA = self.apogee + EarthRadius
    self.rP = self.perigee + EarthRadius
    self.eccentricity = (rA - rP) / (rA + rP)
    self.majorAxis = self.apogee + 2 * EarthRadius + self.perigee
    self.minorAxis = 2 * ((self.majorAxis / 2) * sqrt(1 - pow(self.eccentricity,2)))
    
    super.init()
    
    // Draw ellipse
    var ell1 = Path.ellipse(width: self.minorAxis, height: self.majorAxis, segments: Int(self.perimeter() / 1.5))
    ell1 = ell1.rotated(by: Rotation(axis: Vector(SCNVector3(1.0, 0.0, 0.0)), radians: 90.0.rad)!)
    ell1 = ell1.rotated(by: Rotation(axis: Vector(SCNVector3(0.0, 1.0, 0.0)), radians: 90.0.rad)!)
    ell1 = ell1.translated(by: Vector((self.majorAxis / 2) - self.perigee - EarthRadius, 0))
    ell1 = ell1.rotated(by: Rotation(axis: Vector(SCNVector3(0.0, 0.0, 1.0)), radians: incRad)!)
    let vecs = ell1.points.map { (point) -> SCNVector3 in
      return SCNVector3(point.position.x, point.position.y, point.position.z)
    }
    
    let lineNode = SCNLineNode(with: vecs, radius: 0.1, edges: 4, maxTurning: 1)
    lineNode.geometry?.firstMaterial?.diffuse.contents = UIColor.white
    //lineNode.geometry?.firstMaterial?.emission.contents = UIColor.gray
    lineNode.geometry?.firstMaterial?.lightingModel = SCNMaterial.LightingModel.constant
    self.geometry = lineNode.geometry
  }
  
  required init?(coder aDecoder: NSCoder) {
    self.apogee = 0
    self.perigee = 0
    self.inclination = 0
    self.incRad = 0
    self.eccentricity = 0
    self.rA = 0
    self.rP = 0
    self.majorAxis = 0
    self.minorAxis = 0
    super.init(coder: aDecoder)
  }
  
  // Perimeter Approximation of eclipse
  func perimeter() -> Double {
    let a = self.majorAxis / 2
    let b = self.minorAxis / 2
    
    let p = .pi * ((3 * (a + b)) - sqrt((3 * a + b) * (a + 3 * b)))
    return p
  }
}
