//
//  ForgotPasswordViewController.swift
//  FactCheck
//
//  Created by Med Aziz on 18/4/2022.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    // var
    var email: String?
    var phone : String?
    var FirstPhone: String?
    var SecondPhone: String?
    var FirstEmail: String?
    var SeconfEmail: String?
    
    let userViewModel = UserViewModel()
    

    //outlet
 
    @IBOutlet var Button_Continue: UIButton!
    @IBOutlet var Button_sms: UIButton!
    @IBOutlet var Button_email: UIButton!
    
    @IBOutlet var smsbuttonimage: UIImageView!
    @IBOutlet var mailbuttonimage: UIImageView!
    @IBOutlet var SmsAnimaLogo: UIImageView!
    @IBOutlet var EmailAnimaLogo: UIImageView!
    
    @IBOutlet var EmailUserLabel: UILabel!
    @IBOutlet var PhoneNumberUserLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        Button_Continue.isEnabled = false
        phone =  String(UserDefaults.standard.integer(forKey: "phone"))
        FirstPhone = phone?.substring(to: 2)
        SecondPhone = phone?.substring(from: 5)
        PhoneNumberUserLabel.text = FirstPhone! + "***" + SecondPhone!
        email = UserDefaults.standard.string(forKey: "email")
        FirstEmail = email?.substring(to: 5)
        SeconfEmail = email?.substring(from: 13)
        EmailUserLabel.text = FirstEmail! + "*********" + SeconfEmail!
      
    }
    
    //ibaction
    @IBAction func ButtonActionSms(_ sender: Any) {
        Button_Continue.isEnabled = true
        mailbuttonimage.tintColor = UIColor(red: 0.93, green: 0.50, blue: 0.45, alpha: 1.00)
        smsbuttonimage.tintColor = UIColor(red: 0.99, green: 0.95, blue: 0.95, alpha: 1.00)
        SmsAnimaLogo.image = UIImage(named: "Anima logo-2")
        EmailAnimaLogo.image = UIImage(named: "Anima logo")
        UserDefaults.standard.setValue(PhoneNumberUserLabel.text, forKey: "send")
        //print(UserDefaults.standard.string(forKey: "send"))

    }

    @IBAction func ButtonActionEmail(_ sender: Any) {
        Button_Continue.isEnabled = true
        smsbuttonimage.tintColor = UIColor(red: 0.93, green: 0.50, blue: 0.45, alpha: 1.00)
        mailbuttonimage.tintColor = UIColor(red: 0.99, green: 0.95, blue: 0.95, alpha: 1.00)
        SmsAnimaLogo.image = UIImage(named: "Anima logo")
        EmailAnimaLogo.image = UIImage(named: "Anima logo-2")
        UserDefaults.standard.setValue(EmailUserLabel.text, forKey: "send")
        //print(UserDefaults.standard.string(forKey: "send"))
   
    }
    
    @IBAction func Continue_Button(_ sender: Any) {
        
      if (UserDefaults.standard.string(forKey: "send") == PhoneNumberUserLabel.text){
          userViewModel.getConfigsms(email:UserDefaults.standard.string(forKey: "email")!,completed: { (success) in
              
              if success {
                  self.performSegue(withIdentifier: "OTPSegue", sender: sender)
              }
             
      })
      }else {
          userViewModel.getConfig(email:UserDefaults.standard.string(forKey: "email")!,completed: { (success) in
              
              if success {
                  self.performSegue(withIdentifier: "OTPSegue", sender: sender)
              }
             
      })
      }
    
       
    }
    
}
