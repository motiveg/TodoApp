//
//  TodoViewController.swift
//  TodoApp
//
//  Created by Brian Casipit on 10/11/18.
//  Copyright © 2018 motiveg. All rights reserved.
//

import UIKit
import CoreData

struct TodoFilterSelectionColors {
    let not_done_normal = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
    let done_normal = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
    let all_normal = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
    let selected = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
}

class TodoViewController: UIViewController, UITableViewDataSource {
    
    enum TodoFilter {
        case not_done
        case done
        case all
        
        func getIndex() -> Int {
            switch self {
            case TodoFilter.not_done:
                return 0
            case TodoFilter.done:
                return 1
            case TodoFilter.all:
                return 2
            }
        }
    }

    @IBOutlet weak var tableView: UITableView!
    
    var todos: [Todo] = []
    var filteredTodos: [Todo] = []
    var todoFilter = TodoFilter.all // default to show all
    var todoFilterSelectionColor = TodoFilterSelectionColors()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest: NSFetchRequest<Todo> = Todo.fetchRequest()
        do {
            let todos = try Persist.context.fetch(fetchRequest)
            self.todos = todos
        } catch{
            // do something to catch error
        }

        tableView.dataSource = self
        tableView.reloadData()
        
        // set "All" nav item's color by default
        navigationItem.leftBarButtonItems![TodoFilter.all.getIndex()].tintColor = todoFilterSelectionColor.selected
    }
    
    // UPDATES WHEN COMING BACK TO MAIN VIEW CONTROLLER //
    override func viewWillAppear(_ animated: Bool) {
        changeFilteredItems(filterName: todoFilter)
        tableView.reloadData()
    }
    
    // BUTTON ACTIONS //
    @IBAction func didTapNotDone(_ sender: Any) {
        changeFilter(filterName: TodoFilter.not_done)
        tableView.reloadData()
    }
    @IBAction func didTapDone(_ sender: Any) {
        changeFilter(filterName: TodoFilter.done)
        tableView.reloadData()
    }
    @IBAction func didTapAll(_ sender: Any) {
        changeFilter(filterName: TodoFilter.all)
        tableView.reloadData()
    }
    
    // HELPER METHODS FOR BUTTON ACTIONS //
    func changeFilter(filterName: TodoFilter) {
        filterColorToNormal(filterName: self.todoFilter) // colors back to normal
        self.todoFilter = filterName // set new filter
        filterColorToSelected(filterName: self.todoFilter) // change selected filter's color
        changeFilteredItems(filterName: self.todoFilter) // update table
    }
    func getSelectionColor(filterName: TodoFilter) -> UIColor {
        if filterName == TodoFilter.not_done { return todoFilterSelectionColor.not_done_normal }
        if filterName == TodoFilter.done { return todoFilterSelectionColor.done_normal }
        if filterName == TodoFilter.all { return todoFilterSelectionColor.all_normal }
        return UIColor.white // default to white
    }
    func filterColorToNormal(filterName: TodoFilter) {
        navigationItem.leftBarButtonItems![filterName.getIndex()].tintColor = getSelectionColor(filterName: filterName)
    }
    func filterColorToSelected(filterName: TodoFilter) {
        navigationItem.leftBarButtonItems![filterName.getIndex()].tintColor = todoFilterSelectionColor.selected
    }
    func changeFilteredItems(filterName: TodoFilter) {
        if !filteredTodos.isEmpty { filteredTodos.removeAll() }
        
        if todoFilter == TodoFilter.not_done {
            for todo in todos { if !todo.completed { filteredTodos.append(todo) } }
        } else if todoFilter == TodoFilter.done {
            for todo in todos { if todo.completed { filteredTodos.append(todo) } }
        } else {
            for todo in todos { filteredTodos.append(todo) }
        }
    }
    
    // TABLEVIEW METHODS //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return filteredTodos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoCell
        cell.todo = filteredTodos[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let selected_todo = todos[indexPath.row]
            Persist.context.delete(selected_todo)
            Persist.saveContext()
            todos.remove(at: indexPath.row)
            changeFilteredItems(filterName: todoFilter)
            tableView.reloadData()
        }
    }
    
    // SEGUE PREPARATION //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // set destination view controller
        let newDVC = segue.destination as! TodoDetailViewController
        
        if segue.identifier == "NewTodoSegue" {
            // create and append new todo to list
            let newTodo = Todo(context: Persist.context)
            newTodo.setDefaultValues()
            Persist.saveContext()
            todos.append(newTodo)
            filteredTodos.append(newTodo) // table will update after coming back
            
            // insert new cell into tableview
            tableView.beginUpdates()
            let newIndexPath = [IndexPath(row: filteredTodos.count - 1, section: 0)]
            tableView.insertRows(at: newIndexPath, with: .automatic)
            tableView.endUpdates()
            
            // pass todo to next view controller
            newDVC.todo = newTodo
        }
        if segue.identifier == "EditTodoSegue" {
            let todoCell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: todoCell) {
                let todo = filteredTodos[indexPath.row]
                newDVC.todo = todo
            }
        }
    }

}
