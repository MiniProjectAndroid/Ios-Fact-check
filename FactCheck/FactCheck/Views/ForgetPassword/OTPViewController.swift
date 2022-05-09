//
//  OTPViewController.swift
//  FactCheck
//
//  Created by Med Aziz on 18/4/2022.
//

import UIKit

class OTPViewController: UIViewController, UITextFieldDelegate {
    
    
    //var
    var seconds = 60
    var timer = Timer()
    
    
    //outlet
    @IBOutlet var TimeLable: UILabel!
    @IBOutlet var VerifyButton: UIButton!
    @IBOutlet var SendLabel: UILabel!
    @IBOutlet var txtOTP1: UITextField!
    @IBOutlet var txtOTP2: UITextField!
    @IBOutlet var txtOTP3: UITextField!
    @IBOutlet var txtOTP4: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(OTPViewController.counter), userInfo: nil, repeats: true)
        
        SendLabel.text =  UserDefaults.standard.string(forKey: "send")
        
        txtOTP1.backgroundColor = UIColor.clear
        txtOTP2.backgroundColor = UIColor.clear
        txtOTP3.backgroundColor = UIColor.clear
        txtOTP4.backgroundColor = UIColor.clear
        
        addBottomBorderTo(textField: txtOTP1)
        addBottomBorderTo(textField: txtOTP2)
        addBottomBorderTo(textField: txtOTP3)
        addBottomBorderTo(textField: txtOTP4)
        
        txtOTP1.delegate = self
        txtOTP2.delegate = self
        txtOTP3.delegate = self
        txtOTP4.delegate = self
        
        txtOTP1.becomeFirstResponder()
    }
    
    //function
    @objc func counter() {
        seconds -= 1
        TimeLable.text = String(seconds)
        
        if seconds == 0 {
            timer.invalidate()
            self.present(Alert.makeAlert(titre: "Warning", message: "Time passed ,reset the code!"), animated: true)
            VerifyButton.setTitle("Reset Code", for: .normal)
        }
    }
    
    func addBottomBorderTo(textField:UITextField) {
        let layer = CALayer()
        layer.backgroundColor = UIColor(red: 0.93, green: 0.50, blue: 0.45, alpha: 1.00).cgColor
        layer.frame = CGRect(x: 0.0, y: textField.frame.size.height - 2.0, width: textField.frame.size.width, height: 2.0)
        textField.layer.addSublayer(layer)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if ((textField.text?.count)! < 1 ) && (string.count > 0) {
            if textField == txtOTP1 {
                txtOTP2.becomeFirstResponder()
            }
            
            if textField == txtOTP2 {
                txtOTP3.becomeFirstResponder()
            }
            
            if textField == txtOTP3 {
                txtOTP4.becomeFirstResponder()
            }
            
            if textField == txtOTP4 {
                txtOTP4.resignFirstResponder()
            }
            
            textField.text = string
            return false
        } else if ((textField.text?.count)! >= 1) && (string.count == 0) {
            if textField == txtOTP2 {
                txtOTP1.becomeFirstResponder()
            }
            if textField == txtOTP3 {
                txtOTP2.becomeFirstResponder()
            }
            if textField == txtOTP4 {
                txtOTP3.becomeFirstResponder()
            }
            if textField == txtOTP1 {
                txtOTP1.resignFirstResponder()
            }
            
            textField.text = ""
            return false
        } else if (textField.text?.count)! >= 1 {
            textField.text = string
            return false
        }
        
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //action
    @IBAction func verifyActionButton(_ sender: Any) {
        
        if (VerifyButton.currentTitle == "Reset Code"){
            VerifyButton.setTitle("Verify", for: .normal)
            seconds = 60
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(OTPViewController.counter), userInfo: nil, repeats: true)
            txtOTP4.text = ""
            txtOTP3.text = ""
            txtOTP2.text = ""
            txtOTP1.text = ""
        }else{
            let first = txtOTP1.text
            let second = txtOTP2!.text
            let third = txtOTP3!.text
            let fourth = txtOTP4!.text
            let confrang = (first ?? "") + (second ?? "") + (third ?? "") + (fourth ?? "")
            if( confrang == UserDefaults.standard.string(forKey: "conf") ) {
                
                self.performSegue(withIdentifier: "newPassword", sender: sender)
            
                
            }else {
                self.present(Alert.makeAlert(titre: "Error", message: "Please try Again "), animated: true)
            }
        }
    }
    
    
    

}
