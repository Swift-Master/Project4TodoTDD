
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
            return label
        }()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .blue
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        [titleLabel,dateLabel,locationLabel].forEach{self.addSubview($0)}
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(100)
            make.centerY.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(30)
        }
        locationLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(120)
            make.centerY.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(30)
        }
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.centerY.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(30)
        }
    }
    
    
}
    
