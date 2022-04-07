//
//  ForgetPasswordSignInViewController.swift
//  FackChek
//
//  Created by Sinda Arous on 7/4/2022.
//

import UIKit

class ForgetPasswordSignInViewController: UIViewController {

    @IBOutlet weak var SendButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//button send modif
        SendButton.layer.cornerRadius = 15
        SendButton.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
