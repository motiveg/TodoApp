//
//  TodoModelTests.swift
//  TodoAppTests
//
//  Created by Brian Casipit on 10/14/18.
//  Copyright © 2018 motiveg. All rights reserved.
//

import XCTest
import CoreData
@testable import TodoApp

struct DefaultProperties {
    
}

class TodoModelTests: XCTestCase {
    
    // use the same context and entity for tests
    let context = Persist.context
    let entity: NSEntityDescription = Todo.entity()
    
    // instantiated values upon creating a new Todo
    let instantiate_date: String? = nil
    let instantiate_task: String? = nil
    let instantiate_completion = false
    
    // default values when
    var default_date: String = "" // change in setUp()
    let default_task: String = ""
    let default_completion = false
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let testDate = Date()
        let testFormat = DateFormatter()
        testFormat.dateFormat = "MM/dd/yy"
        default_date = testFormat.string(from: testDate)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_instantiation() {
        let testTodo = Todo.init(entity: entity, insertInto: context)
        
        XCTAssertEqual(testTodo.date, instantiate_date, "Error: unexpected instance date")
        XCTAssertEqual(testTodo.task, instantiate_task, "Error: unexpected instance task")
        XCTAssertEqual(testTodo.completed, instantiate_completion, "Error: unexpected instance completion")
    }
    
    func test_initializeProperties() {
        let testTodo = Todo.init(entity: entity, insertInto: context)
        testTodo.setDefaultValues()
        
        XCTAssertEqual(testTodo.date, default_date, "Error: unexpected instance date")
        XCTAssertEqual(testTodo.task, default_task, "Error: unexpected instance task")
        XCTAssertEqual(testTodo.completed, default_completion, "Error: unexpected instance completion")
    }
    
    func test_taskChanged() {
        let testTodo = Todo.init(entity: entity, insertInto: context)
        testTodo.setDefaultValues()
        XCTAssertEqual(testTodo.task, default_task, "Error: unexpected initial task")
        
        let testTask = "This is a task"
        testTodo.task = testTask
        XCTAssertNotEqual(testTodo.task, default_task, "Error: task was not changed")
    }
    
    func test_completionChanged() {
        let testTodo = Todo.init(entity: entity, insertInto: context)
        testTodo.setDefaultValues()
        XCTAssertEqual(testTodo.completed, default_completion, "Error: unexpected initial completion")
        
        let testCompletion = true
        testTodo.completed = testCompletion
        XCTAssertNotEqual(testTodo.completed, default_completion, "Error: completion was not changed")
    }

}
