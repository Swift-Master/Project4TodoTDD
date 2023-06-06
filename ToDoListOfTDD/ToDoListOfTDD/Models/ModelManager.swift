
import Foundation

// MARK: - 모델 객체를 관리하는 공유 클래스
class ModelManager {
    
    private var todoGroup = [TodoItem]() // 해야할 todo 배열
    private var doneGroup = [TodoItem]() // 완료된 todo 배열
    
    var todoQuantity : Int { // 해야 할 todo 수 반환
        return todoGroup.count
    }
    var doneQuantity : Int { // 완료된 todo 수 반환
        return doneGroup.count
    }
        
    func addItem(_ item : TodoItem) {
        todoGroup.append(item)
    }
    
    func item(at index : Int) -> TodoItem {
        return todoGroup[index]
    }
    
    func doneItem(at index : Int) -> TodoItem {
        return doneGroup[index]
    }
    
    // MARK: - 섹션 이동 시 데이터 이동
    func checkItem(at index : Int) {
        let checkedTodo = todoGroup.remove(at: index)
        doneGroup.append(checkedTodo)
    }
    
    func uncheckItem(at index : Int) {
        let uncheckedTodo = doneGroup.remove(at: index)
        todoGroup.append(uncheckedTodo)
    }
    
    // MARK: - 셀 삭제시 해당 데이터 삭제
    func clearItem(at indexPath : IndexPath) {
        let section = indexPath.section, row = indexPath.row
        switch section {
        case 0 : todoGroup.remove(at: row)
        case 1 : doneGroup.remove(at: row)
        default : print("fail to delete cell")
        }
    }
}
