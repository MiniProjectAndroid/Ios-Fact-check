//
//  CheckTableViewCell.swift
//  FactCheck
//
//  Created by Sinda Arous on 26/4/2022.
//

import UIKit

class CheckTableViewCell: UITableViewCell {

    @IBOutlet weak var buttonUrl: UIButton!
    @IBOutlet weak var ClaimBy: UILabel!
    @IBOutlet weak var ratingCheck: UILabel!
    @IBOutlet weak var textCheck: UITextView!
    @IBOutlet weak var urlText: UITextView!
    var urlButton :String? 
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func ButtonUrl(_ sender: UIButton) {
        UIApplication.shared.open(URL(string:urlButton!)! as URL ,options: [:], completionHandler: nil)
        
    }
    
}
