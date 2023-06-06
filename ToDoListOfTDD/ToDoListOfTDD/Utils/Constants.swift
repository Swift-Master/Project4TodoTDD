
import Foundation

// MARK: - 테이블 셀을 선택했을 때 발송되는 알람
extension Notification {
    static let ItemSelectedNotification = Notification.Name("ItemSelectedNotification")
}


// MARK: - 섹션 구분을 위한 열거형 선언
enum TodoType : Int {
    case todo
    case done
}
