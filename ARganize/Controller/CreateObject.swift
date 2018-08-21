//
//  CreateObject.swift
//  ARganize
//
//  Created by Kristopher Chayadi on 20/08/18.
//  Copyright © 2018 MC3 RE:ceh. All rights reserved.
//

import UIKit
import SceneKit

class CreateObject: UIView,UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    
    @IBOutlet weak var widthDepan: UIPickerView!
    @IBOutlet weak var widthBelakang: UIPickerView!
    @IBOutlet weak var lengthDepan: UIPickerView!
    @IBOutlet weak var lengthBelakang: UIPickerView!
    @IBOutlet weak var heightDepan: UIPickerView!
    @IBOutlet weak var heightBelakang: UIPickerView!
    
    var angkaDepan:[String] = ["0","1","2","3","4","5"]
    var angkaBelakang:[String] = ["0","1","2","3","4","5","6","7","8","9"]
    
    @IBOutlet var view: UIView!
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        UINib(nibName: "CreateObject", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        
        
        widthDepan.delegate = self
        lengthDepan.delegate = self
        heightDepan.delegate = self
        widthDepan.dataSource = self
        lengthDepan.dataSource = self
        heightDepan.dataSource = self
        
        widthBelakang.delegate = self
        lengthBelakang.delegate = self
        heightBelakang.delegate = self
        widthBelakang.dataSource = self
        lengthBelakang.dataSource = self
        heightBelakang.dataSource = self
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //var countRow:Int = angkaBelakang.count
        
        if pickerView.tag == 1{
            return angkaDepan.count
        }else{
            return angkaBelakang.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //return angkaDepan[row]
        if pickerView.tag == 1{

            return angkaDepan[row]
        }
        else {
            return angkaBelakang[row]
        }
    }
    
    
    @IBAction func createButton(_ sender: Any) {
        let width:String = "\(widthDepan.selectedRow(inComponent: 0)).\(widthBelakang.selectedRow(inComponent: 0))"
        let length:String = "\(lengthDepan.selectedRow(inComponent: 0)).\(lengthBelakang.selectedRow(inComponent: 0))"
        let height:String = "\(heightDepan.selectedRow(inComponent: 0)).\(heightBelakang.selectedRow(inComponent: 0))"
        
        let floatWidth = (width as NSString).floatValue
        let floatLength = (length as NSString).floatValue
        let floatHeight = (height as NSString).floatValue
        
        let node = SCNNode()
        let box = SCNBox(width: CGFloat(floatWidth), height: CGFloat(floatHeight), length: CGFloat(floatLength), chamferRadius: 0.02)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.red.withAlphaComponent(0.7)
        box.materials = [material]
        
        node.geometry = box
        
        let newBaseObject = BaseObjectLibrary(node: node, box: box, nama: "Yattazo!")
        
        MainARViewController.arrayOfBaseObject.append(newBaseObject)
        
        
        self.isHidden = true
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.isHidden = true
    }
    
}
