//
//  CreateObject.swift
//  ARganize
//
//  Created by Kristopher Chayadi on 20/08/18.
//  Copyright © 2018 MC3 RE:ceh. All rights reserved.
//

import UIKit

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
        return 5
//        if pickerView.tag == 1{
//            return angkaDepan.count
//        }else{
//            return angkaBelakang.count
//        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return angkaDepan[row]
//        if pickerView.tag == 1{
//
//            return angkaDepan[row]
//        }
//        else {
//            return angkaBelakang[row]
//        }
    }
    
    
    @IBAction func createButton(_ sender: Any) {
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.isHidden = true
    }
    
}
