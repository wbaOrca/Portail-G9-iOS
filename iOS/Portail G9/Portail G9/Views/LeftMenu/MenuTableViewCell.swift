//
//  MenuTableViewCell.swift
//  Portail G9
//
//  Created by WBA_ORCA on 30/01/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit

// +++++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++++
// +++++++++++++++++++++++++++++++++
class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    
    
    // *****************************
    // *****************************
    // *****************************
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // *****************************
    // *****************************
    // *****************************
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
