
import Foundation

extension Notification {
    static let ItemSelectedNotification = Notification.Name("ItemSelectedNotification")
}

enum TodoType : Int {
    case todo
    case done
}
