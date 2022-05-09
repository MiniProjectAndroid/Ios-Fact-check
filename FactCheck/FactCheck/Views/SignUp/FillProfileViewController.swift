//
//  FillProfileViewController.swift
//  FactCheck
//
//  Created by Med Aziz on 15/4/2022.
//

import UIKit
import Alamofire

class FillProfileViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate 
{
    
    //var
    var utilisateur : User?
    let utilisateurViewModel = UserViewModel()
    
    //iboutlet
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet var usernametextFields: UITextField!
    @IBOutlet var DescriptionView: UITextView!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var LinkTextField: UITextField!
    @IBOutlet weak var image: UIImageView!
    var imageeselectedd : UIImage!
    var currentPhoto : UIImage?
    var pickerImage = UIImagePickerController()
    @IBOutlet weak var imageProfile: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        if ( utilisateur?.role == "Personal" )
        {
            LinkTextField.isHidden = true
            DescriptionView.isHidden = true
            labelDescription.isHidden = true
            linkLabel.isHidden = true 
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
    @IBAction func addPhotoButton(_ sender: UIButton) {
        sender.pulseButton()
        showActionSheet()
    }
    //function
    func goToLogin(role: String?) {
        if (role! == "Agency"){
        self.performSegue(withIdentifier: "connexionsegueAgency", sender: nil)
        }
        if (role! == "Personal"){
            self.performSegue(withIdentifier: "connexionSeguePersonel", sender: nil)
        }
    }
    
    //ibAction
    @IBAction func continueButtonAction(_ sender: Any) {
        if (usernametextFields.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Erreur", message: "Please type your User Name"), animated: true)
            return
        }
        if (emailTextField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Erreur", message: "Please type your Phone"), animated: true)
            return
        }
        utilisateur?.idPhoto = ""
        utilisateur?.username = usernametextFields.text
        utilisateur?.phone = Int(emailTextField.text!) ?? 0
        utilisateur?.description = DescriptionView.text
        utilisateur?.link = LinkTextField.text
        utilisateurViewModel.inscription(utilisateur: utilisateur!, completed:  { [self] (success, reponse) in
            
            if success {
                   // let user = reponse as! User
                
                if (utilisateur?.role == "Agency"){
                    self.performSegue(withIdentifier: "HomeFactCheckSegueAgency", sender: nil)
                }else if (utilisateur?.role == "Personal")
                {
                    self.performSegue(withIdentifier: "HomeFactCheckSeguePersonal", sender: nil)
                }
        }
            
        })
    }
    
 
  
    
   
    
}
