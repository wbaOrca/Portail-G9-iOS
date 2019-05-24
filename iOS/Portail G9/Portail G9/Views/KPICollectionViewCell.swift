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
   // @IBOutlet weak var valueLabel: UILabel!
    
    // ***********************************
    // ***********************************
    // ***********************************
    func setupKPICollectionViewCell(kpi : KPILigne)
    {
        titleLabel.text = kpi.libelle
        //valueLabel.text = kpi.valeur
        
        titleLabel.backgroundColor = UIColor(hexString: kpi.bg_color);
        //valueLabel.backgroundColor = UIColor(hexString: kpi.bg_color);
        
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func setupKPICollectionViewCellGrid(indicateur : IndicateurKPIGrid)
    {
        
        titleLabel.text = indicateur.indicateurKPI.valeur
        titleLabel.backgroundColor = .clear
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        if(indicateur.isHeaderLigne)
        {
            self.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        }else if(indicateur.isColonneLigne)
        {
            self.backgroundColor = #colorLiteral(red: 0.8376570344, green: 0.8434004188, blue: 1, alpha: 1)
        }else
        {
            titleLabel.backgroundColor = UIColor(hexString: indicateur.indicateurKPI.bg_color);
        }
       
        
    }
    // ***********************************
    // ***********************************
    // ***********************************
    override func awakeFromNib() {
        
        titleLabel.layer.cornerRadius = 5
        titleLabel.clipsToBounds = true
        
        //valueLabel.layer.cornerRadius = 5
        //valueLabel.clipsToBounds = true
    }
}
