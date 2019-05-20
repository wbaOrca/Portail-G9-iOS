//
//  KPICollectionViewCell.swift
//  Portail G9
//
//  Created by WBA_ORCA on 15/02/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit

class KPICollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    // ***********************************
    // ***********************************
    // ***********************************
    func setupKPICollectionViewCell(kpi : KPILigne)
    {
        titleLabel.text = kpi.libelle
        valueLabel.text = kpi.valeur
        
        titleLabel.backgroundColor = UIColor(hexString: kpi.bg_color);
        valueLabel.backgroundColor = UIColor(hexString: kpi.bg_color);
        
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func awakeFromNib() {
        
        titleLabel.layer.cornerRadius = 5
        titleLabel.clipsToBounds = true
        
        valueLabel.layer.cornerRadius = 5
        valueLabel.clipsToBounds = true
    }
}
