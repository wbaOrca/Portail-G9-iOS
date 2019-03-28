//
//  BoardCollectionViewCell.swift
//  Orca Trello
//
//  Created by WBA_ORCA on 26/02/2019.
//  Copyright © 2019 Orcaformation. All rights reserved.
//

import UIKit
import MobileCoreServices
import Reachability
import NVActivityIndicatorView
// +++++++++++++++
// ++++++++++++++++
// ++++++++++++++++
class BoardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tableView: UITableView!
    var board: Board?
    weak var parentVC: BoardCollectionViewController?
    
    // ***********************************
    // ***********************************
    // ***********************************
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10.0
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func setup(with board: Board) {
        
        self.board = board
        self.tableView.backgroundView?.backgroundColor = UIColor.init(hexString: board.boardColor)
        self.tableView.backgroundColor =  UIColor.init(hexString: board.boardColor)
        
        tableView.reloadData()
        
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    @IBAction func addTapped(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Ajouter une tache", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(UIAlertAction(title: "Ajouter", style: .default, handler: { (_) in
            guard let text = alertController.textFields?.first?.text, !text.isEmpty else {
                return
            }
            
            guard let data = self.board else {
                return
            }
            
            let newTask = Tache()
            newTask.taskTitle = text
            newTask.boardId = (self.board?.boardId)!
            
            self.parentVC?.addChecklistToTache(tache: newTask);
           
            /*
            data.tasks.append(newTask)
            let addedIndexPath = IndexPath(item: data.tasks.count - 1, section: 0)
            
            self.tableView.insertRows(at: [addedIndexPath], with: .automatic)
            self.tableView.scrollToRow(at: addedIndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
             */
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        parentVC?.present(alertController, animated: true, completion: nil)
    }
}


// +++++++++++++++
// ++++++++++++++++
// ++++++++++++++++
extension BoardCollectionViewCell: UITableViewDataSource, UITableViewDelegate {
    
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return board?.tasks.count ?? 0
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        
        let header = view as! UITableViewHeaderFooterView
        
        if let textlabel = header.textLabel {
            textlabel.textColor = UIColor.black
            
        }
        header.backgroundColor = UIColor.init(hex: (self.board?.boardColor)!)
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return board?.boardTitle
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(board!.tasks[indexPath.row].taskTitle)"
        
        let couleur_string = board!.boardColor
        cell.backgroundColor =  UIColor.init(hexString: couleur_string)
        //cell.backgroundView?.backgroundColor =  UIColor.init(hexString: couleur_string)
        
        return cell
    }
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailsTacheVC = parentVC!.storyboard?.instantiateViewController(withIdentifier: "DetailsTacheViewController") as? DetailsTacheViewController
        detailsTacheVC?.tache = (board?.tasks[indexPath.row])!
        parentVC!.navigationController?.pushViewController(detailsTacheVC!, animated: true);
    }
    
}


// ++++++++++++++++++++
// ++++++++++++++++++++
// ++++++++++++++++++++

extension BoardCollectionViewCell: UITableViewDragDelegate {
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        /*
        guard let board = board, let stringData = board.tasks[indexPath.row].data(using: .utf8)
            else {
            return []
        }
        */
        let task = board!.tasks[indexPath.row]
        let itemProvider = NSItemProvider(object: task)
       let dragItem = UIDragItem(itemProvider: itemProvider)
       
        session.localContext = (board, indexPath, tableView)
        
        return [dragItem]
    }
    
}

// ++++++++++++++++++++
// ++++++++++++++++++++
// ++++++++++++++++++++
extension BoardCollectionViewCell: UITableViewDropDelegate {
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        
        
            coordinator.session.loadObjects(ofClass: Tache.self) { (items) in
                
                guard let task = items.first as? Tache else {
                    return
                }
                var updatedIndexPaths = [IndexPath]()
                
                switch (coordinator.items.first?.sourceIndexPath, coordinator.destinationIndexPath) {
                case (.some(let sourceIndexPath), .some(let destinationIndexPath)):
                    // Same Table View
                    if sourceIndexPath.row < destinationIndexPath.row {
                        updatedIndexPaths =  (sourceIndexPath.row...destinationIndexPath.row).map { IndexPath(row: $0, section: 0) }
                    } else if sourceIndexPath.row > destinationIndexPath.row {
                        updatedIndexPaths =  (destinationIndexPath.row...sourceIndexPath.row).map { IndexPath(row: $0, section: 0) }
                    }
                    self.tableView.beginUpdates()
                    self.board?.tasks.remove(at: sourceIndexPath.row)
                    self.board?.tasks.insert(task, at: destinationIndexPath.row)
                    self.tableView.reloadRows(at: updatedIndexPaths, with: .automatic)
                    self.tableView.endUpdates()
                    break
                    
                case (nil, .some(let destinationIndexPath)):
                    // Move data from a table to another table
                    self.removeSourceTableData(localContext: coordinator.session.localDragSession?.localContext)
                    self.tableView.beginUpdates()
                    self.board?.tasks.insert(task, at: destinationIndexPath.row)
                    self.tableView.insertRows(at: [destinationIndexPath], with: .automatic)
                    self.tableView.endUpdates()
                    break
                    
                    
                case (nil, nil):
                    // Insert data from a table to another table
                    self.removeSourceTableData(localContext: coordinator.session.localDragSession?.localContext)
                    self.tableView.beginUpdates()
                    self.board?.tasks.append(task)
                    self.tableView.insertRows(at: [IndexPath(row: self.board!.tasks.count - 1 , section: 0)], with: .automatic)
                    self.tableView.endUpdates()
                    break
                    
                default: break
                    
                }
            }
        
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func removeSourceTableData(localContext: Any?) {
        if let (dataSource, sourceIndexPath, tableView) = localContext as? (Board, IndexPath, UITableView) {
            tableView.beginUpdates()
            dataSource.tasks.remove(at: sourceIndexPath.row)
            tableView.deleteRows(at: [sourceIndexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    // ***********************************
    // ***********************************
    // ***********************************
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    
}






