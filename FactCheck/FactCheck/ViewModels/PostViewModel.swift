//
//  PostViewModel.swift
//  FactCheck
//
//  Created by Sinda Arous on 3/5/2022.
//

import Foundation
import SwiftyJSON
import Alamofire
import UIKit.UIImage
import Foundation


public class PostViewModel: ObservableObject{
    
    static let sharedInstance = PostViewModel()
    
    func recupererPostByIDNews(id: String, completed: @escaping (Bool, [Post]?) -> Void ) {
        AF.request(host + "post/showNewsID",
                   method: .post,
                   parameters: [
                    "NewsID": id],
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    var post : [Post]? = []
                    for singleJsonItem in JSON(response.data!)["posts"] {
                        post!.append(self.makeItem(jsonItem: singleJsonItem.1))
                    }
                    completed(true, post)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func addPost(user: String,news : String ,description:String , completed: @escaping (Bool,Any?) -> Void) {
        AF.request(host + "post/store",
                   method: .post,
                   parameters: [
                    "username": user,
                    "news": news,
                    "description": description
                   
                   ])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                 
                    print("Validation Successful")
                    completed(true, user)
                case let .failure(error):
                    print(error)
                    completed(false, nil)
                }
            }
    }
    
    func deletePost(id: String, completed: @escaping (Bool) -> Void) {
        AF.request(host + "post/delete",
                   method: .post,
                   parameters: [
                    "PostID": id
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
   
    func updatePost(id: String,description:String , completed: @escaping (Bool) -> Void) {
        print(id)
        print(description)
        AF.request(host + "post/update",
                   method: .post,
                   parameters: [
                    "id": id,
                    "description":description
                   ])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    //let jsonData = JSON(response.data!)
                    print("yes")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    func countPost(id: String, completed: @escaping (Bool, Any?) -> Void) {
        AF.request(host + "post/count",
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
                   
                    let response = jsonData["count"].stringValue
                   // print(response)
                    //let user = self.makeItem(jsonItem: jsonData["existingUser"])
                    completed(true,response)
                case let .failure(error):
                    print(error)
                    completed(false,nil)
                }
            }
    }
    func makeItem(jsonItem: JSON) -> Post {
        
        return Post(
            _id: jsonItem["_id"].stringValue,
            news: jsonItem["news"].stringValue,
            username: jsonItem["username"].stringValue,
            description: jsonItem["description"].stringValue,
            dateOfPosting: jsonItem["date"].stringValue
         
        )
           
    }
  
  

}
