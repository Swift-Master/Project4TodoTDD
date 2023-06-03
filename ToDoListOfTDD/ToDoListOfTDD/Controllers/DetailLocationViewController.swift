//
//  DetailLocationViewController.swift
//  ToDoListOfTDD
//
//  Created by 최우태 on 2023/05/29.
//

import UIKit
import MapKit
class DetailLocationViewController: UIViewController {

    var item : TodoItem?
    var map = MKMapView()
    
    lazy var titleLabel = label
    lazy var locationLabel = label
    
    var label : UILabel {
        return {
            let label = UILabel()
            label.font = .systemFont(ofSize: 17)
            label.textAlignment = .center
            return label
        }()
    }

    
    override func viewDidLoad() {
      super.viewDidLoad()
      

        

    }
    
    func setUI() {
        guard let item = item else {
          return
        }
        titleLabel.text = item.title
        locationLabel.text = item.todoLocation?.name
    }
    
    func setMap() {
        
    }
    


}
