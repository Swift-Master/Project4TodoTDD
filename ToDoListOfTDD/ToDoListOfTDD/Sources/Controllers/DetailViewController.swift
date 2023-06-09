//
//  DetailViewController.swift
//  ToDoListOfTDD
//
//  Created by 편성경 on 2023/06/09.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var data: Model?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setData()
    }
    
    func setData() {
        titleLabel.text = data?.title
        locationLabel.text = data?.location
        
        getMapData()
    }
    
    // MARK: - MapView 설정
    func getMapData() {
        let geocoder = CLGeocoder()
        
        let address = data!.location
        
        // 주소 -> 위도, 경도 변환
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let error = error {
                print("Geocoder Error : \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first {
                let location = placemark.location
                if let coordinate = location?.coordinate {
                    // 위치
                    let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                    
                    // 핀(Annotation)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
                    annotation.title = self.data?.title
                    annotation.subtitle = self.data?.description
                    
                    self.mapView.addAnnotation(annotation)
                    self.mapView.setRegion(region, animated: true)
                }
            }
        }
    }


}
