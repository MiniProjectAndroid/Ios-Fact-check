//
//  ModifViewController.swift
//  FactCheck
//
//  Created by Sinda Arous on 28/4/2022.
//

import UIKit

//var Global
var titleNews:String = ""
var descriptionNews : String = ""
var photoNews : String = ""
var idNews : String = ""
class ModifViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //var
    var newsViewModel = NewsViewModel()
    var imageeselectedd : UIImage!
    
    //iboutlet
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var imageNews: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: photoNews)!
               if let data = try? Data(contentsOf: url ) {
                   imageNews.image = UIImage(data: data )
               }
        imageeselectedd = imageNews.image 
        titleTextField.text = titleNews
        descriptionTextView.text = descriptionNews
        
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
        imageNews.image = selectedImage
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
    @IBAction func addimage(_ sender: UIButton) {
        sender.pulseButton()
        showActionSheet()
    }
    
    @IBAction func UpdateNews(_ sender: Any) {
        if (descriptionTextView.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type news description"), animated: true)
            return
        }
        if (titleTextField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type news title "), animated: true)
            return
        }
        if (imageeselectedd == nil)
         
         {   self.present(Alert.makeAlert(titre: "Warning", message: "Please Choose an image "), animated: true)
            return
         }
        NewsViewModel.sharedInstance.modifNews(idnews:idNews,title:titleTextField.text!, description:descriptionTextView.text!, uiImage: imageeselectedd!,  completed: { [self] success in
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
