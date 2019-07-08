//
//  ListePilierTableViewCell.swift
//  Portail G9
//
//  Created by WBA_ORCA on 04/04/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
class ListePilierTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    // ***********************************
    // ***********************************
    // ***********************************
    func setupPilierCell(pilier : Pilier)
    {
        titleLabel.text = pilier.pilierLibelle
        
        //let color = UIColor.init(name: pilier.pilierStatut)
        let color = UIColor.init(hex: pilier.pilierStatutCodeCouleur)
        separatorView.backgroundColor = color
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
