//
//  AccountUserViewController.swift
//  FactCheck
//
//  Created by Sinda Arous on 19/4/2022.
//

import UIKit

class AccountUserViewController: UIViewController {

    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var UserPhoneLabel: UILabel!
    @IBOutlet weak var UserEmailLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        UserPhoneLabel.text = String(UserDefaults.standard.integer(forKey: "phone"))
        UserNameLabel.text = UserDefaults.standard.string(forKey: "username")
        UserEmailLabel.text = UserDefaults.standard.string(forKey: "email")
    }
    

   

}
