//
//  ListViewController.swift
//  FactCheck
//
//  Created by Sinda Arous on 12/4/2022.
//

import UIKit

import CoreData
class ListViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate{

  //outlet
    @IBOutlet weak var tableViewNews: UITableView!
    @IBOutlet weak var notifLabel: UILabel!
    @IBOutlet weak var imagebackground: UIImageView!
    @IBOutlet weak var buttonAdd: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var addButtonCaree: UIButton!
    
    //var
    var newsViewModel = NewsViewModel()
    var userViewModel = UserViewModel()
    var newsUser = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        tableViewNews.reloadData()
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initialize()
    }
    
    //widget
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! NewsListTableViewCell
        let newUser = newsUser[indexPath.row]
        let url = URL(string: newUser.image!)!
               if let data = try? Data(contentsOf: url ) {
                   cell.imageNews.image = UIImage(data: data )
               }
            let id = newUser.username
            userViewModel.getUserByID(id: id! ,completed: {  (success, reponse) in
                if success {
                    let user = reponse as! User
                    cell.usernameNews.text = user.username!
                    let url = URL(string: user.idPhoto!)!
                           if let data = try? Data(contentsOf: url ) {
                               cell.imageUser.image = UIImage(data: data )
                           }
                }})
        cell.dateNews.text = newUser.date
        cell.titleNews.text = newUser.title
        cell.likeNews.text = newUser.like
        cell.commentaireNews.text = newUser.comment
        cell.modifButton.addTarget(self, action: #selector(addtoButton), for: .touchUpInside)
        return cell
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailNewsList", sender: indexPath)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailNewsList"{
            let indexPath = sender as! IndexPath
            let destination = segue.destination as! DetailNewsUserViewController
            destination.name = newsUser[indexPath.row].title!
            destination.time = newsUser[indexPath.row].date!
            destination.user = newsUser[indexPath.row].username!
            destination.image = newsUser[indexPath.row].image!
            destination.descrip = newsUser[indexPath.row].description!
            
        }
    }
    
    func tableView(_ tableView: UITableView,
                       trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
        {
            let MoreAction = UIContextualAction(style: .normal, title:  "Archive", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                print("Update action ...")
              
                print(self.newsUser[indexPath.row].title!)
                self.insertItem(idNews:self.newsUser[indexPath.row]._id!,dateNews:self.newsUser[indexPath.row].date!,descriptionNews:self.newsUser[indexPath.row].description!,idUser:self.newsUser[indexPath.row].username!,imageNews:self.newsUser[indexPath.row].image!,title:self.newsUser[indexPath.row].title!)
                self.deleteNews(idNews: self.newsUser[indexPath.row]._id!)
                tableView.reloadData()
                success(true)
            })
            MoreAction.image = UIImage(systemName: "archivebox.fill")
            MoreAction.backgroundColor =  UIColor(red: 0.93, green: 0.50, blue: 0.45, alpha: 1.00)//UIColor
            return UISwipeActionsConfiguration(actions: [MoreAction])
        }
    //Fonction
    func initialize() {
        let id = UserDefaults.standard.string(forKey: "iduser")
        newsViewModel.recupererNewsByUser(id: id!, completed: { [self] (success, newsfromRep) in
            if success {
                self.newsUser = newsfromRep!
                self.tableViewNews.reloadData()
                if ((newsfromRep?.isEmpty) == true)
                {
                    tableViewNews.isHidden = true
                    imagebackground.isHidden = false
                    image.isHidden = false
                    notifLabel.isHidden = false
                    buttonAdd.isHidden = false
                    addButtonCaree.isHidden = true 
                }else {
                    tableViewNews.isHidden = false
                    imagebackground.isHidden = true
                    image.isHidden = true
                    notifLabel.isHidden = true
                    buttonAdd.isHidden = true
                    addButtonCaree.isHidden = false
                }
            }else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not load News "),animated: true)
            }
        })
    }
   
    
   
    func insertItem(idNews:String,dateNews:String,descriptionNews:String,idUser:String,imageNews:String,title:String)  {

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistenceContainer = appDelegate.persistentContainer
        let managedContext = persistenceContainer.viewContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "NewsUser", in: managedContext)
        let object = NSManagedObject(entity: entityDescription!, insertInto: managedContext)
       object.setValue(idNews, forKey:"idNews" )
        object.setValue(dateNews, forKey:"dateNews" )
        object.setValue(descriptionNews, forKey:"descriptionNews" )
        object.setValue(idUser, forKey:"idUser" )
        object.setValue(imageNews, forKey:"imageNews" )
        object.setValue(title, forKey:"title" )
        do {
            try   managedContext.save()
            print("Insert Done ")
        } catch  {
            print("Insert Error ")
        }
    }
    func deleteNews(idNews:String)  {
        newsViewModel.deleteNews(id: idNews ,completed: { [self] (success) in
            if success {
                initialize()
            }})
    }
    @objc func addtoButton(sender:UIButton)
    {
        let indexpath1 = IndexPath(row: sender.tag, section: 0)
        titleNews = newsUser[indexpath1.row].title!
        descriptionNews = newsUser[indexpath1.row].description!
        photoNews = newsUser[indexpath1.row].image!
        idNews = newsUser[indexpath1.row]._id!
        let home = self.storyboard?.instantiateViewController(withIdentifier: "ModifViewController") as! ModifViewController
        self.navigationController?.pushViewController(home, animated: true)
    }
}
