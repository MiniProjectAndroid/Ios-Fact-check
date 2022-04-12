//
//  UIView+Extension.swift
//  factcheck
//
//  Created by Med Aziz on 7/4/2022.
//

import UIKit

extension UIView{
    @IBInspectable var cornerRadius:CGFloat{
        get { return cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}

