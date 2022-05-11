//
//  News.swift
//  FactCheck
//
//  Created by Med Aziz on 18/4/2022.
//

import Foundation

struct News: Encodable {

    internal init(_id: String? = nil, title: String? = nil, description: String? = nil, image: String? = nil,  username: String? = nil, link: String? = nil, date: String? = nil, like: String?, comment: String?) {
        self._id = _id
        self.title = title
        self.description = description
        self.image = image
        self.username = username
        self.link = link
        self.date = date
        self.like = like
        self.comment = comment
    }
    
    var _id : String?
    var username : String?
    var title : String?
    var description  : String?
    var image : String?
    var link : String?
    var date : String?
    var like : String?
    var comment : String?
    
    // relations
    
}


