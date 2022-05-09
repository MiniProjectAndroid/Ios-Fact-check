//
//  FactCheckViewController.swift
//  FactCheck
//
//  Created by Med Aziz on 18/4/2022.
//

import SwiftyJSON
import Alamofire
import UIKit.UIImage
import Foundation


public class NewsViewModel: ObservableObject{
    
    static let sharedInstance = NewsViewModel()
    
    func recupererToutNews( completed: @escaping (Bool, [News]?) -> Void ) {
        AF.request(host + "news",
                   method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    var news : [News]? = []
                    for singleJsonItem in JSON(response.data!)["newss"] {
                        news!.append(self.makeItem(jsonItem: singleJsonItem.1))
                    }
                    completed(true, news)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    func recupererNewsByUser( id: String,completed: @escaping (Bool, [News]?) -> Void ) {
        AF.request(host + "news/showByUser",
                   method: .post,
                   parameters: [
                    "userID": id],
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    var news : [News]? = []
                    for singleJsonItem in JSON(response.data!)["newss"] {
                        news!.append(self.makeItem(jsonItem: singleJsonItem.1))
                    }
                    completed(true, news)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    func recupererNewsById( id: String,completed: @escaping (Bool, [News]?) -> Void ) {
        AF.request(host + "news/showID",
                   method: .post,
                   parameters: [
                    "newsID": id],
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    var news : [News]? = []
                    for singleJsonItem in JSON(response.data!)["newss"] {
                        news!.append(self.makeItem(jsonItem: singleJsonItem.1))
                    }
                    completed(true, news)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    func addNews(title: String,description: String,username:String, uiImage: UIImage, completed: @escaping (Bool) -> Void ) {
      // let email = UserDefaults.standard.string(forKey: "email")
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(uiImage.jpegData(compressionQuality: 0.5)!, withName: "image" , fileName: "image.jpeg", mimeType: "image/jpeg")
            
            for (key, value) in
                    [
                        "title":title,
                        "description":description,
                        "username": username,
                    ]
            {
                multipartFormData.append((value.data(using: .utf8))!, withName: key)
            }
            
        },to: host + "news/add",
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
    }
    func modifNews(idnews : String , title: String,description: String, uiImage: UIImage, completed: @escaping (Bool) -> Void ) {
      // let email = UserDefaults.standard.string(forKey: "email")
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(uiImage.jpegData(compressionQuality: 0.5)!, withName: "image" , fileName: "image.jpeg", mimeType: "image/jpeg")
            
            for (key, value) in
                    [   "NewsID":idnews,
                        "title":title,
                        "description":description
                      
                    ]
            {
                multipartFormData.append((value.data(using: .utf8))!, withName: key)
            }
            
        },to: host + "news/update",
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
    }
    func deleteNews(id: String, completed: @escaping (Bool) -> Void) {
        AF.request(host + "news/delete",
                   method: .post,
                   parameters: [
                    "NewsID": id
                   ])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
   
    func makeItem(jsonItem: JSON) -> News {
        
        return News(
            _id: jsonItem["_id"].stringValue,
            title: jsonItem["title"].stringValue,
            description: jsonItem["description"].stringValue,
            image: jsonItem["image"].stringValue,
            username: jsonItem["username"].stringValue,
            link: jsonItem["link"].stringValue,
            date: jsonItem["date"].stringValue,
            like: jsonItem["like"].stringValue,
            comment: jsonItem["comment"].stringValue
         
        )
           
    }

}
