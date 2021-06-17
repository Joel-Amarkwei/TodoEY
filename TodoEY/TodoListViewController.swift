//
//  ViewController.swift
//  TodoEY
//
//  Created by Joel Codjoe on 10/06/2021.
//

import UIKit

class TodoListViewController: UITableViewController {

    var todoList = ["Washing", "Ironing", "Cleaning"]
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            todoList = items
        }
        // Do any additional setup after loading the view.
    }

    //MARK :- Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = todoList[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    //MARK :- Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(todoList[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark  {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK :- Adding new items to the TODO list
    @IBAction func addItem(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new todo item", message: "Kindly add a new todo item", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { action in
            //what happens now.....
            self.todoList.append(textField.text!)
            print(textField.text!)
            
            //self.defaults.setValue(self.todoList, forKey: "TodoListArray")
            self.defaults.set(self.todoList, forKey: "TodoListArray")
            self.tableView.reloadData()
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Add new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

