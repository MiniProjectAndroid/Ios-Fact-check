//
//  CreateAccountViewController.swift
//  FactCheck
//
//  Created by Med Aziz on 12/4/2022.
//

import UIKit
import ShowPasswordTextField
class CreateAccountViewController: UIViewController {
    
    
    //outlet
    @IBOutlet var EmailTextFieldCreateAccount: UITextField!
    @IBOutlet var SignUpButton: UIButton!
    @IBOutlet var PasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    //var
    var utilisateur: User?

    override func viewDidLoad() {
      
        super.viewDidLoad()
        self.hideKeyboard()
    }
    

    //ibAction
    @IBAction func SignUpButtonAction(_ sender: Any) {
        if (EmailTextFieldCreateAccount.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type your Email"), animated: true)
            return
        }
        if (PasswordTextField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type your Password"), animated: true)
            return
        }
        if (confirmPasswordTextField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type your Password"), animated: true)
            return
        }
        if (confirmPasswordTextField.text! != PasswordTextField.text! ) {
            self.present(Alert.makeAlert(titre: "Warning", message: "Please verify  your confrim Password"), animated: true)
            return
        }
        utilisateur?.password = PasswordTextField.text
        utilisateur?.email = EmailTextFieldCreateAccount.text
        let controller = AppStoryboard.Main.instance.instantiateViewController(identifier: "CountryController") as? CountryViewController
        controller?.utilisateur = utilisateur
        self.navigationController?.pushViewController(controller!, animated: true)
        
    }
    
}
