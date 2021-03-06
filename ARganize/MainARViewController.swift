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


class MainARViewController: UIViewController, ARSCNViewDelegate, CreateObjectDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    
    //var listNode = [SCNNode]()
    var arrayOfBaseObject = [BaseObjectLibrary]()
    var arrayOfImage = [BaseObjectImage]()
    
    let imagePicker = UIImagePickerController()
    var flag = true
    
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var flagButton: UIButton!
    @IBOutlet weak var objectStepper: UIStepper!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var createObjectView: CreateObject!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
        flagLabel.text = "Place Mode"
        //objectStepper.isHidden = true
        
        createObjectView.vcDelegate = self
        objectStepper.maximumValue = 0
        
        countLabel.text = String(Int(objectStepper.value))
        
        imagePicker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .vertical
        
        //run the view's session
        sceneView.session.run(configuration)
        
        //okcreateObjectView.widthLbl.text = "Iseng"
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
            gridMaterial.diffuse.contents = UIImage(named: "ARassets.scnassets/grid.png")
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
                    
//                    let node = SCNNode()
//                    node.position = SCNVector3(
//                        hitResult.worldTransform.columns.3.x,
//                        hitResult.worldTransform.columns.3.y,
//                        hitResult.worldTransform.columns.3.z)
//
//                    let box = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0.02)
//                    let material = SCNMaterial()
//                    material.diffuse.contents = UIColor.red.withAlphaComponent(0.7)
//                    box.materials = [material]
//
//                    node.geometry = box
//
//                    listNode.append(node)
//
//                    sceneView.scene.rootNode.addChildNode(node)
//                    objectStepper.maximumValue = Double(listNode.count)
//                    countLabel.text = String(objectStepper.value)
                    
                    
                    if arrayOfImage.isEmpty == true {
                        print("datakosong")
                        //bikin alert item kosong
                    }
                    else {
                        arrayOfImage[Int(objectStepper.value)].node.position = SCNVector3(
                            hitResult.worldTransform.columns.3.x,
                            hitResult.worldTransform.columns.3.y,
                            hitResult.worldTransform.columns.3.z)
                        sceneView.scene.rootNode.addChildNode(arrayOfImage[Int(objectStepper.value)].node)
                        print(arrayOfImage[Int(objectStepper.value)].nama)
                    }
                    //Core Data
                    //let listObject = Object(context: PersistanceService.context)
                    //conversi node dan box ke Binary Data
                    //let convertNode = node as NSData?
                    //listObject.nama = "box\(listNode.count+1)"
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
            if arrayOfBaseObject.isEmpty == true { return } else {
                arrayOfBaseObject[Int(objectStepper.value)].node.position = newPosition
            }
        }
    }
    
    
    @IBAction func rotateNode(_ sender: UIRotationGestureRecognizer) {
        if flag == true { return } else {
            
            print("muter jalan")
            
//            var currentAngleY = listNode[Int(objectStepper.value)].eulerAngles.y
//
//            //1. Get The Current Rotation From The Gesture
//            let rotation = Float(sender.rotation)
//
//            //2. If The Gesture State Has Changed Set The Nodes EulerAngles.y
//            if sender.state == .changed{
//
//                listNode[Int(objectStepper.value)].eulerAngles.y = currentAngleY + rotation
//            }
//
//            //3. If The Gesture Has Ended Store The Last Angle Of The Cube
//            if(sender.state == .ended) {
//                currentAngleY = listNode[Int(objectStepper.value)].eulerAngles.y
//            }
        }
    }
    
    @IBAction func flagButton(_ sender: Any) {
        if flag == true {
            flag = false
            flagLabel.text = "Edit Mode"
            flagButton.setTitle("Place", for: .normal)
            //objectStepper.isHidden = false
        }else {
            flag = true
            flagLabel.text = "Place Mode"
            flagButton.setTitle("Edit", for: .normal)
            //objectStepper.isHidden = true
        }
    }
    
    @IBAction func createObjectBtn(_ sender: Any) {
        //createObjectView.isHidden = false
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
  
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage]  as? UIImage else {
            return
        }
        selectedImageView.image = image
        
        dismiss(animated:true, completion: nil)
        
        let imageWidth = image.size.width / 1000
        let imageHeight = image.size.height / 1000
        print("Size Gambar : \(imageWidth),\(imageHeight)")
        let node = SCNNode()
        let plane = SCNPlane(width: imageWidth, height: imageHeight)
        let material = SCNMaterial()
        material.diffuse.contents = image
        plane.materials = [material]
        node.geometry = plane
        
        let newBaseImage = BaseObjectImage(image: image, nama: "Gambar", node: node, plane: plane)
        arrayOfImage.append(newBaseImage)
        objectStepper.maximumValue = Double(arrayOfImage.count - 1)
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        countLabel.text = Int(sender.value).description
    }
    
    func changeMaxStepper(object: BaseObjectLibrary) {
        arrayOfBaseObject.append(object)
        objectStepper.maximumValue = Double(arrayOfBaseObject.count - 1)
    }
    
    @IBAction func sukurinShotto(_ sender: Any) {
        let image = sceneView.snapshot()
        
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
        
//        let alert = UIAlertController(title: "Screenshot Saved!", message: nil, preferredStyle: UIAlertController.Style.alert)
//
//        present(alert,animated:true,completion:nil)
        let alertController = UIAlertController(title:"Screenshot Saved!",message:nil,preferredStyle:.alert)
        self.present(alertController,animated:true,completion:{Timer.scheduledTimer(withTimeInterval: 0.5, repeats:false, block: {_ in
            self.dismiss(animated: true, completion: nil)})})
        
        
        
        }
}
    
    


