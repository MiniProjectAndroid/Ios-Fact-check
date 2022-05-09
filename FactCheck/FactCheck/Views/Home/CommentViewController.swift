//
//  CommentViewController.swift
//  FactCheck
//
//  Created by Sinda Arous on 3/5/2022.
//

import UIKit
import CoreData
class CommentViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate{

    
    var idnews: String?
    var newsViewModel = NewsViewModel()
    var postViewModel = PostViewModel()
    let userViewModel = UserViewModel()
    var posts = [Post]()
    
    @IBOutlet weak var textComment: UILabel!
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
 
    @IBOutlet weak var messageImage: UIImageView!
    @IBOutlet weak var backgroudImage: UIImageView!
    @IBOutlet weak var tableViewComment: UITableView!
    @IBOutlet weak var CommentTextField: UITextField!
    @IBOutlet weak var ButtonPostComment: UIButton!
    
    
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        ButtonPostComment.isHidden = true
        idnews =  (UserDefaults.standard.value( forKey: "idNews")  as! String)
        self.tableViewComment.isHidden = false
        self.backgroudImage.isHidden = true
        self.messageImage.isHidden = true
        self.textComment.isHidden = true
        ActivityIndicator.startAnimating()
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        tableViewComment.addGestureRecognizer(longPress)
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        initialize()
        self.tableViewComment.reloadData()
       
       // BookmarkButton.setBackgroundImage(bookMark, for: .normal)
    }
    @objc func longPress(sender: UILongPressGestureRecognizer) {

                if sender.state == UIGestureRecognizer.State.began {
                    let touchPoint = sender.location(in: tableViewComment)
                    if let indexPath = tableViewComment.indexPathForRow(at: touchPoint) {
                        if ( posts[indexPath.row].username! ==  UserDefaults.standard.string(forKey: "iduser"))
                        {
                        print("Long press Pressed:)")
                            showActionSheet(index:posts[indexPath.row]._id!,text:posts[indexPath.row].description!)
                        }else {
                            showActionSheet2(text:posts[indexPath.row].description!)
                        }
                    }
                }


            }
    
    func showActionSheet(index: String , text:String){
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        // create an action
        let firstAction: UIAlertAction = UIAlertAction(title: "Edit", style: .default) { action -> Void in
            self.showActionSheetUpdate(index: index , text:text)
            print("First Action pressed")
        }

        let secondAction: UIAlertAction = UIAlertAction(title: "Copy", style: .default) { action -> Void in
          
            UIPasteboard.general.string = text
            print("Second Action pressed")
        }
        
        let thirdAction: UIAlertAction = UIAlertAction(title: "Delete", style: .destructive) { action -> Void in
            self.deletItem(id: index)
            print("third Action pressed")
        }

        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }

        // add actions
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(secondAction)
        actionSheetController.addAction(thirdAction)
        actionSheetController.addAction(cancelAction)

        present(actionSheetController, animated: true) {
            print("option menu presented")
        }
       
    }
    
    func showActionSheet2(text:String){
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        // create an action
      

        let secondAction: UIAlertAction = UIAlertAction(title: "Copy", style: .default) { action -> Void in
            UIPasteboard.general.string = text
            print("Second Action pressed")
        }
        
       

        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }

        // add actions
      
        actionSheetController.addAction(secondAction)
        actionSheetController.addAction(cancelAction)
        present(actionSheetController, animated: true) {
            print("option menu presented")
        }
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let contentView = cell?.contentView
       
       
        let DesriptionLabel = contentView?.viewWithTag(1) as! UILabel
        let TimeLabel = contentView?.viewWithTag(2) as! UILabel
        let imageUser = contentView?.viewWithTag(3) as! UIImageView
        
        
        let post = posts[indexPath.row]
        
        let id = post.username
        userViewModel.getUserByID(id: id! ,completed: { (success, reponse) in
            
            if success {
                let user = reponse as! User
                //NameLabel.text = user.username!
                let url = URL(string: user.idPhoto!)!

                          // Fetch
                       if let data = try? Data(contentsOf: url ) {
                           imageUser.image = UIImage(data: data )
                       }
              // .image = UIImage(user.idPhoto)
                
                print (user)
            }})
        
        DesriptionLabel.text = post.description!
        TimeLabel.text = post.dateOfPosting!
        return cell!
    }

    
    func deletItem(id: String)
    {
        
        postViewModel.deletePost(id: id ,completed: { [self] (success) in
            
            if success {
        //print("here")
                initialize()
                //self.tableViewComment.reloadData()
               
            }})
    }
    func updatItem(id: String,description:String)
    {
        
        postViewModel.updatePost(id: id ,description:description,completed: {  (success) in
           // print(description)
           // print(id)
            if success {
                //initialize()
              // print("yes")
            }})
    }
    func initialize() {
        
        postViewModel.recupererPostByIDNews(id: idnews! ,completed: { [self] (success, reponse) in
            
            if success {
        //print("here")
                if (reponse?.isEmpty == true){
                    self.posts = reponse!
                    self.tableViewComment.reloadData()
                    self.ActivityIndicator.stopAnimating()
                    self.ActivityIndicator.hidesWhenStopped = true
                    self.tableViewComment.isHidden = true
                    self.backgroudImage.isHidden = false
                    self.messageImage.isHidden = false
                    self.textComment.isHidden = false
                }else {
                    self.posts = reponse!
                    self.tableViewComment.reloadData()
                    self.ActivityIndicator.stopAnimating()
                    self.ActivityIndicator.hidesWhenStopped = true
                    self.backgroudImage.isHidden = true
                    self.messageImage.isHidden = true
                    self.textComment.isHidden = true
                    self.tableViewComment.isHidden = false
                }
               
            }})
        }
    
    
    
    
    @IBAction func editingChange(_ sender: Any) {
        if (CommentTextField.text?.isEmpty == true)
        {ButtonPostComment.isHidden = true
        }else {ButtonPostComment.isHidden = false}
    }
    
    @IBAction func AddPostButton(_ sender: UIButton) {
        
       
        var idUser = (UserDefaults.standard.value( forKey: "iduser")as! String)
        postViewModel.addPost(user: idUser  ,news: idnews! ,description: CommentTextField.text!,completed: { [self] (success, reponse) in
            
            if success {
                print("add succefuly ")
                initialize()
                self.tableViewComment.reloadData()
                CommentTextField.text = ""
                ButtonPostComment.isHidden = true
                
            }})
        }
        
    
    func showActionSheetUpdate(index: String , text:String){
        let actionSheetController = UIAlertController(title: "New Folder", message: "name this folder", preferredStyle: .alert)

        actionSheetController.addTextField { (textField) in
            // configure the properties of the text field
            textField.placeholder = "description Post "
            textField.text = text
        }
    
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in

            // this code runs when the user hits the "save" button

            self.updatItem(id: index,description:text)

        }

        actionSheetController.addAction(cancelAction)
        actionSheetController.addAction(saveAction)

        present(actionSheetController, animated: true, completion: nil)
       
    }

}
