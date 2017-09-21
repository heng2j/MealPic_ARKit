//
//  ViewController.swift
//  MealPic_ARKit
//
//  Created by Zhongheng Li on 9/13/17.
//  Copyright © 2017 Zhongheng Li. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        // Set the view's delegate
        sceneView.delegate = self
        
    
        
//        // Show statistics such as fps and timing information
//        sceneView.showsStatistics = true
        
//        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
//
//        // Set the scene to the view
//        sceneView.scene = scene
        
        
        //let cube = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.01)
        
        // Moon
//        let sphere = SCNSphere(radius: 0.2)
//
//        let material = SCNMaterial()
//
//        material.diffuse.contents = UIImage(named: "art.scnassets/moon.jpg" )
//
//        sphere.materials = [material]
//
//        let node = SCNNode()
//
//        node.position = SCNVector3(0, 0.1, -0.5)
//
//        node.geometry = sphere
//
//
//        sceneView.scene.rootNode.addChildNode(node)
        
        
        
        
        
        sceneView.autoenablesDefaultLighting = true
        
  
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        configuration.planeDetection = .horizontal
        
        
        
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        if anchor is ARPlaneAnchor {
            
            let planeAnchor = anchor as! ARPlaneAnchor
            
            
            let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x) , height: CGFloat(planeAnchor.extent.z))
            
            let planeNode = SCNNode()
            
            planeNode.position = SCNVector3(x: planeAnchor.extent.x , y: 0, z: planeAnchor.extent.z)
            
            // Transform the planNodes orientation
            planeNode.transform = SCNMatrix4MakeRotation( -Float.pi / 2, 1, 0, 0)
            
            let gridMatieral = SCNMaterial()
            
            gridMatieral.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
            
            plane.materials = [gridMatieral]
            
            planeNode.geometry = plane
            
            node.addChildNode(planeNode)
            

        } else {
            
            return
        
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            
            let touchLocation = touch.location(in: sceneView)
            
            let results = sceneView.hitTest(touchLocation, types: .existingPlaneUsingExtent)
            
            
            if let hitResult = results.first{
                
                
                
                //        // Create a new scene
                let diceScene = SCNScene(named: "art.scnassets/Pokemon.scn")!
                
                if let diceNode = diceScene.rootNode.childNode(withName: "Ivysaur", recursively: true){
                    
                    diceNode.position = SCNVector3(
                        
                        x: hitResult.worldTransform.columns.3.x,
                        y: hitResult.worldTransform.columns.3.y + diceNode.boundingSphere.radius,
                        z: hitResult.worldTransform.columns.3.z
                    
                    
                    )
                    
                    sceneView.scene.rootNode.addChildNode(diceNode)
                    
                }
                
                
            }

            
        }
    }
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Release any cached data, images, etc that aren't in use.
//    }
//
//    // MARK: - ARSCNViewDelegate
//
///*
//    // Override to create and configure nodes for anchors added to the view's session.
//    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
//        let node = SCNNode()
//
//        return node
//    }
//*/
//
//    func session(_ session: ARSession, didFailWithError error: Error) {
//        // Present an error message to the user
//
//    }
//
//    func sessionWasInterrupted(_ session: ARSession) {
//        // Inform the user that the session has been interrupted, for example, by presenting an overlay
//
//    }
//
//    func sessionInterruptionEnded(_ session: ARSession) {
//        // Reset tracking and/or remove existing anchors if consistent tracking is required
//
//    }
}
