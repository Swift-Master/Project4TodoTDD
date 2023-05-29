import UIKit
import SnapKit
class TodoListViewController: UIViewController {
    
    private var todoTable : UITableView!
    
    var itemManager = ModelManager()
    var dataProvider = TodoListDataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTable()
        setNaviBar()
        setUI()
    }
    
    func setTable() {
        todoTable = UITableView()
        todoTable.dataSource = dataProvider
        todoTable.delegate = dataProvider
        dataProvider.itemManager = itemManager
        NotificationCenter.default.addObserver(self, selector: #selector(showDetailView), name: Notification.ItemSelectedNotification, object: nil)
    }
    
    func setNaviBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showTodoForm))
    }
    
    func setUI() {
        view.addSubview(todoTable)
        todoTable.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func showDetailView(_ sender : Notification) {
        guard let currentIndex = sender.userInfo?["index"] as? Int else {return}
        
        let currentItem = itemManager.item(at: currentIndex)
        let nextVC = DetailLocationViewController()
        nextVC.item = currentItem
        
        navigationController?.pushViewController(nextVC, animated: false)
        
    }
    
    @objc func showTodoForm() {
        let nextVC = TodoFormViewController()
        navigationController?.pushViewController(nextVC, animated: false)
    }


}

