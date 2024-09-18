//
//  ViewController.swift
//  CoreDatas
//
//  Created by Talha's Macbook on 17/09/2024.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var toDoTableView: UITableView!
    @IBOutlet weak var addBtn: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Data source for the table view
    var items: [ToDoListitem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the custom cell
        toDoTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        
        // Load items from Core Data
        getAllItems()
    }

    // MARK: - UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }

    // MARK: - Core Data Functions
    
    func getAllItems() {
        do {
            items = try context.fetch(ToDoListitem.fetchRequest())
            DispatchQueue.main.async {
                self.toDoTableView.reloadData()
            }
        } catch {
            print("Error fetching data")
        }
    }
    
    func createItem(name: String) {
        let newItem = ToDoListitem(context: context)
        newItem.name = name
        newItem.createdat = Date()
        
        do {
            try context.save()
            getAllItems()  // Refresh the table view after saving
        } catch {
            print("Error saving item")
        }
    }
    
    func deleteItem(item: ToDoListitem) {
        context.delete(item)
        
        do {
            try context.save()
            getAllItems()  // Refresh the table view after deletion
        } catch {
            print("Error deleting item")
        }
    }
    
    func updateItem(item: ToDoListitem, newName: String) {
        item.name = newName
        
        do {
            try context.save()
            getAllItems()  // Refresh the table view after updating
        } catch {
            print("Error updating item")
        }
    }
    
    // MARK: - Add Button Action
    
    @IBAction func didTapAdd(_ sender: UIButton) {
        // Create an alert controller with a text field
        let alert = UIAlertController(title: "New Item", message: "Enter item name", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Item name"
        }
        
        // Define the action when the user taps "Submit"
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self] _ in
            guard let textField = alert.textFields?.first, let text = textField.text, !text.isEmpty else {
                return
            }
            
            // Create a new item with the entered text
            self?.createItem(name: text)
        }
        
        // Add actions to the alert
        alert.addAction(submitAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // Present the alert
        present(alert, animated: true, completion: nil)
    }
}
