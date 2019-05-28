//
//  ViewController.swift
//  sattracker
//
//  Created by Daniel Berger on 26.05.19.
//  Copyright © 2019 Daniel Berger. All rights reserved.
//

import UIKit
import SceneKit
import Euclid
import SCNLine

class ViewController: UIViewController {
  let cameraNode = SCNNode()
  let earthNode = EarthNode()
  let objectsNode = SCNNode()
  let cameraOrbit = SCNNode()

  override func viewDidLoad() {
    super.viewDidLoad()
    let scene = SCNScene()
    // Add light
    let lightNode = SCNNode()
    lightNode.light = SCNLight()
    lightNode.light?.type = .omni
    lightNode.position = SunPosition
    objectsNode.addChildNode(lightNode)

    // Add rotation to earth
    let animation = CAKeyframeAnimation(keyPath: "rotation")
    animation.values = [NSValue(scnVector4: SCNVector4(0.0, 1.0, 0.0, 0.0)),
                        NSValue(scnVector4: SCNVector4(0.0, 1.0, 0.0, .pi * 2.0))]
    animation.duration = EarthPeriod
    animation.repeatCount = .infinity
    earthNode.addAnimation(animation, forKey: "rotation")
    earthNode.isPaused = false // Start out paused
    
    objectsNode.addChildNode(earthNode)

    // Draw Orbit
    let orbitNode = Orbit(apogee: 35505, perigee: 733, inclination: 8)
    objectsNode.addChildNode(orbitNode)
    
    // Draw Orbit
    let orbitNode2 = Orbit(apogee: 500, perigee: 500, inclination: 51)
    objectsNode.addChildNode(orbitNode2)
    
    // Draw Orbit
    let moonNode = Orbit(apogee: 362600, perigee: 405400, inclination: 25)
    moonNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
    objectsNode.addChildNode(moonNode)
    
    
    let camera = SCNCamera()
    camera.usesOrthographicProjection = true
    camera.orthographicScale = 15
    camera.zNear = 0
    camera.zFar = 100
    let cameraNode = SCNNode()
    cameraNode.position = SCNVector3(x: 0, y: 0, z: Float(CameraDistance))
    cameraNode.camera = camera
    cameraOrbit.addChildNode(cameraNode)
    
    scene.rootNode.addChildNode(cameraOrbit)
    scene.rootNode.addChildNode(objectsNode)
    
    let sceneView = self.view as! SCNView
    sceneView.scene = scene
    sceneView.showsStatistics = true
    sceneView.scene?.background.contents = [UIImage(named: "skybox1"),UIImage(named: "skybox2"),UIImage(named: "skybox3"),UIImage(named: "skybox4"),UIImage(named: "skybox5"),UIImage(named: "skybox6")]
  }
  @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
    cameraOrbit.eulerAngles.x -= Float(sender.translation(in: self.view).y) * Float(PanFactor) * min(cameraOrbit.scale.x,2.6)
    cameraOrbit.eulerAngles.y -= Float(sender.translation(in: self.view).x) * Float(PanFactor) * min(cameraOrbit.scale.x,2.6)
    cameraOrbit.eulerAngles.x = max(cameraOrbit.eulerAngles.x, (.pi / 2) * -1)
    cameraOrbit.eulerAngles.x = min(cameraOrbit.eulerAngles.x, (.pi / 2))

    sender.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
  }
  @IBAction func handlePinch(_ sender: UIPinchGestureRecognizer) {
    cameraOrbit.scale.x *= 1 / Float(sender.scale)
    cameraOrbit.scale.y *= 1 / Float(sender.scale)
    cameraOrbit.scale.z *= 1 / Float(sender.scale)
    sender.scale = 1
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
}

