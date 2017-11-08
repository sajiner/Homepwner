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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      
        let item = itemStore.allItems[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let item = itemStore.allItems[indexPath.row]
            itemStore.remove(item)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        itemStore.moveItem(from: fromIndexPath.row, to: to.row)
        
    }
}
