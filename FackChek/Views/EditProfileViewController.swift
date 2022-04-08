//
//  EditProfileViewController.swift
//  FackChek
//
//  Created by Sinda Arous on 8/4/2022.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var updateButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        updateButton.layer.cornerRadius = updateButton.frame.width / 2
        updateButton.layer.masksToBounds = true
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
