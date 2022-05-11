//
//  HomeViewController.swift
//  FactCheck
//
//  Created by Med Aziz on 12/4/2022.
//

import UIKit
import CoreData
import InputBarAccessoryView

class HomeViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate{
    
    //outlet
    //let host = "http://172.17.8.0:3000/"
    @IBOutlet weak var tableViewNews: UITableView!
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var search: UITextField!
    //var
    var newsViewModel = NewsViewModel()
    var postViewModel = PostViewModel()
    let cellSpacingHeight: CGFloat = 250
    let userViewModel = UserViewModel()
    var news = [News]()
    var selectedBook: Book? = nil
    var mark = false
    var comment: String  = ""
    //let host = "http://localhost:3000/"
    let bookMark = UIImage(systemName: "bookmark")
    let bookMarkFill = UIImage(systemName: "bookmark.fill")
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let contentView = cell?.contentView
       
        let imageNews = contentView?.viewWithTag(6) as! UIImageView
        let TitleLabel = contentView?.viewWithTag(1) as! UILabel
        let TimeLabel = contentView?.viewWithTag(2) as! UILabel
        let NameLabel = contentView?.viewWithTag(3) as! UILabel
        let LikeLabel = contentView?.viewWithTag(4) as! UILabel
        let CommentLabel = contentView?.viewWithTag(5) as! UILabel
        let imageUser = contentView?.viewWithTag(7) as! UIImageView
       
       
            
        let new = news[indexPath.row]
        /**/
       
        
        if ( new.username == "La presse"){
            
            NameLabel.text = new.username!
            let url = URL(string: "https://lapresse.tn/wp-content/uploads/2019/04/FREE-LOGO-MOCKUP-1-500x500.png")!

                      // Fetch
                   if let data = try? Data(contentsOf: url ) {
                       imageUser.image = UIImage(data: data )
                   }
            let url2 = URL(string: new.image!)!

                      // Fetch
                   if let data2 = try? Data(contentsOf: url2 ) {
                       imageNews.image = UIImage(data: data2 )
                   }
        }
        else {
            let url = URL(string: host + new.image!)!

                      // Fetch
                   if let data = try? Data(contentsOf: url ) {
                       imageNews.image = UIImage(data: data )
                   }
            let id = new.username
            userViewModel.getUserByID(id: id! ,completed: { [self] (success, reponse) in
                
                if success {
                    let user = reponse as! User
                    NameLabel.text = user.username!
                    let url = URL(string: host + user.idPhoto!)!

                              // Fetch
                           if let data = try? Data(contentsOf: url ) {
                               imageUser.image = UIImage(data: data )
                           }
                  // .image = UIImage(user.idPhoto)
                    
                    print (user)
                }})
        }
    
     
        
        
        //cell?.contentView.layer.borderColor = UIColor.black.cgColor
        //cell?.contentView.layer.borderWidth = 1.0
        imageUser.layer.cornerRadius = imageUser.frame.size.width/2
        imageUser.clipsToBounds = true
        imageUser.layer.borderWidth = 3
        imageUser.layer.borderColor = #colorLiteral(red: 0.9998074174, green: 0.4096120298, blue: 0.3797409534, alpha: 1)
        
        TimeLabel.text = new.date!
        TitleLabel.text = new.title!
        LikeLabel.text = new.like!
       
        postViewModel.countPost(id:new._id! ,completed: { [self] (success, reponse) in
            if success {
                 comment = reponse as! String
              //print(reponse)
                 //comment = count
                //print(count)
                CommentLabel.text = comment
               //s CommentLabel.text = String(count) ?? ""
               // print(reponse)
            }
            else {
               // print(reponse)
            }
        })
     
        return cell!
    }
   
        
    override func viewDidLoad() {
       // UserDefaults.standard.setValue("", forKey: "idNews")
        super.viewDidLoad()
        ActivityIndicator.startAnimating()
       
    }
   
      
    override func viewDidAppear(_ animated: Bool) {
        initialize()
       // BookmarkButton.setBackgroundImage(bookMark, for: .normal)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
            performSegue(withIdentifier: "DetailNewsSegue", sender: indexPath)
            
            
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "DetailNewsSegue"{
                let indexPath = sender as! IndexPath
                let destination = segue.destination as! DetailNewsViewController
                destination.name = news[indexPath.row].title!
                destination.time = news[indexPath.row].date!
                destination.user = news[indexPath.row].username!
                destination.image = news[indexPath.row].image!
                destination.descrip = news[indexPath.row].description!
                destination.idNews = news[indexPath.row]._id!
               
                UserDefaults.standard.setValue(news[indexPath.row]._id!, forKey: "idNews")
            }
        }
  
    
    //function
    func initialize() {
        NewsViewModel.sharedInstance.recupererToutNews() { success, newsfromRep in
            if success {
                self.news = newsfromRep!
                self.tableViewNews.reloadData()
                self.ActivityIndicator.stopAnimating()
                self.ActivityIndicator.hidesWhenStopped = true 
            }else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not load News "),animated: true)
            }
        }
    }
    
    
    
    
 
}
