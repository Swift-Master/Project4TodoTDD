import Foundation


class ModelManager {
    
    var todoQuantity : Int {
        return todoGroup.count
    }
    var doneQuantity : Int {
        return doneGroup.count
    }
    
    private var todoGroup = [TodoItem]()
    private var doneGroup = [TodoItem]()
    
    
    func addItem(_ item : TodoItem) {
        todoGroup.append(item)
    }
    
    func item(at index : Int) -> TodoItem {
        return todoGroup[index]
    }
    
    func doneItem(at index : Int) -> TodoItem {
        return doneGroup[index]
    }
    
    func checkItem(at index : Int) {
        let checkedTodo = todoGroup.remove(at: index)
        doneGroup.append(checkedTodo)
    }
    
    func uncheckItem(at index : Int) {
        let uncheckedTodo = doneGroup.remove(at: index)
        todoGroup.append(uncheckedTodo)
    }
    
    func clearItem(at indexPath : IndexPath) {
        let section = indexPath.section, row = indexPath.row
        switch section {
        case 0 : todoGroup.remove(at: row)
        case 1 : doneGroup.remove(at: row)
        default : break
        }
    }
}
