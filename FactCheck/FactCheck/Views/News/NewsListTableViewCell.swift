//
//  NewsListTableViewCell.swift
//  FactCheck
//
//  Created by Sinda Arous on 28/4/2022.
//

import UIKit

class NewsListTableViewCell: UITableViewCell {

    
    //iboutlet
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var dateNews: UILabel!
    @IBOutlet weak var usernameNews: UILabel!
    @IBOutlet weak var likeNews: UILabel!
    @IBOutlet weak var commentaireNews: UILabel!
    @IBOutlet weak var modifButton: UIButton!
    @IBOutlet weak var imageUser :UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
   
    
}
