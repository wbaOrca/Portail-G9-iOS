//
//  ListePilierTableViewCell.swift
//  Portail G9
//
//  Created by WBA_ORCA on 04/04/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit

// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
protocol EditQuestionPilierDelegate {
    
    func okNokQuestionPilier(qp : QuestionPilier , isOk : Bool)
    func addCommentaireQuestionPilier(qp : QuestionPilier)
    func planActionQuestionPilier(qp : QuestionPilier)
}

// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
class QuestionPilierTableViewCell: UITableViewCell {

    
    @IBOutlet weak var buttonPlanAction: UIButton!
    @IBOutlet weak var buttonCommentaire: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentaireLabel: UILabel!
    @IBOutlet weak var majLabel: UILabel!
    @IBOutlet weak var cibleIcon: UIImageView!
    
    @IBOutlet weak var segmentValue: UISegmentedControl?
    
    
    
    var qp : QuestionPilier = QuestionPilier()
    var delegate : EditQuestionPilierDelegate! = nil
    
    // ***********************************
    // ***********************************
    // ***********************************
    func setupQuestionPilierCell(delegate : EditQuestionPilierDelegate ,question_pilier : QuestionPilier)
    {
        
        self.delegate = delegate;
        self.qp = question_pilier ;
        
        titleLabel.text = question_pilier.libelle
        
        majLabel.text = question_pilier.derniereMAJ
        commentaireLabel.text = question_pilier.commentaire
        
        
        buttonPlanAction.isHidden = true
        cibleIcon.isHidden = true
        if(question_pilier.values.count > 0)
        {
            let monthQP = question_pilier.values.last
            if(monthQP?.isTargeted == true && monthQP!.value != true)
            {
                cibleIcon.isHidden = false
            }
            
            if(monthQP!.value == nil)
            {
                segmentValue?.selectedSegmentIndex = -1
            }else if(monthQP!.value == true)
            {
                segmentValue?.selectedSegmentIndex = 0
            }else
            {
                segmentValue?.selectedSegmentIndex = 1
                
                var isLastTargeted : Bool! = nil
                isLastTargeted = monthQP!.isTargeted
                if(isLastTargeted != true )
                {
                    buttonPlanAction.isHidden = false
                }
            }
        }
        
        
        
        
        
    }
    
    // *******************************
    // **** updateQuestionAction
    // *******************************
    @IBAction func changeOkNok (_ sender: UISegmentedControl!) {
        
        var isOk = false
        if(self.segmentValue?.selectedSegmentIndex == 0)
        {
            isOk = true
        }
        if(self.qp.values.count > 0)
        {
           self.delegate.okNokQuestionPilier(qp: self.qp, isOk : isOk)
        }
    }
    
    // *******************************
    // **** planActionQuestionPilier
    // *******************************
    @IBAction func planActionQuestionPilier (_ sender: UIButton!) {
    
        self.delegate.planActionQuestionPilier(qp: self.qp)
    }
    
    // *******************************
    // **** commentaireQuestionPilier
    // *******************************
    @IBAction func commentaireQuestionPilier (_ sender: UIButton!) {
        self.delegate.addCommentaireQuestionPilier(qp: self.qp)
    }
    // ***********************************
    // ***********************************
    // ***********************************
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
        buttonPlanAction.layer.cornerRadius = 5
        buttonPlanAction.clipsToBounds = true
        buttonCommentaire.layer.cornerRadius = 5
        buttonCommentaire.clipsToBounds = true
    }

    
    // ***********************************
    // ***********************************
    // ***********************************
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



