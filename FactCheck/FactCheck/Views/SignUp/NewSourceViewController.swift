//
//  NewSourceViewController.swift
//  FactCheck
//
//  Created by Med Aziz on 15/4/2022.
//

import UIKit

class NewSourceViewController: UIViewController {

    //var
    var utilisateur : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            }
    //ibAction
    @IBAction func NextButtonAction(_ sender: Any) {
       performSegue(withIdentifier: "CompliteAccountSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CompliteAccountSegue"{
        let destination = segue.destination as! FillProfileViewController
            destination.utilisateur = utilisateur
        }
    }
    
    
    
}
