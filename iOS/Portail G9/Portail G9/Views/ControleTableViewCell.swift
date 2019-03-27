//
//  ControleTableViewCell.swift
//  Portail G9
//
//  Created by WBA_ORCA on 05/03/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit

// ++++++++++++++++
// ++++++++++++++++
// ++++++++++++++++
class ControleTableViewCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelTarget: UILabel!
    @IBOutlet weak var labelDateDebut: UILabel!
    @IBOutlet weak var labelDateFin: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var labelComteRendu: UILabel!
    
    // ***********************************
    // ***********************************
    // ***********************************
    func setupCell(checkList : CheckList)
    {
        labelName.text = checkList.checkListPrenom + " " + checkList.checkListNom
        labelTarget.text = checkList.checkListTarget
        
        labelComteRendu.text = checkList.checkListReport
        labelStatus.text = checkList.checkListStatut
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd-MM-yyyy"
        
        labelDateDebut.text = dateFormatterGet.string(from: checkList.checkListStart)
        labelDateFin.text = dateFormatterGet.string(from: checkList.checkListEnd)
        
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
