//
//  ContactTableViewCell.swift
//  FactCheck
//
//  Created by Sinda Arous on 11/5/2022.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    @IBOutlet weak var contactNumber: UILabel!
    @IBOutlet weak var contactName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
