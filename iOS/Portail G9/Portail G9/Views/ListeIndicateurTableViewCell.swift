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
            iconImage.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        }else if(indictauer.isChecked)
        {
            iconImage.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.5098039216, blue: 0.07450980392, alpha: 1)
        }else{
            iconImage.backgroundColor = #colorLiteral(red: 0.1960784314, green: 0.9725490196, blue: 0.2509803922, alpha: 1)
        }
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func setupIndicateurCellHeader(famille : Famille , index : Int)
    {
        titleLabel.text = famille.RubriqueTitle
        headerButton.tag = index //famille.RubriqueId - 1
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if(iconImage != nil)
        {
            iconImage.layer.cornerRadius = iconImage.frame.width / 2.0
            iconImage.clipsToBounds = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
