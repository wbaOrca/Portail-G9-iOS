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
class ListeGroupesTableViewCell: UITableViewCell {

    @IBOutlet weak var iconMarqueImage: UIImageView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    // ***********************************
    // ***********************************
    // ***********************************
    func setupGroupeCell(groupe : GroupeKPI)
    {
        titleLabel.text = groupe.groupLibelle
        separatorView.backgroundColor = UIColor.init(hex: "#FFFFFF")
        separatorView.backgroundColor = UIColor.init(hex: groupe.status)
        
        if(groupe.groupIcon.count > 0)
        {
            let urlImageAsString = Version.URL_PREFIX_IMAGES_PORTAIL_G9 + groupe.groupIcon
            iconImage.sd_setImage(with: URL(string: urlImageAsString), placeholderImage: UIImage(named: "ic_groupe"))
        }else
        {
            iconImage.image = nil
        }
        if(groupe.marque.count > 0)
        {
            let urlImageAsString = Version.URL_PREFIX_IMAGES_PORTAIL_G9 + groupe.marque
            iconMarqueImage.sd_setImage(with: URL(string: urlImageAsString), placeholderImage: UIImage(named: ""))
        }else
        {
            iconMarqueImage.image = nil
        }
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func setupHeaderCell(categ : Categorie)
    {
        titleLabel.text = categ.categoryLibelle
        if(categ.categoryIcone.count > 0)
        {
            let urlImageAsString = Version.URL_PREFIX_IMAGES_PORTAIL_G9 + categ.categoryIcone 
            iconImage.sd_setImage(with: URL(string: urlImageAsString), placeholderImage: UIImage(named: "ic_menu"))
        }else
        {
            iconImage.image = nil
        }
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
