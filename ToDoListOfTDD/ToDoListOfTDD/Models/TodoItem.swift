//
//  todoItem.swift
//  ToDoListOfTDD
//
//  Created by 최우태 on 2023/05/29.
//

import Foundation
import CoreLocation
struct TodoItem {
    var title : String?
    var description : String?
    var plannedDate : Date?
    var todoLocation : CLLocationCoordinate2D?
    
    init(title: String, description: String, plannedDate: Date, todoLocation: CLLocationCoordinate2D) {
        self.title = title
        self.description = description
        self.plannedDate = plannedDate
        self.todoLocation = todoLocation
    }
}
