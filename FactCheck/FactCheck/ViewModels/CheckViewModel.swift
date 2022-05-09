//
//  CheckViewModel.swift
//  FactCheck
//
//  Created by Sinda Arous on 22/4/2022.
//
import SwiftyJSON
import Alamofire
import UIKit.UIImage
import Foundation


public class CheckViewModel: ObservableObject{
    
    static let sharedInstance = CheckViewModel()
    
    func recupererToutCheck( completed: @escaping (Bool, [Check]?) -> Void ) {
        AF.request(host + "check",
                   method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    var check : [Check]? = []
                    for singleJsonItem in JSON(response.data!)["check"] {
                        check!.append(self.makeItem(jsonItem: singleJsonItem.1))
                    }
                    completed(true, check)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func search(with query: String, completed: @escaping (Bool, [Check]?) -> Void ) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        guard let url = URL(string: search_URL + query) else {
            return
        }
        AF.request(url,
                   method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    var check : [Check]? = []
                    for singleJsonItem in JSON(response.data!)["check"] {
                        check!.append(self.makeItem(jsonItem: singleJsonItem.1))
                    }
                    completed(true, check)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    
    func makeItem(jsonItem: JSON) -> Check {
        
        return Check(
            _id: jsonItem["_id"].stringValue,
            text: jsonItem["text"].stringValue,
            claimant: jsonItem["claimant"].stringValue,
            url: jsonItem["url"].stringValue,
            urlText: jsonItem["urlText"].stringValue,
            textualRating: jsonItem["textualRating"].stringValue
        )
           
    }

}
