//
//  TodoDetailViewController.swift
//  TodoApp
//
//  Created by Brian Casipit on 10/11/18.
//  Copyright © 2018 motiveg. All rights reserved.
//

import UIKit

class TodoDetailViewController: UIViewController {
    
    @IBOutlet weak var todoDetail: TodoDetail!
    
    var todo: Todo!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        todoDetail.todo = todo
    }
    
    // tap outside of text field to resign keyboard
    @IBAction func didTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Persist.saveContext()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
