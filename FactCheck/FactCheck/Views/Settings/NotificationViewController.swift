//
//  NotificationViewController.swift
//  FactCheck
//
//  Created by Sinda Arous on 26/4/2022.
//

import UIKit

class NotificationViewController: UIViewController {

    @IBOutlet weak var SoundSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.setValue("off", forKey: "switchSound")
    }
    
    @IBAction func SoundSwitchChange(_ sender: Any) {
        if SoundSwitch.isOn {
            print("The Switch is On")
            UserDefaults.standard.setValue("on", forKey: "switchSound")
            } else {
                print("The Switch is Off")
                UserDefaults.standard.setValue("off", forKey: "switchSound")
            }
    }
   
    /*let switchSound = self.userdefaults.value(forKey: "switchSound") as! String
    if (switchSound  == "on"){}*/

}
