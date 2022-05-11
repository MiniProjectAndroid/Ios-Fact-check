//
//  DetailNewsUserViewController.swift
//  FactCheck
//
//  Created by Sinda Arous on 29/4/2022.
//

import UIKit

class DetailNewsUserViewController: UIViewController {

    
    //var
    var newsViewModel = NewsViewModel()
    let userViewModel = UserViewModel()
    var name :String = ""
    var image :String = ""
    var time : String = ""
    var user : String = ""
    var descrip : String = ""
    //iboutlet
    @IBOutlet weak var dateNews: UILabel!
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var descriptionNews: UITextView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var commentButton: UIButton!
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleNews.text = name
        dateNews.text = time
        descriptionNews.text = descrip
        if ( user == "La presse"){ username.text = user}
        else {
            let id = user
            userViewModel.getUserByID(id: id ,completed: { [self] (success, reponse) in
                if success {
                    let user = reponse as! User
                    username.text = user.username!
                    let url = URL(string: host + user.idPhoto!)!
                           if let data = try? Data(contentsOf: url ) {
                               imageUser.image = UIImage(data: data )
                           }
                    print (user)
                }})
        }
        let url = URL(string: host + image)!
        if let data = try? Data(contentsOf: url ) {
            imageNews.image = UIImage(data: data )
        }
      
    }
    
    
    
    //ibaction
    @IBAction func CommentButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: "Comment", sender: 0)
    }
    
    
    
}
