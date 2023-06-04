//
//  Location.swift
//  ToDoListOfTDD
//
//  Created by 최우태 on 2023/06/01.
//

import Foundation
import CoreLocation
class Location {
    var name : String?
    var coordinate : CLLocationCoordinate2D?
    
    init(name: String?) {
        self.name = name
        forwardGeocoding(address: name)
    }
    
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
