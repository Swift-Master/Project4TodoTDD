
import Foundation
import CoreLocation
struct TodoItem {
    var title : String?
    var description : String?
    var todoDate : String?
    var todoLocation : Location?
    
    init(title: String, description: String, rawDate: Date, todoLocation: Location?) {
        self.title = title
        self.description = description
        self.todoDate = dateToString(rawDate)
        self.todoLocation = todoLocation
    }
    
    func dateToString(_ date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: date)
    }
    
}
