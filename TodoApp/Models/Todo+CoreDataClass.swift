//
//  Todo+CoreDataClass.swift
//  TodoApp
//
//  Created by Brian Casipit on 10/13/18.
//  Copyright © 2018 motiveg. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Todo)
public class Todo: NSManagedObject {
    
    func setCurrentDate() {
        let current_date = Date()
        let format = DateFormatter()
        format.dateFormat = "MM/dd/yy"
        date = format.string(from: current_date)
    }
    
    func setDefaultValues() {
        setCurrentDate()
        task = ""
        completed = false
    }
    
}
