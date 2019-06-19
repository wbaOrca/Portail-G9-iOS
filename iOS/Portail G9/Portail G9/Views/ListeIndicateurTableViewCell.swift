//
//  ListeIndicateurTableViewCell.swift
//  Portail G9
//
//  Created by WBA_ORCA on 21/05/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
class ListeIndicateurTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headerButton: UIButton!
    
    // ***********************************
    // ***********************************
    // ***********************************
    func setupIndicateurCell(indictauer : KPICategorieFamille)
    {
        titleLabel.text = indictauer.title
        if(indictauer.isAutoChecked)
        {
            iconImage.backgroundColor = #colorLiteral(red: 0.7919282317, green: 0.1277886331, blue: 0.07557370514, alpha: 1)
        }else if(indictauer.isChecked)
        {
            iconImage.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        }else{
            iconImage.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        }
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func setupIndicateurCellHeader(famille : Famille)
    {
        titleLabel.text = famille.RubriqueTitle
        headerButton.tag = famille.RubriqueId - 1
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if(iconImage != nil)
        {
            iconImage.layer.cornerRadius = 10
            iconImage.clipsToBounds = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
