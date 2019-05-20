//
//  HomeCollectionViewCell.swift
//  Efficom
//
//  Created by WBA_ORCA on 27/09/2018.
//  Copyright © 2018 Orcaformation. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var headerCellView: UIView!
    @IBOutlet weak var backgroundCellView: UIView!
    @IBOutlet weak var labelTitre: UILabel!
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var labelAlerteBadge: UILabel!
    
    
    //**********
    //**********
    //**********
    func setupCell(startColor: UIColor, endtColor: UIColor , isHeaderVisible : Bool)
    {
        
        let colorTop =  startColor.cgColor
        let colorBottom = endtColor.cgColor
            
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.backgroundCellView.bounds
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.backgroundCellView.frame.width + 25, height: self.backgroundCellView.frame.height + 20)
        self.backgroundCellView.layer.insertSublayer(gradientLayer, at: 0)
        
        if(isHeaderVisible){
            self.headerCellView.isHidden = false
        }else
        {
            self.headerCellView.isHidden = true
        }
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
}
