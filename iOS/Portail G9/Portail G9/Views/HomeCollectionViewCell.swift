//
//  HomeCollectionViewCell.swift
//  Efficom
//
//  Created by WBA_ORCA on 27/09/2018.
//  Copyright © 2018 Orcaformation. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    
   
    @IBOutlet weak var labelTitre: UILabel!
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var labelAlerteBadge: UILabel!
    
    override var isHighlighted: Bool {
        didSet {
            self.contentView.backgroundColor = isHighlighted ? #colorLiteral(red: 0.9991517663, green: 0.8007791638, blue: 0.198880434, alpha: 1) : nil
            imageBackground.backgroundColor = isHighlighted ? #colorLiteral(red: 0.9991517663, green: 0.8007791638, blue: 0.198880434, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6)
        }
        
    }
    override var isSelected: Bool {
        didSet {
            self.contentView.backgroundColor = isSelected ? #colorLiteral(red: 0.9991517663, green: 0.8007791638, blue: 0.198880434, alpha: 1) : nil
            imageBackground.backgroundColor = isSelected ? #colorLiteral(red: 0.9991517663, green: 0.8007791638, blue: 0.198880434, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6)
        }
        
    }
    
    //**********
    //**********
    //**********
    func setupCell_2(icon_image: String,icon_highlight: String, titre : String)
    {
        imageIcon.image = UIImage(named: icon_image)
        imageIcon.highlightedImage =  UIImage(named: icon_highlight)
        labelTitre.text = titre
     }
    
    
    
    //**********
    //**********
    //**********
    func setupBadge(badge : Int)
    {
        labelAlerteBadge.text = String(badge)
        
        if(badge < 1)
        {
            labelAlerteBadge.isHidden = true
        }else
        {
            labelAlerteBadge.isHidden = false
        }
    }
    
    //**********
    //**********
    //**********
    override func awakeFromNib() {
        
        labelAlerteBadge.layer.cornerRadius = labelAlerteBadge.frame.size.width / 2
        labelAlerteBadge.layer.borderWidth = 0
        labelAlerteBadge.clipsToBounds = true
        labelAlerteBadge.textColor = .white
        labelAlerteBadge.backgroundColor = #colorLiteral(red: 0.9994991422, green: 0.3059307337, blue: 0.2897390127, alpha: 1)
    }
    
    override func prepareForInterfaceBuilder() {
        print("")
    }
}
