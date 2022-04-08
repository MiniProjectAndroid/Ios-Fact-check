//
//  ChangePasswordViewController.swift
//  FackChek
//
//  Created by Sinda Arous on 8/4/2022.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var updateButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateButton.layer.cornerRadius = updateButton.frame.width / 2
        updateButton.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    

  

}
