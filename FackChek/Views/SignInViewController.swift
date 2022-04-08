//
//  SignInViewController.swift
//  FackChek
//
//  Created by Sinda Arous on 7/4/2022.
//

import UIKit

class SignInViewController: UIViewController {

    //ibOutlet
  
   
    @IBOutlet weak var RegisterButton: UIButton!
    @IBOutlet weak var SignInButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Sign in button cicle
        SignInButton.layer.cornerRadius = SignInButton.frame.width / 2
        SignInButton.layer.masksToBounds = true
        //register button
        RegisterButton.layer.cornerRadius = 10
        RegisterButton.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
   
  //Action
    @IBAction func forgetPasswordAction(_ sender: UIButton) {
        performSegue(withIdentifier:"ToForgetPasswordSignIn" , sender:
        true)
    }
    @IBAction func registerAction(_ sender: UIButton) {
        performSegue (withIdentifier:"ToRegister" , sender:
        true)
    }
}
