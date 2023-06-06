
import UIKit
import SnapKit
class TodoItemCell: UITableViewCell {
    static let cellIdentifier = "todoItem"
    lazy var titleLabel = label
    lazy var locationLabel = label
    lazy var dateLabel = label
    
    var label : UILabel {
        return {
            let label = UILabel()
            label.font = .systemFont(ofSize: 17)
            label.textAlignment = .left
            label.numberOfLines = 2
            return label
        }()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        [titleLabel,dateLabel,locationLabel].forEach{contentView.addSubview($0)}
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(80)
            make.centerY.equalToSuperview()
            make.top.equalToSuperview().offset(30)
        }
        locationLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(20)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.top.equalToSuperview().offset(30)
        }
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(locationLabel.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
            make.top.equalToSuperview().offset(30)
        }
    }
    
    
}
    
