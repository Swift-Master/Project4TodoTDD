//
//  TodoListDataProvider.swift
//  ToDoListOfTDD
//
//  Created by 최우태 on 2023/05/29.
//

import UIKit

enum TodoType : Int {
    case todo
    case done
}

class TodoListDataProvider : NSObject {
    var itemManager : ModelManager?
}

extension TodoListDataProvider : UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let itemManager = itemManager else {return 0}
        
        var numberOfRows = 0
        switch TodoType(rawValue : section) {
        case .todo : numberOfRows = itemManager.todoQuantity
        case .done : numberOfRows = itemManager.doneQuantity
        default : fatalError()
        }
        
        return numberOfRows
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoItemCell.cellIdentifier) as! TodoItemCell
        guard let itemManager = itemManager else {return cell}
        var currentItem : TodoItem
        switch TodoType(rawValue: indexPath.section) {
        case .todo : currentItem = itemManager.item(at: indexPath.row)
        case .done : currentItem = itemManager.doneItem(at: indexPath.row)
        default : fatalError()
        }
        
        // 커스텀 셀 만든 후 구성요소 할당해주는 로직 필요
        cell.titleLabel.text = currentItem.title
        cell.dateLabel.text = currentItem.todoDate
        cell.locationLabel.text = currentItem.todoLocation?.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if TodoType(rawValue: indexPath.section) == .done {return}
        
        guard let itemManager = itemManager else {return}
        NotificationCenter.default.post(name: Notification.ItemSelectedNotification, object: self,userInfo: ["index":indexPath.row])
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard let manager = itemManager else {return}
        if editingStyle == .delete {
            switch TodoType(rawValue: indexPath.section) {
            case .done : manager.uncheckItem(at: indexPath.row)
            case .todo : manager.checkItem(at: indexPath.row)
            default : print("에러 발생")
            }
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let manager = itemManager else {return nil}
        var sectionTitle : String?
        switch TodoType(rawValue: section) {
        case .done : sectionTitle = "완료한 일(\(manager.doneQuantity))"
        case .todo : sectionTitle = "해야 할 일(\(manager.todoQuantity))"
            default : break
        }
        return sectionTitle
    }

    

}
