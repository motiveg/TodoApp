//
//  Todo+CoreDataProperties.swift
//  TodoApp
//
//  Created by Brian Casipit on 10/13/18.
//  Copyright © 2018 motiveg. All rights reserved.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var task: String?
    @NSManaged public var date: String?
    @NSManaged public var completed: Bool

}
