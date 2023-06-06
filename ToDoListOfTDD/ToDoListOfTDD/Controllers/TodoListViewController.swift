import UIKit
import SnapKit
class TodoListViewController: UIViewController {
    
    private var todoTable : UITableView!
    
    var itemManager = ModelManager()
    var dataProvider = TodoListDataProvider()
    lazy var doneButton = UIBarButtonItem(title:"Done",style: .done, target: self, action: #selector(editTable))
    
    lazy var editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTable))
    
    override func viewWillAppear(_ animated: Bool) {
        todoTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviBar()
        setTable()
        setUI()
    }
    
    func setTable() {
        todoTable = UITableView()
        todoTable.dataSource = dataProvider
        todoTable.delegate = dataProvider
        todoTable.backgroundColor = .white
        
        todoTable.register(TodoItemCell.self, forCellReuseIdentifier: TodoItemCell.cellIdentifier)
        dataProvider.itemManager = itemManager
        NotificationCenter.default.addObserver(self, selector: #selector(showDetailView), name: Notification.ItemSelectedNotification, object: nil)
    }
    
    func setNaviBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .white
        doneButton.tintColor = .systemRed
        navigationItem.leftBarButtonItem = editButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showTodoForm))
        navigationItem.scrollEdgeAppearance = navigationBarAppearance
        navigationItem.standardAppearance = navigationBarAppearance
        navigationItem.compactAppearance = navigationBarAppearance
        
        navigationController?.setNeedsStatusBarAppearanceUpdate()
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
        nextVC.itemManager = itemManager
        navigationController?.pushViewController(nextVC, animated: false)
    }
    
    @objc func editTable(_ sender : UIBarButtonItem) {
        let editState = !todoTable.isEditing
        todoTable.setEditing(editState, animated: true)
        if sender == editButton {
            navigationItem.leftBarButtonItem = doneButton
        }else {
            navigationItem.leftBarButtonItem = editButton
        }
    }
    
}
