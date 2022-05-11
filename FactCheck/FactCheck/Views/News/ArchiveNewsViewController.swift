//
//  ArchiveNewsViewController.swift
//  FactCheck
//
//  Created by Sinda Arous on 29/4/2022.
//

import UIKit
import CoreData
class ArchiveNewsViewController: UIViewController ,UITableViewDataSource, UITabBarDelegate {

    
    //var
    
    var newsViewModel = NewsViewModel()
    var NewsArchiveList = [News]()
    let userViewModel = UserViewModel()
    var image  = [String]()
    var Title = [String]()
    var Time = [String]()
    var Description = [String]()
    var IdNews = [String]()
    var IdUser = [String]()
    
    
  //iboutlet
    @IBOutlet weak var ArchiveTableView: UITableView!
    
    
    
    //widget
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Title.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       //v  print("herer")
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell")
        let contentView = cell?.contentView
        let imageNews = contentView?.viewWithTag(6) as! UIImageView
        let TitleLabel = contentView?.viewWithTag(1) as! UILabel
        let TimeLabel = contentView?.viewWithTag(2) as! UILabel
        let NameLabel = contentView?.viewWithTag(3) as! UILabel
        //let LikeLabel = contentView?.viewWithTag(4) as! UILabel
       // let CommentLabel = contentView?.viewWithTag(5) as! UILabel
        let imageProfile = contentView?.viewWithTag(7) as! UIImageView
        
       TitleLabel.text = Title[indexPath.row]
        TimeLabel.text = Time[indexPath.row]
        
                let url = URL(string: host + image[indexPath.row])!
                       if let data = try? Data(contentsOf: url ) {
                           imageNews.image = UIImage(data: data )
                       }
                    let id = IdUser[indexPath.row]
                    userViewModel.getUserByID(id: id ,completed: { [self] (success, reponse) in
                        if success {
                            let user = reponse as! User
                            NameLabel.text = user.username!
                            print (user)
                            let url = URL(string: host + user.idPhoto!)!
                                   if let data = try? Data(contentsOf: url ) {
                                       imageProfile.image = UIImage(data: data )
                                   }
                            //print("herer")
                        }})
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
            performSegue(withIdentifier: "DetailArchiveNews", sender: indexPath)
            
            
        }
  /*  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "DetailArchiveNews"{
                let indexPath = sender as! IndexPath
                let destination = segue.destination as! DetailsArchiveViewController
              
            }
        }*/
   
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    //fonction
    func fetchData()  {
        print("fffff")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistenceContainer = appDelegate.persistentContainer
        let managedContext = persistenceContainer.viewContext
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "NewsUser")
        do {
           let result = try managedContext.fetch(request)
            for item in result{
                image.append(item.value(forKey: "imageNews") as! String)
                Title.append(item.value(forKey: "title") as! String)
                Time.append(item.value(forKey: "dateNews") as! String)
                IdUser.append(item.value(forKey: "idUser") as! String)
                Description.append(item.value(forKey: "descriptionNews") as! String)
                IdNews.append(item.value(forKey: "idNews") as! String)
            }
        } catch  {
            
        }
    }
    
    
  
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            deletItem(index: indexPath.row)
            print("Deleting ....")
            image.remove(at: indexPath.row)
            Title.remove(at: indexPath.row)
            Time.remove(at: indexPath.row)
            IdUser.remove(at: indexPath.row)
            Description.remove(at: indexPath.row)
            IdNews.remove(at: indexPath.row)
            //UITableViewCell.EditingStyle.
            tableView.reloadData()
        }
    }
    
    func deletItem(index: Int)  {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistenceContainer = appDelegate.persistentContainer
        let managedContext = persistenceContainer.viewContext
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "NewsUser")
        let predicate = NSPredicate(format: "imageNews = %@", image[index])
        
        
        do {
            let result = try managedContext.fetch(request)
            if result.count > 0
            {
                let obj = result[0]
                managedContext.delete(obj)
                print("delete done ")
            }
        } catch  {
            print("error")
        }
    }
  
}
