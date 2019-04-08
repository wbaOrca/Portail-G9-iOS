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
class QuestionPilierTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentaireLabel: UILabel!
    @IBOutlet weak var majLabel: UILabel!
    @IBOutlet weak var frequenceLabel: UILabel!
    
    @IBOutlet weak var LabelJanvier: UILabel!
    @IBOutlet weak var LabelFevrier: UILabel!
    @IBOutlet weak var LabelMars: UILabel!
    @IBOutlet weak var LabelAvril: UILabel!
    @IBOutlet weak var LabelMai: UILabel!
    @IBOutlet weak var LabelJuin: UILabel!
    @IBOutlet weak var LabelJuillet: UILabel!
    @IBOutlet weak var LabelAout: UILabel!
    @IBOutlet weak var LabelSeptembre: UILabel!
    @IBOutlet weak var LabelOctobre: UILabel!
    @IBOutlet weak var LabelNovembre: UILabel!
    @IBOutlet weak var LabelDecembre: UILabel!
    
    var qp : QuestionPilier = QuestionPilier()
    
    // ***********************************
    // ***********************************
    // ***********************************
    func setupQuestionPilierCell(question_pilier : QuestionPilier)
    {
        titleLabel.text = question_pilier.libelle
        
        self.qp = question_pilier ;
        
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



