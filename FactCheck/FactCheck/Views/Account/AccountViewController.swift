//
//  AccountViewController.swift
//  FactCheck
//
//  Created by Sinda Arous on 12/4/2022.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var UsernameLabel: UILabel!
    @IBOutlet weak var DescriptionUserLabel: UITextView!
    @IBOutlet weak var EmailUserLabel: UILabel!
    @IBOutlet weak var PhoneUserLabel: UILabel!
    
    @IBOutlet weak var imageUser: UIImageView!
    //var
    
    var Link : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PhoneUserLabel.text = String(UserDefaults.standard.integer(forKey: "phone"))
        UsernameLabel.text = UserDefaults.standard.string(forKey: "username")
        DescriptionUserLabel.text = UserDefaults.standard.string(forKey: "description")
        EmailUserLabel.text = UserDefaults.standard.string(forKey: "email")
        Link = UserDefaults.standard.string(forKey: "link")
       // print("photo" + UserDefaults.standard.string(forKey: "photo")!)
        if (UserDefaults.standard.string(forKey: "photo") != nil){
        let url = URL(string: UserDefaults.standard.string(forKey: "photo")!)!

                  // Fetch
               if let data = try? Data(contentsOf: url ) {
                   imageUser.image = UIImage(data: data )
               }
    }
        else {
            imageUser.image = UIImage(systemName:"person")
        }
        
    }
    
    @IBAction func linkWebSite(_ sender: Any) {
        UIApplication.shared.open(URL(string:Link!)! as URL ,options: [:], completionHandler: nil)
        
        
    }
    
    

   

}
