//
//  ViewController.swift
//  coreRealmTableView
//
//  Created by IMAC on 8/29/19.
//  Copyright © 2019 IMAC. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var itemArray = ["Find Mike","Buy car"," Demo List"]
    
    let defaults = UserDefaults.standard  //It is used to create Persistant local data storage

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let items = defaults.array(forKey: "NewArrayList") as? [String] {
            
            itemArray = items //This is used to show the data ande store in array
            
        }
    }
    //MARK : - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoList", for: indexPath)
       
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //Mark : - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    @IBAction func addList(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add an event", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Add Item", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
            
            self.itemArray.append(textField.text!)
            
            self.defaults.set(self.itemArray, forKey: "NewArrayList") //This is used to set the data in defaults as user persistance
            
            self.tableView.reloadData()
        }))
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter item name"
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
        
        print("Selected")
    }
    

    
}

//let defaults = UserDefaults.standard
//itemArray = defaults.array(forKey: "NewArrayList") as! [String]  // in view DidLoad
// self.defaults.set(self.itemArray, forKey: "NewArrayList")    // in button action alert action
