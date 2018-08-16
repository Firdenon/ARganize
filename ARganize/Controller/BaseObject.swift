//
//  baseObject.swift
//  ARganize
//
//  Created by Kristopher Chayadi on 16/08/18.
//  Copyright © 2018 MC3 RE:ceh. All rights reserved.
//

import Foundation
import ARKit
import UIKit
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
