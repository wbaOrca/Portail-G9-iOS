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
    @IBOutlet weak var cibleLabel: UILabel!
    
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
        cibleLabel.isHidden = true
        if(question_pilier.values.count > 0)
        {
            let monthQP = question_pilier.values.last
            if(monthQP?.isTargeted == true && monthQP!.value != true)
            {
                cibleLabel.isHidden = false
            }
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
                labelMonth.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            }else if(monthQP.value == true)
            {
                labelMonth.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            }else
            {
                labelMonth.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
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
        
        if(cibleLabel != nil){
            cibleLabel.layer.cornerRadius = 5
            cibleLabel.clipsToBounds = true
        }
    }

    
    // ***********************************
    // ***********************************
    // ***********************************
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



