//
//  PA3DTrackingView.swift
//  AccelerometerTest
//
//  Created by Pasquale Ambrosini on 14/05/16.
//  Copyright © 2016 Pasquale Ambrosini. All rights reserved.
//

import SceneKit

class PA3DTrackingView: SCNView {

    var pointerNode: SCNNode!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupScene()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupScene()
    }
    
    
    
    private func setupScene() {
        let scene = SCNScene()
        self.backgroundColor = UIColor.blackColor()
        self.scene = scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 30)
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLightTypeAmbient
        ambientLightNode.light!.color = UIColor.lightGrayColor()
        scene.rootNode.addChildNode(ambientLightNode)
        
        let geometry = SCNSphere(radius: 0.5)
        let node = SCNNode(geometry: geometry)
        self.scene?.rootNode.addChildNode(node)
        
        let xAxisMaterial = SCNMaterial()
        xAxisMaterial.diffuse.contents = UIColor.redColor()
        
        let xAxisGeometry = SCNCylinder(radius: 0.1, height: 10)
        xAxisGeometry.materials = [xAxisMaterial]
        let xAxisNode = SCNNode(geometry: xAxisGeometry)
        xAxisNode.pivot = SCNMatrix4MakeTranslation(0.0, -5, 0.0)
        xAxisNode.eulerAngles = SCNVector3(x: GLKMathDegreesToRadians(0), y: 0, z: GLKMathDegreesToRadians(90))
        xAxisNode.position = node.position
        self.scene?.rootNode.addChildNode(xAxisNode)
        
        let yAxisMaterial = SCNMaterial()
        yAxisMaterial.diffuse.contents = UIColor.greenColor()
        
        let yAxisGeometry = SCNCylinder(radius: 0.1, height: 10)
        yAxisGeometry.materials = [yAxisMaterial]
        let yAxisNode = SCNNode(geometry: yAxisGeometry)
        yAxisNode.pivot = SCNMatrix4MakeTranslation(0.0, -5, 0.0)
        yAxisNode.eulerAngles = SCNVector3(x: GLKMathDegreesToRadians(180), y: 0, z: 0)
        yAxisNode.position = node.position
        self.scene?.rootNode.addChildNode(yAxisNode)
        
        let zAxisMaterial = SCNMaterial()
        zAxisMaterial.diffuse.contents = UIColor.blueColor()
        
        let zAxisGeometry = SCNCylinder(radius: 0.1, height: 10)
        zAxisGeometry.materials = [zAxisMaterial]
        let zAxisNode = SCNNode(geometry: zAxisGeometry)
        zAxisNode.pivot = SCNMatrix4MakeTranslation(0.0, -5, 0.0)
        zAxisNode.eulerAngles = SCNVector3(x: GLKMathDegreesToRadians(270), y: 0, z: 0)
        zAxisNode.position = node.position
        self.scene?.rootNode.addChildNode(zAxisNode)
        
        self.pointerNode = node
    }
    
    func setPointerPosition(x x: Double, y: Double, z: Double) {
        self.pointerNode.position = SCNVector3(x, y, z)
    }
}
