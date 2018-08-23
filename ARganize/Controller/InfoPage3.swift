//
//  InfoPage3.swift
//  ARganize
//
//  Created by Kristopher Chayadi on 15/08/18.
//  Copyright © 2018 MC3 RE:ceh. All rights reserved.
//

import UIKit

class InfoPage3: UIViewController {

    
    @IBOutlet weak var tekok: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
       
    }
    @IBAction func getStartedBtn(_ sender: Any) {
        let vc = MainARViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
