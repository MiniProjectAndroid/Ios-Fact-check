//
//  SettingsViewController.swift
//  FactCheck
//
//  Created by Sinda Arous on 13/4/2022.
//

import UIKit
import BLTNBoard
class SettingsViewController: UIViewController {
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
   

}
