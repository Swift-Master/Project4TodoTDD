//
//  Location.swift
//  ToDoListOfTDD
//
//  Created by 최우태 on 2023/06/01.
//

import Foundation
import CoreLocation
struct Location {
    var name : String?
    var coordinate : CLLocationCoordinate2D? {
        return forwardGeocoding(address: name)
    }
    
    init(name: String?) {
        self.name = name
    }
    
    func forwardGeocoding(address: String?) -> CLLocationCoordinate2D? {
        let geocoder = CLGeocoder()
        
        guard let address = address else {return nil}
        var coordinates : CLLocationCoordinate2D?
        geocoder.geocodeAddressString(address, completionHandler: { (placemarks, error) in
            if error != nil {
                print("Failed to retrieve location")
                return
            }
            
            var location: CLLocation?
            
            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }
            
            if let location = location {
                coordinates = location.coordinate
            }
            else
            {
                print("No Matching Location Found")
            }
        })
        return coordinates
    }
}
