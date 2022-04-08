//
//  AccountViewController.swift
//  FackChek
//
//  Created by Sinda Arous on 8/4/2022.
//

import UIKit

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    @IBAction func EditProfileButton(_ sender: UIButton) {
        performSegue(withIdentifier:"ToEditProfile" , sender:
        true)
    }
    @IBAction func ChangePasswordButton(_ sender: Any) {
        performSegue(withIdentifier:"ToChangePassword" , sender:
        true)
        
    }
    
}
