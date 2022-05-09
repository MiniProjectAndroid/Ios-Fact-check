//
//  Post.swift
//  FactCheck
//
//  Created by Sinda Arous on 3/5/2022.
//

import Foundation
struct Post: Encodable {

    internal init(_id: String? = nil,news: String? = nil, username: String? = nil, description: String? = nil, dateOfPosting: String? = nil) {
        self._id = _id
        self.news = news
        self.username = username
        self.description = description
        self.dateOfPosting = dateOfPosting
    }
    
    var _id : String?
    var news : String?
    var username : String?
    var description  : String?
    var dateOfPosting : String?
    
    // relations
    
}


