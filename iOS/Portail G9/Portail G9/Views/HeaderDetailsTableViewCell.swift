//
//  HeaderDetailsTableViewCell.swift
//  Portail G9
//
//  Created by WBA_ORCA on 15/03/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit

class HeaderDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var labelHeader: UILabel!
    @IBOutlet weak var buttonAdd: UIButton!
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
