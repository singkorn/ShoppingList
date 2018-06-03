//
//  ItemTableTableViewController.swift
//  ShoppingList
//
//  Created by Singkorn Dhepyasuvan on 26/5/2561 BE.
//  Copyright © 2561 Jartown. All rights reserved.
//

import UIKit

class ItemTableTableViewController: BaseTableViewController {
    // var items: [Item] = [Item.fake(itemCount: 20)]
    // var items: [Item] = [Item].load() {
    //     didSet {
    //         items.save()
    //     }
    // }
    
    var list: ShoppingList!
    var items: [Item] {
        get {
            return list.items
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = list.name
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItems?.append(editButtonItem)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        let item = items[indexPath.row]
        cell.textLabel?.text = item.name
        
        if item.isChecked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }

    @IBAction func didSelectAdd(_ sender: UIBarButtonItem) {
        requestInput(title: "New shopping list item", message: "Enter item to add to the shopping list:", handler: { (itemName) in
            let itemCount = self.items.count;
            let item = Item(name: itemName)
            self.list.add(item)
            self.tableView.insertRows(at: [IndexPath(row: itemCount, section: 0)], with: .top)
        })
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        // let item = list.remove(at: fromIndexPath.row)
        list.swapItem(fromIndexPath.row, to.row)
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // let item = items[indexPath.row]
        // item.isChecked = !item.isChecked
        // items[indexPath.row] = items[indexPath.row].toggleCheck()
        list.toggleCheckItem(atIndex: indexPath.row)
        tableView.reloadRows(at: [indexPath], with: .middle)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
