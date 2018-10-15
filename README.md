# TodoApp

Student: Brian Casipit

Language: Swift 4.2

Tested for iOS 12.0

## Overview

This app keeps track of tasks for users in a "todo list".

## How to Use

- The main view controller lists all tasks todo.
- The user can create a new task by pressing the add button on the right side of the top navigation bar.
- The tasks can also be filtered by completion using the button on the left side of the top navigation bar.
- Completion of tasks can be set on the main view controller and inside the detailed view controller. 
- Task descriptions can be set and edited inside the detailed view controller.
- Tasks can be deleted by swiping right on the tasks on the main view controller. Swiping all the way will delete the task. Also, partially swiping and tapping on the red "Delete" button will delete the task.
- Tasks are saved as long as the app is not deleted and/or the device is not reset.

## Models

Todo (using Core Data)
- date: String
- task: String
- completion: Bool

## Preview

<img src='https://github.com/motiveg/TodoApp/raw/master/TodoAppDemo.gif' title='Video Preview' width='' alt='Preview' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Copyright [2018] [Brian Casipit]
