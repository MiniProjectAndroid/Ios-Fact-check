//
//  CheckViewController.swift
//  FactCheck
//
//  Created by Sinda Arous on 22/4/2022.
//

import UIKit

class CheckViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate{

    
    //var
    private let searchVC = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var tableViewCheck: UITableView!
    
    var checkViewModel = CheckViewModel()
    var check = [Check]()
    var dupcheck = [Check]()
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
        createSearchBar()
      
    }
    
    func createSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
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

    //search
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
        CheckViewModel.sharedInstance.search(with: text) { success, checkfromRep in
            if success {
                self.check = checkfromRep!
                print(checkfromRep!)
                self.tableViewCheck.reloadData()
                self.searchVC.dismiss(animated: true, completion: nil)
            }else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not load News "),animated: true)
            }
        }
    }
    
    /*func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text =  ""
        searchBar.endEditing(true)
        
        self.dupcheck = self.check
        self.tableViewCheck.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("search = \(searchText)" )
        self.dupcheck = searchText.isEmpty ? check : check.filter({ (model) -> Bool in
            return model.text!.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        self.tableViewCheck.reloadData()
    }*/

}
