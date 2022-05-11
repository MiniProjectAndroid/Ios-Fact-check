//
//  DoYouViewController.swift
//  FactCheck
//
//  Created by Med Aziz on 12/4/2022.
//

import UIKit

class DoYouViewController: UIViewController {
    
    //var
    var utilisateur = User()

    //iboutlet
    @IBOutlet var viewAgency: UIView!
    @IBOutlet var viewPersonal: UIView!
    
    @IBOutlet var imageAgency: UIImageView!
    @IBOutlet var imagePersonal: UIImageView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createAccountSegue" {
            let destination = segue.destination as! CreateAccountViewController
            destination.utilisateur = utilisateur
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        utilisateur.role = "Personal"
        }
    
    //ibAction
    @IBAction func AgencyButtonAction(_ sender: Any) {
        imageAgency.tintColor = UIColor(red: 0.93, green: 0.50, blue: 0.45, alpha: 1.00)
        imagePersonal.tintColor = UIColor(red: 0.99, green: 0.95, blue: 0.95, alpha: 1.00)
        utilisateur.role = "Agency"
    }
    
    @IBAction func PersonalButtonAction(_ sender: Any) {
        imagePersonal.tintColor = UIColor(red: 0.93, green: 0.50, blue: 0.45, alpha: 1.00)
        imageAgency.tintColor = UIColor(red: 0.99, green: 0.95, blue: 0.95, alpha: 1.00)
        utilisateur.role = "Personal"
    }
    
    @IBAction func ContinueButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "createAccountSegue", sender: utilisateur)
    }
}
