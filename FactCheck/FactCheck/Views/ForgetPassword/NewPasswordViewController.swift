//
//  NewPasswordViewController.swift
//  FactCheck
//
//  Created by Med Aziz on 21/4/2022.
//

import UIKit
import ShowPasswordTextField
class NewPasswordViewController: UIViewController {

    
    //var
    let userViewModel = UserViewModel()
    
    
    //outlet
    
    @IBOutlet var ConfirmPasswordTextField: UITextField!
    
    @IBOutlet var NewPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //action
    @IBAction func SendAction(_ sender: Any) {
        if (ConfirmPasswordTextField.text!.isEmpty){
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type your Old Password "), animated: true)
            return
        }
        if (NewPasswordTextField.text!.isEmpty){
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type your New Password "), animated: true)
            return
        }
        if (NewPasswordTextField.text! != ConfirmPasswordTextField.text!){
            self.present(Alert.makeAlert(titre: "Warning", message: "Please verify your confirm password "), animated: true)
            return
        }
        
        let email = UserDefaults.standard.string(forKey: "email")
        userViewModel.changePassword(email: email!,  newpassword: NewPasswordTextField.text!, completed: { (success) in
            
            if success {
                self.performSegue(withIdentifier: "afficheYesPassword", sender: sender)
                
                //self.present(Alert.makeAlert(titre: "yes", message: "Email et password correct ."), animated: true)
            } else {
                self.present(Alert.makeAlert(titre: "Avertissement", message: "Email ou mot de passe incorrect."), animated: true)
            }
        })
    }
    
}
