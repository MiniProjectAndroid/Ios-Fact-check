//
//  CheckViewController.swift
//  FactCheck
//
//  Created by Sinda Arous on 22/4/2022.
//

import UIKit

class CheckViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableViewCheck: UITableView!
    
    var checkViewModel = CheckViewModel()
    var check = [Check]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return check.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CheckTableViewCell
        //let contentView = cell.contentView
       
        let check = check[indexPath.row]
        cell.ClaimBy.text = check.claimant!
        cell.textCheck.text = check.text!
        cell.ratingCheck.text = check.textualRating
        cell.urlText.text = check.urlText
        cell.urlButton = check.url
       
         
      
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
      
    }
    func initialize() {
        CheckViewModel.sharedInstance.recupererToutCheck() { success, checkfromRep in
            if success {
                self.check = checkfromRep!
                self.tableViewCheck.reloadData()
            }else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not load News "),animated: true)
            }
        }
    }


}
