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
    @IBOutlet weak var countNews: UILabel!
    
    @IBOutlet weak var imageUser: UIImageView!
    //var
    
    var Link : String?
    var newsViewModel = NewsViewModel()
    var news: String  = ""
    override func viewDidLoad() {
        newsViewModel.countNews(id: UserDefaults.standard.string(forKey: "iduser")!,completed: { [self] (success, reponse) in
            if success {
                news = reponse as! String
              //print(reponse)
                 //comment = count
                //print(count)
                countNews.text = news
               //s CommentLabel.text = String(count) ?? ""
               // print(reponse)
            }
            else {
               // print(reponse)
            }
        })
        super.viewDidLoad()
        PhoneUserLabel.text = String(UserDefaults.standard.integer(forKey: "phone"))
        UsernameLabel.text = UserDefaults.standard.string(forKey: "username")
        DescriptionUserLabel.text = UserDefaults.standard.string(forKey: "description")
        EmailUserLabel.text = UserDefaults.standard.string(forKey: "email")
        Link = UserDefaults.standard.string(forKey: "link")
       // print("photo" + UserDefaults.standard.string(forKey: "photo")!)
        if (UserDefaults.standard.string(forKey: "photo") != nil){
        let url = URL(string: host + UserDefaults.standard.string(forKey: "photo")!)!

                  // Fetch
               if let data = try? Data(contentsOf: url ) {
                   imageUser.image = UIImage(data: data )
               }
    }
        else {
            imageUser.image = UIImage(systemName:"person")
        }
       // print("photo" + UserDefaults.standard.string(forKey: "photo")!)
        
    }
    
    @IBAction func linkWebSite(_ sender: Any) {
        UIApplication.shared.open(URL(string:Link!)! as URL ,options: [:], completionHandler: nil)
        
        
    }
    
    

   

}
