//
//  DetailNewsViewController.swift
//  FactCheck
//
//  Created by Sinda Arous on 21/4/2022.
//

import UIKit

class DetailNewsViewController: UIViewController {
    //var
    var newsViewModel = NewsViewModel()
    
    var postViewModel = PostViewModel()
    let userViewModel = UserViewModel()
    var name :String = ""
    var image :String = ""
    var time : String = ""
    var user : String = ""
    var descrip : String = ""
    var idNews : String = ""
    var comment: String  = ""
    //outlet
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var timeNews: UILabel!
    @IBOutlet weak var CommentNews: UILabel!
    @IBOutlet weak var descriptionNews: UITextView!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var usernameNews: UILabel!
    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var likeNews: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //UserDefaults.standard.setValue("", forKey: "idNews")
       // print(idNews)
        titleNews.text = name
        
        //usernameNews.text = user
        timeNews.text = time
        descriptionNews.text = descrip
        if ( user == "La presse"){
            
            
            usernameNews.text = user
            
            
           
            let url = URL(string: "https://lapresse.tn/wp-content/uploads/2019/04/FREE-LOGO-MOCKUP-1-500x500.png")!

                      // Fetch
                   if let data = try? Data(contentsOf: url ) {
                       imageUser.image = UIImage(data: data )
                   }
            
            
            
        }
        else {
            let id = user
            userViewModel.getUserByID(id: id ,completed: { [self] (success, reponse) in
                
                if success {
                    let user = reponse as! User
                    usernameNews.text = user.username!
                    let url = URL(string: user.idPhoto!)!

                              // Fetch
                           if let data = try? Data(contentsOf: url ) {
                               imageUser.image = UIImage(data: data )
                           }
                    print (user)
                }})
        }
        
        
        let url = URL(string: image)!

        if let data = try? Data(contentsOf: url ) {
            imageNews.image = UIImage(data: data )
        }
        imageUser.layer.cornerRadius = imageUser.frame.size.width/2
        imageUser.clipsToBounds = true
        imageUser.layer.borderWidth = 3
        imageUser.layer.borderColor = #colorLiteral(red: 0.9998074174, green: 0.4096120298, blue: 0.3797409534, alpha: 1)
        
        postViewModel.countPost(id:idNews ,completed: { [self] (success, reponse) in
            if success {
                 comment = reponse as! String
              //print(reponse)
                 //comment = count
                //print(count)
                CommentNews.text = comment
               //s CommentLabel.text = String(count) ?? ""
               // print(reponse)
            }
            else {
               // print(reponse)
            }
        })
    }
    @IBAction func ShareButton(_ sender: Any) {
        let activitytVC = UIActivityViewController(activityItems: [self.titleNews.text,self.descriptionNews.text], applicationActivities: nil)
        activitytVC.popoverPresentationController?.sourceView = self.view
        self.present(activitytVC,animated: true , completion: nil)
    }
    @IBAction func buttonComment(_ sender: Any) {
        self.performSegue(withIdentifier: "Comment", sender: 0)
        //print(UserDefaults.standard.value( forKey: "idNews"))
        //
    }
    
  
}
