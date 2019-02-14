//
//  ListeCategoriesTableViewCell.swift
//  Portail G9
//
//  Created by WBA_ORCA on 14/02/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
class ListeCategoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // ***********************************
    // ***********************************
    // ***********************************
    func setupCategorieCell(categorie : Categorie)
    {
        titleLabel.text = categorie.categoryLibelle
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
