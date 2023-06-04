
import UIKit
import SnapKit
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
        setUI()
    }
    
    func setUI() {
        view.backgroundColor = .white
        guard let item = item else {
          return
        }
        setLabel(item)
        setMap(item)
    }
    
    func setLabel(_ item : TodoItem) {
        titleLabel.font = .boldSystemFont(ofSize: 32)
        titleLabel.text = item.title
        locationLabel.text = item.todoLocation?.name
        [titleLabel,locationLabel].forEach{view.addSubview($0)}
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            make.width.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(330)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(120)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setMap(_ item : TodoItem) {
        guard let currentCoordinate = item.todoLocation?.coordinate else {return}
        let coordinateRegion = MKCoordinateRegion(center: currentCoordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        map.setRegion(coordinateRegion, animated: true)
        view.addSubview(map)
        
        map.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    


}
