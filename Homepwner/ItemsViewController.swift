//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by sajiner on 2017/11/8.
//  Copyright © 2017年 张鑫. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {

    var itemStore : ItemStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    @IBAction func addNewItem(_ sender: UIButton) {
        let newItem = itemStore.creatItem()
        if let index = itemStore.allItems.index(of: newItem) {
            let indexPath = IndexPath(item: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
    }
    
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        if isEditing {
            sender.setTitle("Edit", for: .normal)
            setEditing(false, animated: true)
        } else {
            sender.setTitle("Done", for: .normal)
            setEditing(true, animated: true)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemStore.allItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemCell
        let item = itemStore.allItems[indexPath.row]
        cell.nameLabel.text = item.name
        if indexPath.row != itemStore.allItems.count - 1 {
            cell.serialLabel.text = item.serialNumber
            cell.valueLabel.text = "$\(item.valueInDollars)"
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
        } else if editingStyle == .insert {
            
        }    
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action0 = UITableViewRowAction(style: .destructive, title: "Remove") { (action: UITableViewRowAction, indexPath: IndexPath) in
            let item = self.itemStore.allItems[indexPath.row]
            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive,
                                             handler: { (action) -> Void in
                                                self.itemStore.remove(item)
                                                tableView.deleteRows(at: [indexPath], with: .fade)
            })
            ac.addAction(deleteAction)
            self.present(ac, animated: true, completion: nil)
        }
        return [action0]
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == itemStore.allItems.count - 1 {
            return false
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        itemStore.moveItem(from: fromIndexPath.row, to: to.row)
        
    }
    
    /// 禁止某一行移动，但是不能禁止其他行移动到其下边
   override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == itemStore.allItems.count - 1 {
            return false
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if proposedDestinationIndexPath.row < itemStore.allItems.count - 1 {
            return proposedDestinationIndexPath
        }
        return sourceIndexPath
    }
}
