//
//  CostumUITextView.swift
//  FactCheck
//
//  Created by Sinda Arous on 27/4/2022.
//

import Foundation

import UIKit
extension UITextView {

  func underlined() {
    let border = CALayer()
    let width = CGFloat(1.0)
    border.borderColor = UIColor.lightGray.cgColor
    border.frame = CGRect(x: 0, y: self.frame.size.height - 5, width:  self.frame.size.width, height: 1)
    border.borderWidth = width
    self.layer.addSublayer(border)
    self.layer.masksToBounds = true
    let style = NSMutableParagraphStyle()
    style.lineSpacing = 15
    let attributes = [NSAttributedString.Key.paragraphStyle : style, NSAttributedString.Key.foregroundColor : UIColor.darkGray, NSAttributedString.Key.font :  UIFont.systemFont(ofSize: 13)]
    self.attributedText = NSAttributedString(string: self.text, attributes: attributes)
  }

}
