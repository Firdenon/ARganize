//
//  BaseObjectImag.swift
//  ARganize
//
//  Created by Kristopher Chayadi on 24/08/18.
//  Copyright © 2018 MC3 RE:ceh. All rights reserved.
//

import Foundation
import UIKit
import SceneKit


class BaseObjectImage {
    var node = SCNNode()
    var plane = SCNPlane()
    var image:UIImage
    var nama:String
    
    init(image: UIImage, nama: String, node: SCNNode, plane: SCNPlane)
    {
        self.image = image
        self.nama = nama
        self.node = node
        self.plane = plane
    }
}
