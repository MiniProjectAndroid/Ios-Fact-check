//
//  OnboardingCollectionViewCell.swift
//  FackChek
//
//  Created by Sinda Arous on 7/4/2022.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var SlideImageView: UIImageView!
       @IBOutlet weak var TitleSlideLabel: UILabel!
       @IBOutlet weak var DescriptionLabel: UILabel!
       
       static let identifier = String(describing: OnboardingCollectionViewCell.self)
       
       func setup(_ slide: OnboardingSlide){
           SlideImageView.image = slide.image
           TitleSlideLabel.text = slide.title
           DescriptionLabel.text = slide.description
       }
}
