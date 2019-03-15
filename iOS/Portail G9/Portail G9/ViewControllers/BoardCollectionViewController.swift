//
//  BoardCollectionViewController.swift
//  Orca Trello
//
//  Created by WBA_ORCA on 26/02/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import Reachability
import NVActivityIndicatorView

// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
class BoardCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, NVActivityIndicatorViewable {
    
    var boards  : [Board]! = [Board]()
    
    var newBoard : Board = Board();
    var selectedcolor = UIColor.white {
        didSet {
            newBoard.boardColor = "#" + selectedcolor.toHex()! + "FF"
            }
    }
    
    // *******************
    // *******************
    // *******************
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddButtonItem()
        updateCollectionViewItem(with: view.bounds.size)
        
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.getBoardsData()
        
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func getBoardsData()
    {
        let reachability = Reachability()!
        if (reachability.connection == .none ) //si pas de connexion internet
        {
            let alert = UIAlertController(title: "Erreur", message: "Pas de connexion internet.\nVeuillez vous connecter svp.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return;
        }
        
        // All Correct OK
        DispatchQueue.main.async {
            let size = CGSize(width: 150, height: 50)
            self.startAnimating(size, message: "Récupération des tableaux en cours... Veuillez patienter svp...", type: NVActivityIndicatorType(rawValue: 5)!, fadeInAnimation: nil)
        }
        
        DispatchQueue.main.async{
            WSQueries.getBoardForcesTerrains(delegate: self);
        }
    }

    // *******************
    // *******************
    // *******************
    func addBoardQuery()
    {
        let reachability = Reachability()!
        if (reachability.connection == .none ) //si pas de connexion internet
        {
            let alert = UIAlertController(title: "Erreur", message: "Pas de connexion internet.\nVeuillez vous connecter svp.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return;
        }
        
        // All Correct OK
        DispatchQueue.main.async {
            let size = CGSize(width: 150, height: 50)
            self.startAnimating(size, message: "Ajout de tableau en cours... Veuillez patienter svp...", type: NVActivityIndicatorType(rawValue: 5)!, fadeInAnimation: nil)
        }
        
        DispatchQueue.main.async{
            WSQueries.addBoardForcesTerrains(delegate: self, boardName: self.newBoard.boardTitle, code_couleur: self.newBoard.boardColor);
        }
    }
    // *******************
    // *******************
    // *******************
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateCollectionViewItem(with: size)
    }
    // *******************
    // *******************
    // *******************
    private func updateCollectionViewItem(with size: CGSize) {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        layout.itemSize = CGSize(width: 225, height: size.height * 0.8)
    }
    // *******************
    // *******************
    // *******************
    func setupAddButtonItem() {
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addListTapped(_:)))
        navigationItem.rightBarButtonItem = addButtonItem
    }
    // *******************
    // *******************
    // *******************
    @objc func addListTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Ajouter un tableau", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(UIAlertAction(title: "Ajouter", style: .default, handler: { (_) in
            guard let text = alertController.textFields?.first?.text, !text.isEmpty else {
                return
            }
            
            // *** addBoard
            self.newBoard = Board(title: text)
            
            //*** select Color of the board
            guard let editorVC = self.storyboard?.instantiateViewController(withIdentifier: "ColorEditorViewController") as? ColorEditorViewController else { fatalError() }
            editorVC.delegate = self
            editorVC.selectedColor = self.selectedcolor
            editorVC.modalPresentationStyle = .overCurrentContext
            editorVC.modalTransitionStyle = .crossDissolve
            self.present(editorVC, animated: true)
            // ***
            
            //self.boards.append(self.newBoard)
            //let addedIndexPath = IndexPath(item: self.boards.count - 1, section: 0)
            //self.collectionView.insertItems(at: [addedIndexPath])
            //self.collectionView.scrollToItem(at: addedIndexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        }))
        
        alertController.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
    // *******************
    // *******************
    // *******************
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boards.count
    }
    // *******************
    // *******************
    // *******************
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! BoardCollectionViewCell
        
        cell.setup(with: boards[indexPath.item])
        cell.parentVC = self
        return cell
    }
    
}

// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
extension BoardCollectionViewController : WSGetBoardsForcesTerrainsDelegate
{
    func didFinishWSGetBoardsForcesTerrains(error: Bool, data: DataForceTerrainToDoListWSResponse!) {
        
        DispatchQueue.main.async {
            self.stopAnimating()
        }
        
        if(!error && data != nil)
        {
            
            if(data.code == WSQueries.CODE_RETOUR_200 && data.code_erreur == WSQueries.CODE_ERREUR_0)
            {
                boards = data.toDoList;
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.updateCollectionViewItem(with: self.view.bounds.size)
                   
                    if(self.boards.count > 0){
                    
                    let addedIndexPath = IndexPath(item: self.boards.count - 1, section: 0)
                    //self.collectionView.insertItems(at: [addedIndexPath])
                    self.collectionView.scrollToItem(at: addedIndexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)

                    }
                }
            }
        }else
        {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Erreur", message: "Une erreur est survenue lors de la récupération des tableaux.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return;
            }
        }
    }
    
    
}

// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++
extension BoardCollectionViewController : WSAddBoardForcesTerrainsDelegate
{
    
    func didFinishWSAddBoardForcesTerrains(error: Bool, code_erreur: Int, description: String) {
        DispatchQueue.main.async {
            self.stopAnimating()
        }
        
        if(!error)
        {
            self.getBoardsData();
        }else
        {
            let msg = "Une erreur est survenue lors de l'ajout de votre nouveau tableau.\n" + description + "\ncode = " + String(code_erreur)
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Erreur", message: msg , preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return;
            }
        }
    }
    
    
    
}

// +++++++++++++++++++++++++
// +++++++++++++++++++++++++
// +++++++++++++++++++++++++
extension BoardCollectionViewController: ColorEditorViewControllerDelegate {
    
    func viewController(didEdit color: UIColor) {
        selectedcolor = color
        
        let bgColor = "#" + selectedcolor.toHex()! + "FF"
        self.newBoard.boardColor =  bgColor
        
        DispatchQueue.main.async {
            
            self.addBoardQuery()
            
           
        }
    }
    
    
   
}
