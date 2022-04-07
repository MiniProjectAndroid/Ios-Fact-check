//
//  ViewController.swift
//  FackChek
//
//  Created by Mac-Mini-2021 on 07/04/2022.
//

import UIKit

class ViewController: UIViewController {

    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SkipButton(_ sender: UIButton) {
        performSegue(withIdentifier:"ToSignIn" , sender:
        true)
    }
    
   
    


}

