//
//  TodoModel.swift
//  SimpleDownload
//
//  Created by Dominik Auinger on 24.01.22.
//

class Todo {
    var title = ""
    var id = 0
    var userId = 0
    var completed = false
}

class TodoModel {
    var todos = [Todo]()
}
