//
//  BaseTableViewController.swift
//  ShoppingList
//
//  Created by Singkorn Dhepyasuvan on 29/5/2561 BE.
//  Copyright © 2561 Jartown. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
    
    func requestInput(title: String, message: String, handler: @escaping (String) -> ()) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (_) in
            if let listName = alert.textFields?[0].text {
                handler(listName)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}