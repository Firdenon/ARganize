//
//  MainARViewController.swift
//  ARganize
//
//  Created by Ricky Adi Kuncoro on 15/08/18.
//  Copyright © 2018 MC3 RE:ceh. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import CoreData


class MainARViewController: UIViewController, ARSCNViewDelegate{

    var listNode = [SCNNode]()
    
    var flag = true
    
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var flagButton: UIButton!
    @IBOutlet weak var objectStepper: UIStepper!
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
        flagLabel.text = "Place Mode"
        objectStepper.isHidden = true
        objectStepper.maximumValue = Double(listNode.count)
        countLabel.text = String(objectStepper.value)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        //run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)

        sceneView.session.pause()
    }

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if anchor is ARPlaneAnchor {
            //create plane Anchor
            let planeAnchor = anchor as! ARPlaneAnchor
            let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
            
            //attach plane anchor to node
            let planeNode = SCNNode()
            planeNode.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
            planeNode.eulerAngles.x = -.pi/2
            
            //adding material to plane anchor
            let gridMaterial = SCNMaterial()
            gridMaterial.diffuse.contents = UIImage(named: "ARassets.scnassets/UMP45.(Girls.Frontline).full.2109431.jpg")
            plane.materials = [gridMaterial]
            planeNode.geometry = plane
            
            //add plane node to node as child node
            node.addChildNode(planeNode)
        }else{
            //return if doesn't find plane
            return
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if flag == false { return } else {
            if let touch = touches.first {
                let touchLocation = touch.location(in: sceneView)
                
                let result = sceneView.hitTest(touchLocation, types: .existingPlaneUsingGeometry)
                
                if let hitResult = result.first {
                    
                    let node = SCNNode()
                    node.position = SCNVector3(
                        hitResult.worldTransform.columns.3.x,
                        hitResult.worldTransform.columns.3.y,
                        hitResult.worldTransform.columns.3.z)
                    
                    let box = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0.02)
                    let material = SCNMaterial()
                    material.diffuse.contents = UIColor.red.withAlphaComponent(0.7)
                    box.materials = [material]
                    
                    node.geometry = box
                    
                    listNode.append(node)
                    
                    sceneView.scene.rootNode.addChildNode(node)
                    objectStepper.maximumValue = Double(listNode.count)
                    countLabel.text = String(objectStepper.value)
                    let listObject = Object(context: PersistanceService.context)
                    //conversi node dan box ke Binary Data
                    //let convertNode = node as NSData?
                    listObject.nama = "box\(listNode.count+1)"
                    //Save Object ke CoreData
                    //PersistanceService.saveContext()
                    
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if flag == true { return } else {
            //get The Current Touch Point
            guard let currentTouchPoint = touches.first?.location(in: self.sceneView),
                
            //get The Next Feature Point Etc
            let hitTest = sceneView.hitTest(currentTouchPoint, types: .existingPlane).first else { return }
            
            //convert To World Coordinates
            let worldTransform = hitTest.worldTransform
            
            //set The New Position
            let newPosition = SCNVector3(worldTransform.columns.3.x, worldTransform.columns.3.y, worldTransform.columns.3.z)
            
            //apply To The Node
            listNode[Int(objectStepper.value)].position = newPosition
            //print(objectStepper.value)
        }
    }
    
    @IBAction func flagButton(_ sender: Any) {
        if flag == true {
            flag = false
            flagLabel.text = "Edit Mode"
            flagButton.setTitle("Place", for: .normal)
            objectStepper.isHidden = false
        }else {
            flag = true
            flagLabel.text = "Place Mode"
            flagButton.setTitle("Edit", for: .normal)
            objectStepper.isHidden = true
        }
    }
}
