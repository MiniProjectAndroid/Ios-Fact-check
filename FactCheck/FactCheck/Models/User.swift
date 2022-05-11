//
//  User.swift
//  FactCheck
//
//  Created by Med Aziz on 14/4/2022.
//

import Foundation

struct User: Encodable {

    internal init(_id: String? = nil, username: String? = nil, email: String? = nil, password: String? = nil,  idPhoto: String? = nil, role: String? = nil, phone: Int? = nil, description:String? = nil, link:String? = nil, countryNameValue:String? = nil,conf:Int? = nil) {
        self._id = _id
        self.username = username
        self.email = email
        self.password = password
        self.idPhoto = idPhoto
        self.role = role
        self.phone = phone
        self.description = description
        self.link = link
        self.countryNameValue = countryNameValue
        self.conf = conf
        
    }
    
    var _id : String?
    var username : String?
    var email : String?
    var password  : String?
    var idPhoto : String?
    var role : String?
    var phone : Int?
    var description : String?
    var link : String?
    var countryNameValue : String?
    var conf : Int?
    // relations
    
}
