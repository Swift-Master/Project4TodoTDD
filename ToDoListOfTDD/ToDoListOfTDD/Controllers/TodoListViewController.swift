import UIKit
import SnapKit

// MARK: - todo를 테이블 뷰로 보여주는 화면(root view)
class TodoListViewController: UIViewController {
    
    // MARK: - 전역 변수/상수
    var todoTable = UITableView()
    var itemManager = ModelManager()
    var dataProvider = TodoListDataProvider()
    lazy var doneButton = UIBarButtonItem(title:"Done",style: .done, target: self, action: #selector(editTable))
    lazy var editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTable))
    
    // MARK: - form 제출 후 돌아올 때 테이블이 갱신되도록 합니다
    override func viewWillAppear(_ animated: Bool) {
        todoTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviBarAttributes()
        setTableAttributes()
        setTableConstraints()
    }
    
    // MARK: - 셀 등록, 셀 선택 알림 수신, 모델 관리자 객체 등록
    func setTableAttributes() {
        dataProvider.itemManager = itemManager
        todoTable.dataSource = dataProvider
        todoTable.delegate = dataProvider
        todoTable.backgroundColor = .white
        todoTable.register(TodoItemCell.self, forCellReuseIdentifier: TodoItemCell.cellIdentifier)
        NotificationCenter.default.addObserver(self, selector: #selector(showDetailView), name: Notification.ItemSelectedNotification, object: nil)
    }
    
    // MARK: - 좌우 네비게이션 아이템 설정
    func setNaviBarAttributes() {
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
    
    func setTableConstraints() {
        view.addSubview(todoTable)
        todoTable.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - 알림을 통해 수신된 인덱스로 선택된 todo를 mapView 화면으로 전달 및 전환
    @objc func showDetailView(_ sender : Notification) {
        guard let currentIndex = sender.userInfo?["index"] as? Int else {return}
        let currentItem = itemManager.item(at: currentIndex)
        let nextVC = DetailLocationViewController()
        nextVC.item = currentItem
        
        navigationController?.pushViewController(nextVC, animated: false)
        
    }
    
    // MARK: - '+' 네비게이션 아이템 선택 시 form 작성 화면으로 전환
    @objc func showTodoForm() {
        let nextVC = TodoFormViewController()
        nextVC.itemManager = itemManager
        navigationController?.pushViewController(nextVC, animated: false)
    }
    
    // MARK: - 'edit' 네비게이션 아이템 선택 시 테이블 뷰 편집모드 토글
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
