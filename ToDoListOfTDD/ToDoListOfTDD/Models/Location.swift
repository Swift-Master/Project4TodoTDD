
import Foundation
import CoreLocation

// MARK: - 위치 정보 객체
class Location {
    
    var name : String?
    var coordinate : CLLocationCoordinate2D?
    
    // MARK: - 생성 시 이름으로 좌표를 얻어옵니다
    init(name: String?) {
        self.name = name
        forwardGeocoding(address: name)
    }
    
    // MARK: - Geocoder를 통해 문자열을 좌표로 변환합니다
    func forwardGeocoding(address: String?){
        let geocoder = CLGeocoder()
        guard let address = address else {return}
        
        geocoder.geocodeAddressString(address, completionHandler: {
            (placemarks, error) in
            if error != nil {
                print("Failed to retrieve location")
                return
            }
            
            var location: CLLocation?
            
            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }
            
            if let location = location {
                self.coordinate = location.coordinate
            }
            else
            {
                print("No Matching Location Found")
            }
        })
    }
}
