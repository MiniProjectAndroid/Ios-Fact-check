//
//  SinginViewController.swift
//  FactCheck
//
//  Created by Med Aziz on 12/4/2022.
//

import UIKit
import LocalAuthentication
import AVFoundation
import AudioToolbox
import Network
import ShowPasswordTextField

class SinginViewController: UIViewController {
    
    //iboutlet
    @IBOutlet var checkboxrememberme: UIButton!
    @IBOutlet var btnloginwithfaceid: UIButton!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    //var
    var context  = LAContext()
    var err : NSError?
    var userdefaults = UserDefaults.standard
    let userViewModel = UserViewModel()
    var flage = false
    let square = UIImage(systemName: "square")
    let squarechecked = UIImage(systemName: "checkmark.square")
    //sound
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound]) {
            (permissionGranted, error) in
            if(!permissionGranted)
            {
                print("Permission Denied")
            }
        }
        
        hideKeyboard()
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = {
            path in
            if path.status != .satisfied{
                DispatchQueue.main.async {
                    self.present(Alert.makeAlert(titre: "Warning", message: "Please check you connection"), animated: true)
                    return
                }
            }
                
        }
        
        
        checkboxrememberme.setBackgroundImage(square, for: .normal)
        if (userdefaults.value(forKey: "email") != nil) && (userdefaults.value(forKey: "pwd") != nil){
            btnloginwithfaceid.isHidden = false
            
        }else{
            btnloginwithfaceid.isHidden = true
        }
       
    }
    
    //function
    func scheduleNotification() {
        //content
        var content =  UNMutableNotificationContent()
        content.title = "Welcome to Fact Check"
        content.body = "Hi there, I'm the Bot of Fact Check i will send you notifications to help you be updated and more reactive with us "
        content.interruptionLevel = .timeSensitive
        
        //trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        //request
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        //schedule request
        UNUserNotificationCenter.current().add(request) { (error) in
            if (error != nil) {
                print("Error" + error.debugDescription)
                return
            }
        }
        
    }

    
    
    //ibaction
    @IBAction func btnloginwithfaceidtapped(_ sender: Any) {
        let localString = "Biometric Authentification"
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &err) { if context.biometryType == .faceID {
            print("face id biometrics")
        }else if context.biometryType == .touchID {
            print("touch id biometrics")
        }else{
            print("no biometrics")
        }
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: localString){ (success, error)
                in if success {
                    let email = self.userdefaults.value(forKey: "email") as! String
                    let pwd = self.userdefaults.value(forKey: "pwd") as! String
                    DispatchQueue.main.sync {
                        print("email= \(email) pwd =\(pwd)")
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeFactCheckSegue") as! HomeViewController
                        self.present(vc, animated: true , completion: nil )
                    }
                    
                }
            }
            
        }
    }
    
    
    @IBAction func rememberMeCheckboxAction(_ sender: UIButton) {
        if (flage == false){
            sender.setBackgroundImage(squarechecked, for: .normal)
            flage = true
            userdefaults.set(PasswordTextField.text!, forKey: "email")
            userdefaults.set(PasswordTextField.text!, forKey: "pwd")
        }else{
            sender.setBackgroundImage(square, for: .normal)
            flage = false
        }
    }
    
    @IBAction func SingInButton(_ sender: UIButton) {
        
        UNUserNotificationCenter.current().getNotificationSettings {(settings) in
            DispatchQueue.main.async {
                self.scheduleNotification()
            }
        }
        
        if (EmailTextField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type your Email"), animated: true)
            return
        }
        if (PasswordTextField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type your Password"), animated: true)
            return
        }
        
        userViewModel.connexion(email: EmailTextField.text!, password: PasswordTextField.text!,flage:flage,completed: { [self] (success, reponse) in
            
            if success {
                
                let user = reponse as! User
                
                if (user.role == "Agency"){
                    self.performSegue(withIdentifier: "HomeFactCheckSegueAgency", sender: nil)
                }else if (user.role == "Personal")
                {
                    self.performSegue(withIdentifier: "HomeFactCheckSeguePersonal", sender: nil)
                }
                
                 } else {
                self.present(Alert.makeAlert(titre: "Avertissement", message: "Email ou mot de passe incorrect."), animated: true)
            }
        })
    }
   
    @IBAction func forgetPasswordButton(_ sender: UIButton) {
        
        if (EmailTextField.text!.isEmpty){
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type your Email"), animated: true)
            return
        } 
        
        userViewModel.getUserByEmail(email: EmailTextField.text!,completed: { (success, reponse) in
            
            if success {
                self.performSegue(withIdentifier: "forgotpasswordSegue", sender: sender)
                
            } else {
                self.present(Alert.makeAlert(titre: "Avertissement", message: "Email incorrect."), animated: true)
                return
            }
        })
    }
}


//hide keyboard
extension UIViewController{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}