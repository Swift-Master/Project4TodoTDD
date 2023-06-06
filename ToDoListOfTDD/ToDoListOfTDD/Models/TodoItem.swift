
import Foundation
import CoreLocation

// MARK: - todo 데이터 모델
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
    
    // MARK: - 입력된 날짜를 원하는 문자열 형태로 변환합니다
    func dateToString(_ date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: date)
    }
    
}
