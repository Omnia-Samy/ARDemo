//
//  ViewController.swift
//  SceneKitDemo
//
//  Created by Omnia Samy on 22/10/2021.
//

import UIKit
import SceneKit
import ARKit

class ViewController: BaseViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show statistics such as fps and timing information
//        sceneView.showsStatistics = true
        
        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
//        sceneView.scene = scene
        addTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
//        sceneView.scene = SCNScene()
        // Run the view's session
        sceneView.session.run(configuration)
        // Set the view's delegate
        sceneView.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
     */
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        print(error)
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

extension ViewController {
    
    @IBAction func resetTapped(_ sender: UIButton) {
        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
        }
    }
    
    @IBAction func playTapped(_ sender: UIButton) {
        let min = 0.0
        let max = 0.5
        let randomDouble = Double.random(in: min ... max)
        createGeomatery(position: randomDouble)
    }
    
    func createGeomatery(position: Double) {
        
        let geomatery = SCNBox(width: 0.02, height: 0.02, length: 0.02, chamferRadius: 0)
        let node = SCNNode()
        node.geometry = geomatery
        node.position = SCNVector3(position, position, 0) // x y z
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        self.sceneView.scene.rootNode.addChildNode(node)
    }
    
    func addTapGesture() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc
    func didTap(withGestureRecognizer recognizer: UIGestureRecognizer) {
        
        let selectedLocation = recognizer.location(in: sceneView)
        let hitTestResult = sceneView.hitTest(selectedLocation)
        
        guard let node = hitTestResult.first?.node else {
            return
        }
        
        // node existe show toast message and remove it
        self.showSuccessMessage(successMessage: "You earn one point")
        node.removeFromParentNode()
    }
}
