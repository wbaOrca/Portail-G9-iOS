//
//  DateSelectionViewDelegate.swift
//  Lizmer
//
//  Created by Wassim Bassalah on 01/11/2016.
//  Copyright © 2016 Orcaformation. All rights reserved.
//

import UIKit

protocol DateSelectionViewDelegate: class {
    
    func didSelectDate (date : Date,dateAsString : String );
    
    
    
}

class DateSelectionView : UIView  {

    weak var delegate: DateSelectionViewDelegate?
    
    @IBOutlet weak var backgroundView: UIView?
    @IBOutlet weak var pickerView: UIDatePicker?
    @IBOutlet weak var labelTitre : UILabel?
    @IBOutlet weak var buttonValider: UIButton?
    @IBOutlet weak var buttonAnnuler: UIButton?
    
    
    var typeSelection : Int = 0;
    var mCurrentSelection : Int!
    
    public static let PICKER_DATE_DAY = 1
   
    
    // *****************************************
    // *****************************************
    // ****** instanceFromNib
    // *****************************************
    // *****************************************
    public static func instanceFromNib() -> DateSelectionView
    {
        return UINib(nibName: "DateSelectionView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! DateSelectionView
    }
    
    // *****************************************
    // *****************************************
    // ****** setupDateSelectionView
    // *****************************************
    // *****************************************
    public func setupDateSelectionView (delegateS: DateSelectionViewDelegate, type : Int)
    {
        self.delegate = delegateS;
        
        typeSelection = type;
        pickerView?.tag = typeSelection;
        //pickerView?.maximumDate =  Date();
        mCurrentSelection = 0;
        
        
    }
    // *****************************************
    // *****************************************
    // ****** setPickerDate
    // *****************************************
    // *****************************************
    public func setPickerDate (date: Date)
    {
        pickerView?.setDate(date, animated: false);
    }
    
    // *****************************************
    // *****************************************
    // ****** showView
    // *****************************************
    // *****************************************
    public func showView ()
    {
        
        self.transform = CGAffineTransform (scaleX: 0.1, y: 0.1);
        self.alpha=0.5;
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.beginFromCurrentState, .curveEaseOut], animations: {
            
            self.transform = CGAffineTransform (scaleX: 1, y: 1);
            self.alpha = 1.0 ;
            
            
            }, completion: nil)
    }
    
    // *****************************************
    // *****************************************
    // ****** hideView
    // *****************************************
    // *****************************************
    public func hideView ()
    {
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.beginFromCurrentState, .curveEaseOut], animations: {
            
            self.transform = CGAffineTransform (scaleX: 0.01, y: 0.01);
            self.alpha = 1.0 ;
            
            }, completion: { (finished) -> Void in
                self.removeFromSuperview();
        })
    }

    // *****************************************
    // *****************************************
    // ****** validerAction
    // *****************************************
    // *****************************************
    @IBAction func validerAction(sender: UIButton)
    {
        switch typeSelection {
        case DateSelectionView.PICKER_DATE_DAY:
            
            // Create date formatter
            let dateFormatter: DateFormatter = DateFormatter()
            
            // Set date format
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            // Apply date format
            let selectedDate: String = dateFormatter.string(from: pickerView!.date)
            
            delegate?.didSelectDate(date: (pickerView?.date)!, dateAsString: selectedDate);
            break;
        
            
        default:
            break;
        }
        
        hideView();
    }
    // *****************************************
    // *****************************************
    // ****** annulerAction
    // *****************************************
    // *****************************************
    @IBAction func annulerAction(sender: UIButton)
    {
        hideView();
    }
   
    // *****************************************
    // *****************************************
    // ****** draw
    // *****************************************
    // *****************************************
    override func draw(_ rect: CGRect) {
        
        backgroundView!.layer.borderColor = #colorLiteral(red: 0.9991517663, green: 0.8007791638, blue: 0.198880434, alpha: 1) ;
        backgroundView!.layer.borderWidth = 2;
        
        
        switch typeSelection {
            
        case DateSelectionView.PICKER_DATE_DAY :
            
            labelTitre?.text="Sélectionner une date";
            break;
        
        default:
            break;
        }
    }
    
}
