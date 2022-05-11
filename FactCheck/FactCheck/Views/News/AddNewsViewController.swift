//
//  AddNewsViewController.swift
//  FactCheck
//
//  Created by Sinda Arous on 27/4/2022.
//

import UIKit
import LocalAuthentication
import AVFoundation
import AudioToolbox
class AddNewsViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //iboutlet
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var ButtonAddImage: UIButton!
    @IBOutlet weak var descriptionNews: UITextView!
    @IBOutlet weak var titleNews: UITextField!
    //var
    var newsViewModel = NewsViewModel()
    var imageeselectedd : UIImage!
    var currentPhoto : UIImage?
    var pickerImage = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboard()
    }
    
    //fonction
    
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
  
    //ibaction
    @IBAction func buttonImage(_ sender: UIButton) {
        sender.pulseButton()
        showActionSheet()
        
    }
    @IBAction func AddButtonActions(_ sender: Any) {
        if (descriptionNews.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type news description"), animated: true)
            return
        }
        if (titleNews.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type news title "), animated: true)
            return
        }
        if (imageeselectedd == nil)
         {
            self.present(Alert.makeAlert(titre: "Warning", message: "Please Choose an image "), animated: true)
            return
         }
        let username = UserDefaults.standard.string(forKey: "iduser")
        newsViewModel.addNews(title:titleNews.text!, description:descriptionNews.text!,username: username!, uiImage: imageeselectedd,  completed: { [self] success in
            if success {
                let home = storyboard?.instantiateViewController(withIdentifier: "homeAgency") as! UITabBarController
                home.modalPresentationStyle = .fullScreen
                present(home, animated: true)
            } else {
                self.present(Alert.makeServerErrorAlert(),animated: true)
            }
        })
    }
  
    
}
