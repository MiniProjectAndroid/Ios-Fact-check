//
//  Check.swift
//  FactCheck
//
//  Created by Sinda Arous on 22/4/2022.
//

import Foundation

struct Check: Encodable {

    internal init(_id: String? = nil, text: String? = nil, claimant: String? = nil, url: String? = nil,  urlText: String? = nil, textualRating: String? = nil) {
        self._id = _id
        self.text = text
        self.claimant = claimant
        self.url = url
        self.urlText = urlText
        self.textualRating = textualRating
    }
    
    var _id : String?
    var text : String?
    var claimant  : String?
    var url : String?
    var urlText : String?
    var textualRating : String?
    
    // relations
    
}
