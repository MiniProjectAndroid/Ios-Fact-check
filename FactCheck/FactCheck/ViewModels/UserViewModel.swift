//
//  UserViewModel.swift
//  FactCheck
//
//  Created by Sinda Arous on 14/4/2022.
//

import SwiftyJSON
import Alamofire
import UIKit.UIImage
import Foundation

public class UserViewModel: ObservableObject{
    
    
    var role = "Agency"
    init(){}
    
    func inscription(utilisateur: User, completed: @escaping (Bool,Any?) -> Void) {
        
        
        
        
        
        AF.request(host + "user/register",
                   method: .post,
                   parameters: [
                    "username": utilisateur.username!,
                    "email": utilisateur.email!,
                    "password": utilisateur.password!,
                    "role": utilisateur.role!,
                    "phone": utilisateur.phone!,
                    "description": utilisateur.description!,
                    "idPhoto": utilisateur.idPhoto!,
                    "link": utilisateur.link!,
                    "countryNameValue": utilisateur.countryNameValue!
                   ])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                 
                    let user = self.makeItem(jsonItem: jsonData["user"])
                    UserDefaults.standard.setValue(jsonData["token"].stringValue, forKey: "tokenConnexion")
                    UserDefaults.standard.setValue(user._id, forKey: "iduser")
                    UserDefaults.standard.setValue(user.role, forKey: "role")
                    UserDefaults.standard.setValue(user.password, forKey: "password")
                    UserDefaults.standard.setValue(user.phone, forKey: "phone")
                    UserDefaults.standard.setValue(user.email, forKey: "email")
                    UserDefaults.standard.setValue(user.username, forKey: "username")
                    
                
                    if ( user.role == "Agency"){
                        print("test")
                        UserDefaults.standard.setValue(user.description, forKey: "description")
                        UserDefaults.standard.setValue(user.link, forKey: "link")
                    }
                    
                    print("Validation Successful")
                    completed(true, user)
                case let .failure(error):
                    print(error)
                    completed(false, nil)
                }
            }
    }
    
    func connexion(email: String, password: String,flage:Bool, completed: @escaping (Bool, Any?) -> Void) {
        AF.request(host + "authentification/login",
                   method: .post,
                   parameters: ["email": email, "password": password])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                 
                    let user = self.makeItem(jsonItem: jsonData["existingUser"])
                    if (flage){
                        UserDefaults.standard.setValue("true", forKey: "remrberMe")
                    }
                    if (!flage){
                        UserDefaults.standard.setValue("false", forKey: "remrberMe")
                    }
                    print( UserDefaults.standard.string(forKey: "remrberMe"))
                    UserDefaults.standard.setValue(jsonData["token"].stringValue, forKey: "tokenConnexion")
                    UserDefaults.standard.setValue(user._id, forKey: "iduser")
                    UserDefaults.standard.setValue(user.role, forKey: "role")
                    UserDefaults.standard.setValue(user.password, forKey: "password")
                    UserDefaults.standard.setValue(user.phone, forKey: "phone")
                    UserDefaults.standard.setValue(user.email, forKey: "email")
                    UserDefaults.standard.setValue(user.username, forKey: "username")
                    
                    UserDefaults.standard.setValue(user.idPhoto, forKey: "photo")
                    if ( user.role == "Agency"){
                        print("test")
                        UserDefaults.standard.setValue(user.description, forKey: "description")
                        UserDefaults.standard.setValue(user.link, forKey: "link")
                    }
                    completed(true, user)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    func modifUser(email: String, username: String, phone:Int , completed: @escaping (Bool) -> Void) {
      //  print(user)
        AF.request(host + "user/update",
                   method: .post,
                   parameters: [
                   "_id" : UserDefaults.standard.string(forKey: "iduser")!,
                    "email": email,
                    "username": username,
                   "phone": phone,
                  // "idPhoto":idPhoto,
                   ])
        .validate(statusCode: 400..<500)
        .validate(contentType: ["application/json"])
        .responseData { response in
            switch response.result {
            case .success:
                
                let jsonData = JSON(response.data!)
                let user = self.makeItem(jsonItem: jsonData)
            case let .failure(error):
                debugPrint(error)
               
            }
        }
    }
    
    func modifSource(email: String, username: String, phone:Int,description:String,link:String, uiImage: UIImage, completed: @escaping (Bool) -> Void) {
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(uiImage.jpegData(compressionQuality: 0.5)!, withName: "idPhoto" , fileName: "image.jpeg", mimeType: "image/jpeg")
            //let phones
            for (key, value) in
                    [
                        "_id" : UserDefaults.standard.string(forKey: "iduser")!,
                         "email": email,
                         "username": username,
                         "description" : description,
                         "link":link,
                    ]
            {
                multipartFormData.append((value.data(using: .utf8))!, withName: key)
            }
            
        },to: host + "user/update",
                  method: .post
                  
                  )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Success")
                    completed(true)
                case let .failure(error):
                    completed(false)
                    print(error)
                }
            }
      //  print(user)
       
    }
    
    func loginWithSocialApp(email: String, nom: String, completed: @escaping (Bool, User?) -> Void ) {
        AF.request(host + "/users/loginWithSocial",
                   method: .post,
                   parameters: ["email": email, "nom": nom],
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .response { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let user = self.makeItem(jsonItem: jsonData["user"])
                    
                    UserDefaults.standard.setValue(jsonData["token"].stringValue, forKey: "tokenConnexion")
                    UserDefaults.standard.setValue(user.email, forKey: "userEmail")
                   // UserDefaults.standard.setValue(user.nom, forKey: "userNom")
                    UserDefaults.standard.setValue(user.role, forKey: "userRole")
                    UserDefaults.standard.setValue("isNew", forKey: "isItNew")
                    completed(true, user)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func getUserByEmail(email: String,  completed: @escaping (Bool, Any? ) -> Void) {
        
        AF.request(host + "user/show",
                   method: .post,
                   parameters: [
                    "email": email],
                   encoding: JSONEncoding.default)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseData { response in
            switch response.result {
            case .success:
                let jsonData = JSON(response.data!)
                let user = self.makeItem(jsonItem: jsonData["existingUser"])
               
                UserDefaults.standard.setValue(user._id, forKey: "iduser")
                UserDefaults.standard.setValue(user.password, forKey: "password")
                UserDefaults.standard.setValue(user.phone, forKey: "phone")
                UserDefaults.standard.setValue(user.email, forKey: "email")
                
               
                completed(true, user)
            case let .failure(error):
                debugPrint(error)
                completed(false, nil)
               
            }
        }
    }
    
    func getConfig(email: String,completed: @escaping (Bool ) -> Void) {
        
        AF.request(host + "authentification/CodeConfig",
                   method: .post,
                   parameters: [
                    "email": email,
                   ]
            )
        .validate(statusCode: 200..<500)
        .validate(contentType: ["application/json"])
        .responseData { response in
            switch response.result {
            case .success:
                
                print("here")
                let jsonData = JSON(response.data!)
                let user = self.makeItem(jsonItem: jsonData["existingUser"])
               
                UserDefaults.standard.setValue(user.conf, forKey: "conf")
               
                completed(true)
            case let .failure(error):
                debugPrint(error)
                completed(false)
               
            }
        }
    }
    func getConfigsms(email: String,completed: @escaping (Bool ) -> Void) {
        
        AF.request(host + "authentification/CodeConfigsms",
                   method: .post,
                   parameters: [
                    "email": email,
                   ]
            )
        .validate(statusCode: 200..<500)
        .validate(contentType: ["application/json"])
        .responseData { response in
            switch response.result {
            case .success:
                
                print("here")
                let jsonData = JSON(response.data!)
                let user = self.makeItem(jsonItem: jsonData["existingUser"])
               
                UserDefaults.standard.setValue(user.conf, forKey: "conf")
               
                completed(true)
            case let .failure(error):
                debugPrint(error)
                completed(false)
               
            }
        }
    }
    
    func changePassword(email: String,  newpassword:String,completed: @escaping (Bool ) -> Void) {
        AF.request(host + "authentification/changePassword",
                   method: .post,
                   parameters: [
                    "email": email,
                    "newpassword":newpassword,
                   ]
            )
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseData { response in
            switch response.result {
            case .success:
                completed(true)
            case let .failure(error):
                debugPrint(error)
                completed(false)
               
            }
        }
    }
    func getUserByID(id: String,  completed: @escaping (Bool, Any? ) -> Void) {
        
        AF.request(host + "user/showID",
                   method: .post,
                   parameters: [
                    "userID": id],
                   encoding: JSONEncoding.default)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseData { response in
            switch response.result {
            case .success:
                let jsonData = JSON(response.data!)
                let user = self.makeItem(jsonItem: jsonData["existingUser"])
                completed(true, user)
            case let .failure(error):
                debugPrint(error)
                completed(false, nil)
               
            }
        }
    }
    
    func makeItem(jsonItem: JSON) -> User {
        
        return User(
            _id: jsonItem["_id"].stringValue,
            username: jsonItem["username"].stringValue,
            email: jsonItem["email"].stringValue,
            password: jsonItem["password"].stringValue,
            idPhoto: jsonItem["idPhoto"].stringValue,
            role: jsonItem["role"].stringValue,
            phone: jsonItem["phone"].intValue,
            description: jsonItem["description"].stringValue,
            link: jsonItem["link"].stringValue,
            conf : jsonItem["conf"].intValue
            
        )
    }
    
}

