//
//  FiltreCollectionViewCell.swift
//  Portail G9
//
//  Created by WBA_ORCA on 04/02/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
class FiltreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // ***********************************
    // ***********************************
    // ***********************************
    
    override func awakeFromNib() {
        
        self.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1);
        self.layer.borderWidth = 1.0; //make border 1px thick
    }
}
