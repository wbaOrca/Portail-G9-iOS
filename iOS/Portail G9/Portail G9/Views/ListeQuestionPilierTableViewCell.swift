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
    @IBOutlet weak var tableViewQuestions: UITableView!
    
    var mItem : ItemQuestionPilier = ItemQuestionPilier()
    
    // ***********************************
    // ***********************************
    // ***********************************
    func setupQuestionPilierCell(question_pilier : ItemQuestionPilier)
    {
        titleLabel.text = question_pilier.category
        mItem = question_pilier
        tableViewQuestions.reloadData()
        
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


// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++
extension ListeQuestionPilierTableViewCell: UITableViewDataSource , UITableViewDelegate {
    
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mItem.questions.count
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionPilierTableViewCell", for: indexPath) as! QuestionPilierTableViewCell
        
        let row = indexPath.row
        
        
        if(row < mItem.questions.count)
        {
            let qpilier = mItem.questions[row] ;
            cell.setupQuestionPilierCell(question_pilier: qpilier);
        }
        
        return cell;
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // let qpilier = self.arrayQuestionPiliers[indexPath.row] ;
        
    }
}
