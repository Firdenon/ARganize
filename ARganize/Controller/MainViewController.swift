//
//  MainViewController.swift
//  ARganize
//
//  Created by Ricky Adi Kuncoro on 14/08/18.
//  Copyright © 2018 MC3 RE:ceh. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class BaseObjectLibrary{
    //NSOBject (ARKIT) -> panjang lebar tinggi
    var node = SCNNode() //Lokasi
    var box = SCNBox() //panjang lebar tinggi warna
    var nama:String = ""
    var flagScreenAppear:Bool = false
    
    
    init(node:SCNNode,box:SCNBox,nama:String){
        self.node = node
        self.box = box
        self.nama = nama
        self.flagScreenAppear = false
    }
    
    func refresh(){
        node.geometry = box
    }
    
}

class MainViewController: UIViewController {

    var listObject = [BaseObjectLibrary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        let newObject = BaseObjectLibrary(panjang: 5, lebar: 6, nama: "ASHOY", warna: UIColor.red.withAlphaComponent(0.6))
//
//        newObject.flagScreenAppear = false
//
//        listObject.append(newObject)
        
        
        let node = SCNNode()
        node.position = SCNVector3(x:1, y:1, z:0)
        let box = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.black
        box.materials = [material]
        
        node.geometry = box
        
        let newObject = BaseObjectLibrary(node: node,box:box,nama: "asoy")
        
        //edit size
        //pikirin edit pas uda di array
        newObject.box = SCNBox(width: 2, height: 3, length: 3, chamferRadius: 0)
        newObject.refresh()
        print(newObject.box.width)
        print(newObject.box.height)
        print(newObject.box.length)
        
        listObject.append(newObject)
        
        print(listObject[0].box.width)
        
    }



}
