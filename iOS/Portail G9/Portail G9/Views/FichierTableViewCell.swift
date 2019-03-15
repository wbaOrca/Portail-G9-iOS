//
//  FichierTableViewCell.swift
//  Portail G9
//
//  Created by WBA_ORCA on 05/03/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit

// +++++++++++++++
// ++++++++++++++++
// ++++++++++++++++
class FichierTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var labelFichier: UILabel!
    
    // ***********************************
    // ***********************************
    // ***********************************
    func setupCell(file : File)
    {
        let urlPathFile = file.fileName;
        let url_ = URL(fileURLWithPath: urlPathFile);
        labelFichier.text = url_.lastPathComponent
        
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
