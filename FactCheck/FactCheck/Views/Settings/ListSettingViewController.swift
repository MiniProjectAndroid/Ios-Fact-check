//
//  ListSettingViewController.swift
//  FactCheck
//
//  Created by Sinda Arous on 1/5/2022.
//

import UIKit

class ListSettingViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate {
    var liste = ["Notifications", "Security", "Appereance", "Help", "Invite Friends", "Logout"]
     
     var icone = ["bell.badge.fill", "lock.fill", "eye.fill", "info.circle.fill", "person.3.fill", "rectangle.portrait.and.arrow.right.fill"]
    @IBOutlet weak var tableViewSettings: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return liste.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell")
        let contentView = cell?.contentView
        let ImageView = contentView?.viewWithTag(1) as! UIImageView
        let labelname = contentView?.viewWithTag(2) as! UILabel
        
        
        
        ImageView.image = UIImage(systemName: icone[indexPath.row])
        labelname.text = liste[indexPath.row]
       // labelcategorie.text = categories[indexPath.row]
 
        return cell!
         
      
      
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
