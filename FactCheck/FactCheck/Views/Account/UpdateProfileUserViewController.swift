//
//  UpdateProfileUserViewController.swift
//  FactCheck
//
//  Created by Sinda Arous on 19/4/2022.
//

import UIKit

class UpdateProfileUserViewController: UIViewController {

    var user: User?
    @IBOutlet weak var TextFieldUserName: UITextField!
    @IBOutlet weak var TextFieldEmail: UITextField!
   
    @IBOutlet weak var TextFieldPhone: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        TextFieldPhone.text = String(UserDefaults.standard.integer(forKey: "phone"))
        TextFieldUserName.text = UserDefaults.standard.string(forKey: "username")
        TextFieldEmail.text = UserDefaults.standard.string(forKey: "email")
    }
    @IBAction func ModifButtonAction(_ sender: Any) {
        if (TextFieldUserName.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Error", message: "Please type your username "), animated: true)
            return
        }
        
        if (TextFieldEmail.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Error", message: "Please type your email"), animated: true)
            return
        }
        
        if (TextFieldPhone.text!.isEmpty ){
            self.present(Alert.makeAlert(titre: "Error", message: "Please choose your phone"), animated: true)
            return
        }
        
        user?.username = TextFieldUserName.text
        user?.email = TextFieldEmail.text
        user?._id = UserDefaults.standard.string(forKey: "_id")
        
        UserViewModel().modifUser(email : TextFieldEmail.text! , username: TextFieldUserName.text! , phone: Int(TextFieldPhone.text!)! , completed: { (success) in
            
                UserDefaults.standard.setValue(self.TextFieldPhone.text, forKey: "phone")
                UserDefaults.standard.setValue(self.TextFieldEmail.text, forKey: "email")
                UserDefaults.standard.setValue(self.TextFieldUserName.text, forKey: "username")
                self.performSegue(withIdentifier: "ToProfileSegue", sender: nil)
           
        })
        
    }
    

    
}
