
import UIKit

// MARK: - 테이블 뷰 프로토콜 메서드가 구현된 클래스
class TodoListDataProvider : NSObject {
    var itemManager : ModelManager?
}

extension TodoListDataProvider : UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // MARK: - 현재 섹션의 row 수를 계산하여 반환합니다
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
    
    
    
    // MARK: - 각 셀에 todo 제목, 장소, 날짜를 할당합니다.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoItemCell.cellIdentifier) as! TodoItemCell
        guard let itemManager = itemManager else {return cell}
        var currentItem : TodoItem
        
        switch TodoType(rawValue: indexPath.section) {
        case .todo : currentItem = itemManager.item(at: indexPath.row)
        case .done : currentItem = itemManager.doneItem(at: indexPath.row)
        default : fatalError()
        }
        cell.titleLabel.text = currentItem.title
        cell.locationLabel.text = currentItem.todoLocation?.name
        cell.dateLabel.text = currentItem.todoDate
        return cell
    }
    
    // MARK: - 셀이 선택되었을 때 row 정보를 담아 알림을 발송합니다
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if TodoType(rawValue: indexPath.section) == .done {return}
        
        NotificationCenter.default.post(name: Notification.ItemSelectedNotification, object: self,userInfo: ["index":indexPath.row])
        
    }
    
    // MARK: - 테이블 뷰 편집모드에서 셀 삭제기능
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let manager = itemManager else {return}
        
        // MARK: - deleteRows는 참조 배열 데이터는 삭제하지 않아 배열 데이터 먼저 지우기
        if editingStyle == .delete {
            manager.clearItem(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        tableView.reloadData()
    }
    
    // MARK: - 섹션 별 구분을 위한 제목을 지정합니다
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let manager = itemManager else {return nil}
        var sectionTitle : String?
        switch TodoType(rawValue: section) {
        case .done : sectionTitle = "완료한 일(\(manager.doneQuantity))"
        case .todo : sectionTitle = "해야 할 일(\(manager.todoQuantity))"
        default : fatalError()
        }
        return sectionTitle
    }
    
    // MARK: - 테이블 뷰 편집모드에서 셀을 움직일 수 있게 해줍니다
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // MARK: - 섹션 간 이동 시 실제 데이터를 옮겨줍니다
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard let manager = itemManager else {return}
        if sourceIndexPath.section < destinationIndexPath.section {
            manager.checkItem(at: sourceIndexPath.row)
        } else {
            manager.uncheckItem(at: destinationIndexPath.row)
        }
            tableView.reloadData()
    }
}
