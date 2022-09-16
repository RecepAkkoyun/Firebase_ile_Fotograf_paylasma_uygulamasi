//
//  HomeTableViewCell.swift
//  InstagramCloneApp
//
//  Created by Recep Akkoyun on 15.09.2022.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblYorum: UILabel!

    @IBOutlet weak var postImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
