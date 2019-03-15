//
//  CommentaireTableViewCell.swift
//  Portail G9
//
//  Created by WBA_ORCA on 05/03/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit

// +++++++++++++++
// ++++++++++++++++
// ++++++++++++++++
class CommentaireTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var labelRecepient: UILabel!
    
    // ***********************************
    // ***********************************
    // ***********************************
    func setupCell(comment : Comment)
    {
        labelMessage.text = comment.message
        labelRecepient.text = comment.recipient
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
