//
//  UpadetProfileSourceViewController.swift
//  FactCheck
//
//  Created by Sinda Arous on 19/4/2022.
//

import UIKit

class UpadetProfileSourceViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var imageeselectedd : UIImage!
    var currentPhoto : UIImage?
    var user: User?
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var TextFieldUserName: UITextField!
    @IBOutlet weak var TextFieldPhone: UITextField!
    @IBOutlet weak var TextFieldEmail: UITextField!
    @IBOutlet weak var TextViewDescription: UITextView!
    @IBOutlet weak var TextFieldLink: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.hideKeyboard()
        
        TextFieldPhone.text = String(UserDefaults.standard.integer(forKey: "phone"))
        TextFieldUserName.text = UserDefaults.standard.string(forKey: "username")
        TextFieldEmail.text = UserDefaults.standard.string(forKey: "email")
        TextViewDescription.text = UserDefaults.standard.string(forKey: "description")
        TextFieldLink.text = UserDefaults.standard.string(forKey: "link")
       
        let url = URL(string: host + UserDefaults.standard.string(forKey: "photo")!)!
       
                  // Fetch
               if let data = try? Data(contentsOf: url ) {
                   image.image = UIImage(data: data )
                   imageeselectedd = image.image
               }
    }
    func gallery()
    {
        let myPickerControllerGallery = UIImagePickerController()
        myPickerControllerGallery.delegate = self
        myPickerControllerGallery.sourceType = UIImagePickerController.SourceType.photoLibrary
        myPickerControllerGallery.allowsEditing = true
        self.present(myPickerControllerGallery, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            return
        }
        image.image = selectedImage
        imageeselectedd = selectedImage
       
        self.dismiss(animated: true, completion: nil)
       
    }
    func showActionSheet(){
        
        let actionSheetController: UIAlertController = UIAlertController(title: NSLocalizedString("Upload Image", comment: ""), message: nil, preferredStyle: .actionSheet)
        actionSheetController.view.tintColor = UIColor.black
        let cancelActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetController.addAction(cancelActionButton)
        
        
        let deleteActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Choose From Gallery", comment: ""), style: .default)
        { action -> Void in
            self.gallery()
        }
        
        actionSheetController.addAction(deleteActionButton)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    @IBAction func ImageButton(_ sender: UIButton) {
        sender.pulseButton()
        showActionSheet()
    }
    
    @IBAction func UpdateButtonAction(_ sender: Any) {
        if (TextFieldUserName.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Error", message: "Please type your username "), animated: true)
            return
        }
        
        if (TextFieldEmail.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Error", message: "Please type your email"), animated: true)
            return
        }
        
        if (TextFieldPhone.text!.isEmpty ){
            self.present(Alert.makeAlert(titre: "Error", message: "Please choose your phone"), animated: true)
            return
        }
        if (TextViewDescription.text!.isEmpty ){
            self.present(Alert.makeAlert(titre: "Error", message: "Please choose your description"), animated: true)
            return
        }
        if (TextFieldLink.text!.isEmpty ){
            self.present(Alert.makeAlert(titre: "Error", message: "Please choose your link"), animated: true)
            return
        }
        user?.phone = Int(TextFieldPhone.text!)
        user?.link = TextFieldLink.text
        user?.description = TextViewDescription.text
        user?.username = TextFieldUserName.text
        user?.email = TextFieldEmail.text
        user?._id = UserDefaults.standard.string(forKey: "_id")
      //  user?.phone = Int(phoneTextField.text)
        
        UserViewModel().modifSource(email : TextFieldEmail.text! , username: TextFieldUserName.text! , phone: Int(TextFieldPhone.text!)! ,description : TextViewDescription.text!, link: TextFieldLink.text!,uiImage: imageeselectedd , completed: { (success) in
            let home = self.storyboard?.instantiateViewController(withIdentifier: "homeAgency") as! UITabBarController
            home.modalPresentationStyle = .fullScreen
            self.present(home, animated: true)
        
                UserDefaults.standard.setValue(self.TextViewDescription.text, forKey: "description")
                UserDefaults.standard.setValue(self.TextFieldLink.text, forKey: "link")
                UserDefaults.standard.setValue(self.TextFieldPhone.text, forKey: "phone")
                UserDefaults.standard.setValue(self.TextFieldEmail.text, forKey: "email")
                UserDefaults.standard.setValue(self.TextFieldUserName.text, forKey: "username")
                //self.performSegue(withIdentifier: "ToProfileSegue", sender: nil)
            
            
           
           
        })
    }
    

}
