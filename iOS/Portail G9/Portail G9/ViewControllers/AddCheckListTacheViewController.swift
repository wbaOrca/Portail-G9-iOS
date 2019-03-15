//
//  AddCheckListTacheViewController.swift
//  Portail G9
//
//  Created by WBA_ORCA on 15/03/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit

class AddCheckListTacheViewController: UIViewController, DateSelectionViewDelegate {

    var tache : Tache = Tache();
    
    @IBOutlet weak var titreTextField: UITextField!
    @IBOutlet weak var nomTextField: UITextField!
    @IBOutlet weak var prenomTextField: UITextField!
    @IBOutlet weak var cibleTextField: UITextField!
    
    @IBOutlet weak var dateDebutTextField: UITextField!
    @IBOutlet weak var dateFinTextField: UITextField!
    @IBOutlet weak var dateDebutButton: UIButton!
    @IBOutlet weak var dateFinButton: UIButton!
    
    @IBOutlet weak var statutButton: UIButton!
    @IBOutlet weak var compteRenduTextView: UITextView!
    
    var tag : Int = 0;
    
    // *******************************
    // **** viewDidLoad
    // *******************************
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // *******************************
    // ****
    // *******************************
    @IBAction func selectDateDebut(_ sender: Any) {
        
       
        DispatchQueue.main.async {
            self.tag = 1
            self.showDatePicker(tag: 1)
        }
    }
    // *******************************
    // ****
    // *******************************
    @IBAction func selectDateFin(_ sender: Any) {
        
        DispatchQueue.main.async {
            self.tag = 2
            self.showDatePicker(tag: 2)
        }
    }
    // *******************************
    // ****
    // *******************************
    @IBAction func selectStatut(_ sender: Any) {
    }
    // *******************************
    // ****
    // *******************************
    func showDatePicker(tag : Int){
        //Formate Date
        
        let dateSelectionView = DateSelectionView.instanceFromNib();
        dateSelectionView.setupDateSelectionView(delegateS: self, type: DateSelectionView.PICKER_DATE_DAY);
        dateSelectionView.setPickerDate(date: Date());
        self.view.addSubview(dateSelectionView);
        dateSelectionView.center = CGPoint(x:self.view.bounds.size.width/2, y:self.view.bounds.size.height/2);
        dateSelectionView.showView();
        
    }
    
    
    // *****************************************
    // *****************************************
    // ****** didSelectDate
    // *****************************************
    // *****************************************
    func didSelectDate (date : Date,dateAsString : String )
    {
       
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if(self.tag == 1)
        {
            dateDebutTextField.text = formatter.string(from: date)
        }else if(self.tag == 2)
        {
            dateFinTextField.text =  formatter.string(from: date)
        }
        
    }
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
