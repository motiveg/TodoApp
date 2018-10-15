//
//  TodoDetail.swift
//  TodoApp
//
//  Created by Brian Casipit on 10/11/18.
//  Copyright © 2018 motiveg. All rights reserved.
//

import UIKit

class TodoDetail: UIView, UITextViewDelegate {

    @IBOutlet weak var completionButton: UIButton!
    @IBOutlet weak var taskTextView: UITextView!
    
    var todo: Todo! {
        willSet(newTodo) {
            
            taskTextView.layer.cornerRadius = 8.0
            taskTextView.layer.masksToBounds = true
            
            completionButton.setImage(UIImage(named: "empty-checkbox"), for: UIControl.State.normal)
            completionButton.setImage(UIImage(named: "checked-checkbox"), for: UIControl.State.selected)
            
            if newTodo.completed { completionButton.isSelected = true }
            else { completionButton.isSelected = false }
            
            taskTextView.text = newTodo.task
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        taskTextView.delegate = self
    }
    
    // QUESTION: Should this be taken care of in the view controller?
    @IBAction func didTapCompletionButton(_ sender: Any) {
        completionButton.isSelected = !completionButton.isSelected
        todo.completed = !todo.completed
    }
    
    // QUESTION: Should this be taken care of in the view controller?
    func textViewDidChange(_ textView: UITextView) {
        todo.task = taskTextView.text
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
