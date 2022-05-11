//
//  SettingsViewController.swift
//  FactCheck
//
//  Created by Sinda Arous on 13/4/2022.
//

import UIKit
import BLTNBoard


struct Section {
    let title : String
    let option : [SettingOptions]
}
struct SettingOptions{
    let title : String
    let icon : UIImage?
    let iconBackground : UIColor
    let handler :(()-> Void)
}
class SettingsViewController: UIViewController  ,UITableViewDelegate, UITableViewDataSource{
    private lazy var boardManager: BLTNItemManager = {
          let item = BLTNPageItem(title: "Logout")
          item.actionButtonTitle = "Logout"
          item.alternativeButtonTitle = "Cancel"
          item.descriptionText = "Are you sure want to logout !"
          item.requiresCloseButton = false
          
          item.actionHandler = { _ in
              SettingsViewController.didTapBoardContinue()
              self.performSegue(withIdentifier: "Restart", sender: 0)
          }
          item.alternativeHandler = { _ in
              SettingsViewController.didTapBoardSkip()
              item.manager?.dismissBulletin()
          }
          item.appearance.actionButtonColor = UIColor(red: 0.93, green: 0.50, blue: 0.45, alpha: 1.00)
          item.appearance.alternativeButtonTitleColor = UIColor(red: 0.93, green: 0.50, blue: 0.45, alpha: 1.00)
          return BLTNItemManager(rootItem: item)
      }()
    
    var models = [Section]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].option.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].option[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SettingTableViewCell.identifier,
            for: indexPath) as? SettingTableViewCell else {
                return UITableViewCell()
            }
        
        cell.configure(with: model)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.section].option[indexPath.row]
        model.handler()
    }
    
    private let tableView : UITableView = {
        let table = UITableView (frame: .zero , style: .grouped)
        table.register(SettingTableViewCell.self,forCellReuseIdentifier: SettingTableViewCell.identifier)
        return table
    }()
    override func viewDidLoad() {
    
        super.viewDidLoad()
        configure()
        title = "Settings"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        // Do any additional setup after loading the view.
    }
    func configure()
    {
        models.append(Section(title: "General", option: [
            SettingOptions(title: "Notifications", icon: UIImage(systemName: "bell.badge.fill"), iconBackground: UIColor(red: 0.93, green: 0.50, blue: 0.45, alpha: 1.00))
            {
                let home = self.storyboard?.instantiateViewController(withIdentifier: "NotifSettings") as! UIViewController
               // home. = .fullScreen
                self.show(home, sender: 0)
                    // self.show(sender:home)
                
                
               
              
            },
            SettingOptions(title: "Security", icon: UIImage(systemName: "lock.fill"), iconBackground: UIColor(red: 0.93, green: 0.50, blue: 0.45, alpha: 1.00))
            {
                let home = self.storyboard?.instantiateViewController(withIdentifier: "SecuritySettings") as! UIViewController
               // home. = .fullScreen
                self.show(home, sender: 0)
                
            },
            SettingOptions(title: "Apperance", icon: UIImage(systemName: "eye.fill"), iconBackground: UIColor(red: 0.93, green: 0.50, blue: 0.45, alpha: 1.00))
            {
                let home = self.storyboard?.instantiateViewController(withIdentifier: "ApparenceSettings") as! UIViewController
               // home. = .fullScreen
                self.show(home, sender: 0)
                
                //print("type Airplane Mode")
            },
            SettingOptions(title: "Help", icon: UIImage(systemName: "info.circle.fill"), iconBackground: UIColor(red: 0.93, green: 0.50, blue: 0.45, alpha: 1.00))
            {
                let home = self.storyboard?.instantiateViewController(withIdentifier: "HelpSettings") as! UIViewController
               // home. = .fullScreen
                self.show(home, sender: 0)
            },
            SettingOptions(title: "Invite Friends", icon: UIImage(systemName: "person.3.sequence.fill"), iconBackground: UIColor(red: 0.93, green: 0.50, blue: 0.45, alpha: 1.00))
            {
                let home = self.storyboard?.instantiateViewController(withIdentifier: "InviteSettings") as! UIViewController
               // home. = .fullScreen
                self.show(home, sender: 0)
            },
            SettingOptions(title: "Logout", icon: UIImage(systemName: "rectangle.portrait.and.arrow.right.fill"), iconBackground: UIColor(red: 0.93, green: 0.50, blue: 0.45, alpha: 1.00))
            {
                self.boardManager.backgroundViewStyle = .blurredDark
                self.boardManager.showBulletin(above: self)
              //  print("here")
                //performSegue(withIdentifier: "gtggt", sender: 0)
            },
        
        ]))
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    static func didTapBoardContinue()
    {
        UserDefaults.standard.setValue("", forKey: "tokenConnexion")
        UserDefaults.standard.setValue("", forKey: "iduser")
        UserDefaults.standard.setValue("", forKey: "role")
        UserDefaults.standard.setValue("", forKey: "password")
        UserDefaults.standard.setValue("", forKey: "phone")
        UserDefaults.standard.setValue("", forKey: "email")
        UserDefaults.standard.setValue("", forKey: "username")
        UserDefaults.standard.setValue("", forKey: "description")
        UserDefaults.standard.setValue("", forKey: "link")
        UserDefaults.standard.setValue("", forKey: "photo")
        //self.performSegue(withIdentifier: "Restart", sender: Any?)
    }
    static func didTapBoardSkip(){
        print(UserDefaults.standard.string(forKey: "iduser"))
        print("did tap skip")
    }
  /*
    @IBOutlet weak var buttonLogout: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        boardManager.backgroundViewStyle = .blurredDark
        boardManager.showBulletin(above: self)
      //  print("here")
        //performSegue(withIdentifier: "gtggt", sender: 0)
    }
    
   
*/
}
