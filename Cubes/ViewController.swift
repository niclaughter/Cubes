//
//  ViewController.swift
//  Cubes
//
//  Created by Nicholas Laughter on 5/13/16.
//  Copyright © 2016 Nicholas Laughter. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: SCNView!
    
    private let kRotation = "rotation"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScene()
    }

    private func setupScene() {
        // Configure the Scene view
        sceneView.backgroundColor = .grayColor()
        
        // Create the scene
        let scene = SCNScene()
        
        // Create a camera and attach it to a node
        let camera = SCNCamera()
        camera.xFov = 10
        camera.yFov = 45
        
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        
        cameraNode.position = SCNVector3(0, 0, 50)
        scene.rootNode.addChildNode(cameraNode)
        
        // Creare cube and place in the scene
            // Subclass of SCNGeometry
        let cube = SCNBox(width: 5, height: 5, length: 5, chamferRadius: 0)
        let pyramid = SCNPyramid(width: 5, height: 5, length: 5)
        cube.firstMaterial?.diffuse.contents = UIColor(red: 0.149, green: 0.604, blue: 0.859, alpha: 1.0)
        pyramid.firstMaterial?.diffuse.contents = UIColor(red: 0.149, green: 0.604, blue: 0.859, alpha: 1.0)
        let cubeNode = SCNNode(geometry: cube)
        let pyramidNode = SCNNode(geometry: pyramid)
        scene.rootNode.addChildNode(cubeNode)
        scene.rootNode.addChildNode(pyramidNode)
        
        // Add an animation
        let cubeAnimation = CAKeyframeAnimation(keyPath: self.kRotation)
        cubeAnimation.values = [NSValue(SCNVector4: SCNVector4(1, 1, 0.3, 0 * M_PI)),
                            NSValue(SCNVector4: SCNVector4(1, 1, 0.3, 1 * M_PI)),
                            NSValue(SCNVector4: SCNVector4(1, 1, 0.3, 2 * M_PI))]
        cubeAnimation.duration = 5
        cubeAnimation.repeatCount = HUGE
        
        let pyramidAnimation = CAKeyframeAnimation(keyPath: self.kRotation)
        pyramidAnimation.values = [NSValue(SCNVector4: SCNVector4(-1, -1, -0.3, 0 * M_PI)),
                                   NSValue(SCNVector4: SCNVector4(-1, -1, -0.3, 1 * M_PI)),
                                   NSValue(SCNVector4: SCNVector4(-1, -1, -0.3, 2 * M_PI))]
        pyramidAnimation.duration = 2.5
        pyramidAnimation.repeatCount = HUGE
        
        // Add animation to the node
        cubeNode.addAnimation(cubeAnimation, forKey: self.kRotation)
        pyramidNode.addAnimation(pyramidAnimation, forKey: self.kRotation)
        pyramidNode.position = SCNVector3(0, 10, 0)
        
        sceneView.scene = scene
    }
}

