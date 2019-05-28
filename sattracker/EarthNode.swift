 //
//  EarthNode.swift
//  sattracker
//
//  Created by Daniel Berger on 26.05.19.
//  Copyright © 2019 Daniel Berger. All rights reserved.
//

import SceneKit


class EarthNode: SCNNode {

  override init() {
    super.init()
    self.geometry = SCNSphere(radius: CGFloat(EarthRadius))
    self.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "earth-texture")
    self.geometry?.firstMaterial?.normal.contents = UIImage(named: "earth-normal")
    self.geometry?.firstMaterial?.specular.contents = UIImage(named: "earth-specular")
    self.geometry?.firstMaterial?.emission.contents = UIImage(named: "earth-emission")
    //self.position = SCNVector3(0,0,0)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
}
