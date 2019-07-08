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
class ListeQuestionPilierTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    var mItem : ItemQuestionPilier = ItemQuestionPilier()
    
    // ***********************************
    // ***********************************
    // ***********************************
    func setupQuestionPilierCell(question_pilier : ItemQuestionPilier)
    {
        titleLabel.text = question_pilier.category
        mItem = question_pilier
         
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func setupHeaderQuestionPilierCell(question_pilier : ItemQuestionPilier)
    {
        titleLabel.text = question_pilier.category
        
        
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


