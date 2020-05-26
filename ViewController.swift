//
//  ViewController.swift
//  FirstAR
//
//  Created by Taha Ishfaq on 2019-11-21.
//  Copyright © 2019 Taha Ishfaq. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
            
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        setUpScene()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
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
    
/// Sets up the actual portal itself
/// Starting with each of the dimensions that will be seen by the user whilst using
/// Such as the right, left, top, bottom and back that the portal is consisted of
    
    func setUpScene(){
        
        let node = SCNNode()
        self.sceneView.scene.rootNode.addChildNode(node)
        node.position = SCNVector3Make(0, 0, 0)
    
        let rightWall = createRec(isPortal: false)
        rightWall.position = SCNVector3.init((length/2) - width, 0, 0)
        
        let leftWall = createRec(isPortal: false)
        leftWall.position = SCNVector3.init((-length/2) + width, 0, 0)
        leftWall.eulerAngles = SCNVector3Make(0, Float(180.0.degreesToRad), 0)
        
        let bottomWall = createRec(isPortal: false)
        bottomWall.position = SCNVector3.init(0, (-height / 2) + width, 0)
        bottomWall.eulerAngles = SCNVector3Make(0, 0, Float(-90.0.degreesToRad))

        
        let topWall = createRec(isPortal: false)
        topWall.position = SCNVector3.init(0, (height / 2) - width, 0)
        topWall.eulerAngles = SCNVector3Make(0, 0, Float(90.0.degreesToRad))


        let backWall = createRec(isPortal: false)
        backWall.position = SCNVector3.init(0, 0, (-length / 2) + width)
        backWall.eulerAngles = SCNVector3Make(0, Float(90.0.degreesToRad), 0)

        let rightPortalSide = createRec(isPortal: true)
        rightPortalSide.position = SCNVector3.init( (length / 2 ) - (-portalLength / 2), 0, length / 2)
        rightPortalSide.eulerAngles = SCNVector3Make(0, Float(-90.0.degreesToRad), 0)

        
        let leftPortalSide = createRec(isPortal: true)
        leftPortalSide.position = SCNVector3.init( (-length / 2) + (portalLength / 2), 0, length / 2)
        leftPortalSide.eulerAngles = SCNVector3Make(0, Float(-90.0.degreesToRad), 0)
        
        
        node.addChildNode(rightWall)
        node.addChildNode(leftWall)
        node.addChildNode(bottomWall)
        node.addChildNode(topWall)
        node.addChildNode(backWall)
        node.addChildNode(leftPortalSide)
        node.addChildNode(leftPortalSide)

/// adds lighting inside the dark portal itself
        let light = SCNLight()
        light.type = .spot
        light.spotInnerAngle = 70
        light.spotOuterAngle = 120
        light.zNear = 0.0001
        light.zFar = 5
        light.castsShadow = true
        light.shadowRadius = 200
        light.shadowColor = UIColor.black.withAlphaComponent(0.3)
        light.shadowMode = .deferred
        
        let constraint = SCNLookAtConstraint(target: topWall)
        constraint.isGimbalLockEnabled = true
        
        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = SCNVector3Make(0, Float((height/2) - width) , 0)
        lightNode.constraints = [constraint]
        node.addChildNode(lightNode)
    }

    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
