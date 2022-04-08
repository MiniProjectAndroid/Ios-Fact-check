//
//  RegisterViewController.swift
//  FackChek
//
//  Created by Sinda Arous on 7/4/2022.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var RegisterButton: UIButton!
 
    @IBOutlet weak var SwitchRole: UISwitch!
    
    @IBOutlet weak var RoleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //register button shap
        RegisterButton.layer.cornerRadius = 10
        RegisterButton.layer.masksToBounds = true
       
        // Do any additional setup after loading the view.
    }
   
    
    @IBAction func SwitchAction(_ sender: UISwitch) {
        if SwitchRole.isOn {
            RoleLabel.text = "Utilisateur"
        } else {
            RoleLabel.text = "Source"
        }
    }
   
    @IBAction func registerAction(_ sender: Any) {
        if RoleLabel.text == "Utilisateur" {
        performSegue(withIdentifier:"ToTabBarUtilisateur" , sender:true)}else{
            performSegue(withIdentifier:"ToTabBarSource" , sender:true)
                        }
    }
    
  
}
