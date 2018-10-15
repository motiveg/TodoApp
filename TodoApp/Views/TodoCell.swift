//
//  TodoCell.swift
//  TodoApp
//
//  Created by Brian Casipit on 10/11/18.
//  Copyright © 2018 motiveg. All rights reserved.
//

import UIKit

class TodoCell: UITableViewCell {

    @IBOutlet weak var completionButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var taskLabel: UILabel!
    
    var todo: Todo! {
        willSet(newTodo) {
            
            completionButton.setImage(UIImage(named: "empty-checkbox"), for: UIControl.State.normal)
            completionButton.setImage(UIImage(named: "checked-checkbox"), for: UIControl.State.selected)
            
            if newTodo.completed { completionButton.isSelected = true }
            else { completionButton.isSelected = false }
            
            dateLabel.text = newTodo.date
            taskLabel.text = newTodo.task
        }
    }
    
    // QUESTION: Should this be taken care of in the view controller?
    @IBAction func didTapCompletionButton(_ sender: Any) {
        todo.completed = !todo.completed
        if todo.completed {
            completionButton.isSelected = true
        } else {
            completionButton.isSelected = false
        }
        Persist.saveContext()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
