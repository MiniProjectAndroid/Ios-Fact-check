//
//  CreateAccountViewController.swift
//  FactCheck
//
//  Created by Med Aziz on 12/4/2022.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    
    //outlet
    @IBOutlet var checkboxRemeberMe: UIButton!
    
    //var
    var flage = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //ibAction
    @IBAction func remeberMeAction(_ sender: UIButton) {
        if (flage == false){
            sender.setBackgroundImage(UIImage(systemName: "square"), for: UIControl.State.normal)
            flage = true
        }else{
            sender.setBackgroundImage(UIImage(systemName: "checkmark.square"), for: UIControl.State.normal)
            flage = false
        }
    }
    
   
    
}
