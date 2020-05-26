//
//  ExtensionAR.swift
//  FirstAR
//
//  Created by Taha Ishfaq on 2019-11-21.
//  Copyright © 2019 Taha Ishfaq. All rights reserved.
//
/// Created portal that user can walk into and out of
// Portal has strict dimensions and when user has surpassed those dimensions,
/// user will be outside of the portal


import Foundation
import SceneKit
import ARKit

var height: CGFloat = 1
var length: CGFloat = 1
var width: CGFloat = 0.02

var portalLength : CGFloat = 0.3

/// IsPortal is used so if it is a portal then we create different lengths for the rectangle

func createRec(isPortal : Bool) -> SCNNode{
    
    let node = SCNNode()

/// firstPortal will be the portal that user will walk into and the door (second outter box) will be the invisible one
    
    let firstPortal = SCNBox(width: width, height: height, length: isPortal ? portalLength: length, chamferRadius: 0)
    let firstPortalNode = SCNNode(geometry: firstPortal)
    firstPortalNode.renderingOrder = 300
    
    node.addChildNode(firstPortalNode)
    
    let door = SCNBox(width: width, height: height, length: isPortal ? portalLength: length, chamferRadius: 0)
    door.firstMaterial?.diffuse.contents = UIColor.white
    door.firstMaterial?.transparency = 0.0001
    
    let doorNode = SCNNode(geometry: door)
    doorNode.renderingOrder = 200
    doorNode.position = SCNVector3.init(width, 0, 0)
    
    node.addChildNode(doorNode)
    
    return node
    
}

/// Set up to make rotational work easier
extension FloatingPoint{
    var degreesToRad : Self{
        return self * .pi / 180
    }
}
