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
    
    @IBOutlet weak var stackViewMonth: UIStackView!
    
    var qp : QuestionPilier = QuestionPilier()
    
    // ***********************************
    // ***********************************
    // ***********************************
    func setupQuestionPilierCell(question_pilier : QuestionPilier)
    {
        
        self.qp = question_pilier ;
        
        titleLabel.text = question_pilier.libelle
        
        frequenceLabel.text = question_pilier.frequence
        majLabel.text = question_pilier.derniereMAJ
        commentaireLabel.text = question_pilier.commentaire
        
        
        //setup month
        stackViewMonth.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        for monthQP in question_pilier.values
        {
            
        
            let labelMonth = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
            labelMonth.layer.cornerRadius = 5
            labelMonth.clipsToBounds = true
            labelMonth.textColor = .white
            labelMonth.font = UIFont(name: "Helvetica", size: 10)
            labelMonth.textAlignment = .center
            labelMonth.text = String(monthQP.month.prefix(3))
            
            if(monthQP.value == nil)
            {
                labelMonth.backgroundColor = .orange
            }else if(monthQP.value == true)
            {
                labelMonth.backgroundColor = .green
            }else
            {
                labelMonth.backgroundColor = .red
            }
            
            stackViewMonth.addArrangedSubview(labelMonth)
        }
        
    }
    
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    
    // ***********************************
    // ***********************************
    // ***********************************
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



