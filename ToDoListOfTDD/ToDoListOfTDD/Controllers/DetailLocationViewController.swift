
import UIKit
import SnapKit
import MapKit

// MARK: - todo의 장소를 지도에 표시해주는 화면
class DetailLocationViewController: UIViewController {
    
    // MARK: - 전역 변수/상수
    var item : TodoItem?
    var map = MKMapView()
    lazy var titleLabel = label
    lazy var locationLabel = label
    
    // MARK: - UILabel 생성 메서드
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
        setAttributes()
        setConstraints()
    }
    
    func setAttributes() {
        guard let item = item else {return}
        view.backgroundColor = .white
        setLabelAttributes(item)
        setMapAttributes(item)
    }
    
    func setConstraints() {
        setLabelConstraints()
        setMapConstraints()
    }
    
    // MARK: - 라벨 속성 설정
    func setLabelAttributes(_ item : TodoItem) {
        titleLabel.font = .boldSystemFont(ofSize: 32)
        titleLabel.text = item.title
        locationLabel.text = item.todoLocation?.name
    }
    
    // MARK: - MKMapView 속성 설정
    func setMapAttributes(_ item : TodoItem) {
        guard let currentCoordinate = item.todoLocation?.coordinate else {return}
        let coordinateRegion = MKCoordinateRegion(center: currentCoordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    // MARK: - 레이아웃 설정
    func setLabelConstraints() {
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
    
    func setMapConstraints() {
        view.addSubview(map)
        map.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    


}
